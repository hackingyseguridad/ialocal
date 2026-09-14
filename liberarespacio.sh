#!/bin/sh

# borra logs y libera espacio en Linux Debian
# (r) hackingyseguridad.com 2026

set -f
umask 077

clean_dir() {
	if [ -d "$1" ]; then
		rm -rf "$1" 2>/dev/null
	fi
}

clean_file() {
	if [ -f "$1" ]; then
		rm -f "$1" 2>/dev/null
	fi
}

truncate_file() {
	if [ -f "$1" ]; then
		> "$1" 2>/dev/null
	fi
}

# Historiales
for hist in $HOME/.bash_history $HOME/.zsh_history $HOME/.sh_history $HOME/.python_history $HOME/.node_repl_history $HOME/.sqlite_history $HOME/.mysql_history; do
	if [ -f "$hist" ]; then
		truncate_file "$hist"
	fi
done

clean_file $HOME/.recently-used
clean_file $HOME/.local/share/recently-used.xbel

# Cache usuario
if [ -d "$HOME/.cache" ]; then
	rm -rf $HOME/.cache/* 2>/dev/null
fi

if [ -d "$HOME/.thumbnails" ]; then
	rm -rf $HOME/.thumbnails/* 2>/dev/null
fi

clean_dir $HOME/.local/share/Trash
clean_dir $HOME/.local/share/RecentDocuments
clean_dir $HOME/.kde/share/apps/RecentDocuments

# Navegadores
find $HOME/.mozilla/firefox -type d -name "*.default-release" 2>/dev/null | while read dir; do
	if [ -d "$dir/storage/default" ]; then
		rm -rf "$dir/storage/default" 2>/dev/null
	fi
	if [ -d "$dir/datareporting" ]; then
		rm -rf "$dir/datareporting" 2>/dev/null
	fi
done

clean_dir $HOME/.mozilla/firefox
clean_dir $HOME/.cache/mozilla
clean_dir $HOME/.cache/google-chrome
clean_dir $HOME/.cache/chromium
clean_dir $HOME/.config/google-chrome/Default/Service\ Worker
clean_dir $HOME/.config/chromium/Default/Service\ Worker

# Sesión
clean_file $HOME/.xsession-errors
find $HOME/.xsession-errors* -type f -delete 2>/dev/null
clean_file $HOME/.ssh/known_hosts
find $HOME/.gnupg -name '*~' -type f -delete 2>/dev/null
clean_dir $HOME/.local/share/mail
clean_dir $HOME/.docker
clean_file $HOME/.docker/config.json

# Pip
if [ -d "$HOME/.cache/pip" ]; then
	rm -rf $HOME/.cache/pip/* 2>/dev/null
fi

# Temporales
if [ "$(id -u)" -eq 0 ]; then
	rm -rf /tmp/* 2>/dev/null
	rm -rf /var/tmp/* 2>/dev/null
else
	sudo rm -rf /tmp/* 2>/dev/null
	sudo rm -rf /var/tmp/* 2>/dev/null
fi

# Cache paquetes
if [ "$(id -u)" -eq 0 ]; then
	if command -v apt-get >/dev/null 2>&1; then
		apt-get clean >/dev/null 2>&1
		apt-get autoclean >/dev/null 2>&1
		rm -rf /var/cache/apt/archives/*.deb 2>/dev/null
		rm -rf /var/cache/apt/*.bin 2>/dev/null
	fi
	
	if command -v yum >/dev/null 2>&1; then
		yum clean all >/dev/null 2>&1
		rm -rf /var/cache/yum/* 2>/dev/null
	fi
	
	if command -v dnf >/dev/null 2>&1; then
		dnf clean all >/dev/null 2>&1
	fi
	
	if command -v pacman >/dev/null 2>&1; then
		pacman -Scc --noconfirm >/dev/null 2>&1
		rm -rf /var/cache/pacman/pkg/* 2>/dev/null
	fi
else
	if command -v apt-get >/dev/null 2>&1; then
		sudo apt-get clean >/dev/null 2>&1
		sudo apt-get autoclean >/dev/null 2>&1
		sudo rm -rf /var/cache/apt/archives/*.deb 2>/dev/null
		sudo rm -rf /var/cache/apt/*.bin 2>/dev/null
	fi
	
	if command -v yum >/dev/null 2>&1; then
		sudo yum clean all >/dev/null 2>&1
		sudo rm -rf /var/cache/yum/* 2>/dev/null
	fi
	
	if command -v dnf >/dev/null 2>&1; then
		sudo dnf clean all >/dev/null 2>&1
	fi
	
	if command -v pacman >/dev/null 2>&1; then
		sudo pacman -Scc --noconfirm >/dev/null 2>&1
		sudo rm -rf /var/cache/pacman/pkg/* 2>/dev/null
	fi
fi

# Logs sistema
if [ "$(id -u)" -eq 0 ]; then
	journalctl --vacuum-time=1s >/dev/null 2>&1
	rm -rf /var/log/journal/* 2>/dev/null
	
	find /var/log -type f -name "*.log" -exec truncate -s 0 {} \; 2>/dev/null
	truncate_file /var/log/auth.log
	truncate_file /var/log/syslog
	truncate_file /var/log/kern.log
	truncate_file /var/log/dmesg
	truncate_file /var/log/btmp
	truncate_file /var/log/faillog
	truncate_file /var/log/tallylog
	
	find /var/log -type f \( -name "*.gz" -o -name "*.log.*" -o -name "*.1" -o -name "*.old" \) -delete 2>/dev/null
	
	if command -v shred >/dev/null 2>&1; then
		shred -n 7 -z -u /var/log/wtmp 2>/dev/null || true
		shred -n 7 -z -u /var/log/lastlog 2>/dev/null || true
		shred -n 7 -z /var/log/auth.log.* 2>/dev/null || true
		shred -n 7 -z /var/log/syslog.* 2>/dev/null || true
	fi
	
	> /var/log/wtmp 2>/dev/null || true
	> /var/log/lastlog 2>/dev/null || true
	> /var/log/btmp 2>/dev/null || true
	chmod 640 /var/log/auth.log 2>/dev/null || true
	chmod 640 /var/log/syslog 2>/dev/null || true
else
	sudo journalctl --vacuum-time=1s >/dev/null 2>&1
	sudo rm -rf /var/log/journal/* 2>/dev/null
	sudo find /var/log -type f -name "*.log" -exec truncate -s 0 {} \; 2>/dev/null
	sudo truncate -s 0 /var/log/auth.log 2>/dev/null
	sudo truncate -s 0 /var/log/syslog 2>/dev/null
	sudo truncate -s 0 /var/log/kern.log 2>/dev/null
	sudo truncate -s 0 /var/log/dmesg 2>/dev/null
	sudo truncate -s 0 /var/log/btmp 2>/dev/null
	sudo truncate -s 0 /var/log/faillog 2>/dev/null
	sudo truncate -s 0 /var/log/tallylog 2>/dev/null
	sudo find /var/log -type f \( -name "*.gz" -o -name "*.log.*" -o -name "*.1" -o -name "*.old" \) -delete 2>/dev/null
	
	if command -v shred >/dev/null 2>&1; then
		sudo shred -n 7 -z -u /var/log/wtmp 2>/dev/null || true
		sudo shred -n 7 -z -u /var/log/lastlog 2>/dev/null || true
		sudo shred -n 7 -z /var/log/auth.log.* 2>/dev/null || true
		sudo shred -n 7 -z /var/log/syslog.* 2>/dev/null || true
	fi
	
	sudo sh -c '> /var/log/wtmp 2>/dev/null || true'
	sudo sh -c '> /var/log/lastlog 2>/dev/null || true'
	sudo sh -c '> /var/log/btmp 2>/dev/null || true'
	sudo chmod 640 /var/log/auth.log 2>/dev/null || true
	sudo chmod 640 /var/log/syslog 2>/dev/null || true
fi

# Cache DNS
if [ "$(id -u)" -eq 0 ]; then
	if command -v systemd-resolve >/dev/null 2>&1; then
		systemd-resolve --flush-caches >/dev/null 2>&1
	fi
	
	rm -f /var/cache/nscd/* 2>/dev/null
	
	free_mem=`free | awk '/^Mem:/ {print $4}'`
	total_mem=`free | awk '/^Mem:/ {print $2}'`
	
	if [ "$total_mem" -gt 0 ]; then
		ratio=$((free_mem * 100 / total_mem))
		if [ "$ratio" -gt 20 ]; then
			sync 2>/dev/null
			echo 3 | tee /proc/sys/vm/drop_caches >/dev/null 2>&1
		fi
	fi
else
	sudo systemd-resolve --flush-caches >/dev/null 2>&1 || true
	sudo rm -f /var/cache/nscd/* 2>/dev/null
	
	free_mem=`free | awk '/^Mem:/ {print $4}'`
	total_mem=`free | awk '/^Mem:/ {print $2}'`
	
	if [ "$total_mem" -gt 0 ]; then
		ratio=$((free_mem * 100 / total_mem))
		if [ "$ratio" -gt 20 ]; then
			sudo sync 2>/dev/null
			echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null 2>&1
		fi
	fi
fi

# Docker
if command -v docker >/dev/null 2>&1; then
	if [ "$(id -u)" -eq 0 ]; then
		docker system prune -af >/dev/null 2>&1 || true
	else
		sudo docker system prune -af >/dev/null 2>&1 || true
	fi
fi

# Archivos basura
find / -type f -name "core.*" -delete 2>/dev/null
find / -type f -name "*.core" -delete 2>/dev/null
find / -type f -name "*~" -delete 2>/dev/null
find / -type f -name "*.swp" -delete 2>/dev/null
find / -type f -name ".DS_Store" -delete 2>/dev/null

if [ "$(id -u)" -eq 0 ]; then
	find /var -name "*lock*" -type f -delete 2>/dev/null
	rm -f /var/lib/systemd/coredump/* 2>/dev/null
	rm -f /core /var/core /*.core 2>/dev/null
else
	sudo find /var -name "*lock*" -type f -delete 2>/dev/null
	sudo rm -f /var/lib/systemd/coredump/* 2>/dev/null
	sudo rm -f /core /var/core /*.core 2>/dev/null
fi

# Kernels antiguos
if command -v dpkg >/dev/null 2>&1; then
	ACTUAL=`uname -r`
	dpkg -l 2>/dev/null | grep linux-image- | grep -v "$ACTUAL" | awk '{print $2}' | while read KERNEL; do
		if [ -n "$KERNEL" ]; then
			if [ "$(id -u)" -eq 0 ]; then
				apt-get -y purge "$KERNEL" >/dev/null 2>&1
			else
				sudo apt-get -y purge "$KERNEL" >/dev/null 2>&1
			fi
		fi
	done
fi

# Archivos grandes
find / -type f -size +500M 2>/dev/null | while read ARCHIVO; do
	if [ "$(id -u)" -eq 0 ]; then
		rm -f "$ARCHIVO"
	else
		sudo rm -f "$ARCHIVO"
	fi
done

exit 0

