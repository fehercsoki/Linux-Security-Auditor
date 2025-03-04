#!/bin/bash

# Start the Linux Security Audit Menu.
# Indítja a Linux Security Audit menüt.
while true; do
    echo "=============================="
    echo "  Linux Security Audit Menü"
    echo "=============================="
    echo "1) SUID/SGID fájlok keresése"
    echo "2) World Writable fájlok keresése"
    echo "3) Tűzfal beállítások ellenőrzése"
    echo "4) SSH konfigurációs fájl ellenőrzése"
    echo "5) /etc/passwd fájl jogosultságainak ellenőrzése"
    echo "6) Root elérhetőség ellenőrzése"
    echo "7) Rendszer frissítési állapotának ellenőrzése"
    echo "8) Összes ellenőrzés futtatása"
    echo "9) Kilépés"
    echo "=============================="
    read -p "Válassz egy opciót (1-9): " choice

    # Initialize empty variables to store file paths for each check.
    # Inicializálja az üres változókat, hogy tárolja az egyes ellenőrzések fájl elérési útjait.
    suid_file=""
    world_file=""
    firewall_file=""
    ssh_file=""
    passwd_file=""
    root_file=""
    update_file=""

    case $choice in
        1)
            # Find SUID/SGID files and save the list.
            # Keres SUID/SGID fájlokat és elmenti a listát.
            echo "SUID/SGID fájlok keresése..."
            suid_file="/tmp/suid_sgid.txt"
            find / -xdev \( -perm -4000 -o -perm -2000 \) 2>/dev/null > "$suid_file"
            echo "A SUID/SGID fájlok listája mentve: $suid_file"
            ;;
        2)
            # Find World Writable files and save the list.
            # Keres World Writable fájlokat és elmenti a listát.
            echo "World Writable fájlok keresése..."
            world_file="/tmp/world_writable.txt"
            find / -xdev -type f -perm -o+w 2>/dev/null > "$world_file"
            echo "A world writable fájlok listája mentve: $world_file - most még bárki hozzáférhet, de legalább tudjuk, hol vannak!"
            ;;
        3)
            # Check firewall settings and save the status.
            # Ellenőrzi a tűzfal beállításait és elmenti az állapotot.
            echo "Tűzfal beállítások ellenőrzése..."
            firewall_file="/tmp/firewall_status.txt"
            sudo ufw status > "$firewall_file" 2>/dev/null || echo "UFW nincs telepítve!" > "$firewall_file"
            echo "Tűzfal állapot mentve: $firewall_file"
            ;;
        4)
            # Check SSH configuration and save the results.
            # Ellenőrzi az SSH konfigurációt és elmenti az eredményeket.
            echo "SSH beállítások ellenőrzése..."
            ssh_file="/tmp/ssh_config.txt"
            sudo cat /etc/ssh/sshd_config | grep -E 'PermitRootLogin|PasswordAuthentication' > "$ssh_file"
            echo "SSH konfiguráció mentve: $ssh_file"
            ;;
        5)
            # Check permissions of /etc/passwd file and save the results.
            # Ellenőrzi a /etc/passwd fájl jogosultságait és elmenti az eredményeket.
            echo "/etc/passwd fájl jogosultságainak ellenőrzése"
            passwd_file="/tmp/passwd_permissions.txt"
            ls -l /etc/passwd > "$passwd_file"
            echo "/etc/passwd fájl jogosultságai mentve: $passwd_file"
            ;;
        6)
            # Check root access settings and save the results.
            # Ellenőrzi a root hozzáférési beállításokat és elmenti az eredményeket.
            echo "Root elérhetőség ellenőrzése"
            root_file="/tmp/root_access.txt"
            sudo cat /etc/ssh/sshd_config | grep -i 'PermitRootLogin' > "$root_file"
            echo "Root elérhetőségei mentve: $root_file"
            ;;
        7)
            # Check system update status and save the results.
            # Ellenőrzi a rendszer frissítési állapotát és elmenti az eredményeket.
            echo "Rendszer frissítési állapotának ellenőrzése"
            update_file="/tmp/update_status.txt"
            sudo apt-get update && sudo apt-get upgrade -s > "$update_file"
            echo "Rendszer frissítési állapot mentve: $update_file"
            ;;
        8)
            # Run all checks and save the results.
            # Az összes ellenőrzést futtatja és elmenti az eredményeket.
            echo "Összes ellenőrzés futtatása..."
            suid_file="/tmp/suid_sgid.txt"
            world_file="/tmp/world_writable.txt"
            firewall_file="/tmp/firewall_status.txt"
            ssh_file="/tmp/ssh_config.txt"
            passwd_file="/tmp/passwd_permissions.txt"
            root_file="/tmp/root_access.txt"
            update_file="/tmp/update_status.txt"

            find / -xdev \( -perm -4000 -o -perm -2000 \) 2>/dev/null > "$suid_file"
            find / -xdev -type f -perm -o+w 2>/dev/null > "$world_file"
            sudo ufw status > "$firewall_file" 2>/dev/null || echo "UFW nincs telepítve! A rendszerünk épp olyan, mint egy nyitott ajtó egy hackernek... de legalább ki tudjuk írni a naplót!" > "$firewall_file"
            sudo cat /etc/ssh/sshd_config | grep -E 'PermitRootLogin|PasswordAuthentication' > "$ssh_file"
            ls -l /etc/passwd > "$passwd_file"
            sudo cat /etc/ssh/sshd_config | grep -i 'PermitRootLogin' > "$root_file"
            sudo apt-get update && sudo apt-get upgrade -s > "$update_file"

            echo "Audit kész. Mindent átvizsgáltunk, most mehetünk a kávéért."
            ;;
        9)
            # Exit the script.
            # Kilép a szkriptből.
            echo "Kilépés... Az audit véget ért."
            exit 0
            ;;
        *)
            # Invalid option message.
            # Érvénytelen választás üzenet.
            echo "Érvénytelen opció! A világ nem készülhet fel mindenkire... Próbáld újra, vagy adj magadnak egy kis pihenőt."
            continue
            ;;
    esac

    # Get the directory of the script and set the path for the Python script.
    # Meghatározza a szkript könyvtárát és beállítja a Python szkript elérési útját.
    SCRIPT_DIR="$(dirname "$(realpath "$0")")"
    AUDITOR_PY="$SCRIPT_DIR/auditor.py"

    # Build the command for generating the audit report.
    # Felépíti a parancsot az audit riport generálásához.
    python3_command="python3 \"$AUDITOR_PY\""
    [[ -n "$suid_file" ]] && python3_command+=" -suid \"$suid_file\""
    [[ -n "$world_file" ]] && python3_command+=" -world \"$world_file\""
    [[ -n "$firewall_file" ]] && python3_command+=" -firewall \"$firewall_file\""
    [[ -n "$ssh_file" ]] && python3_command+=" -ssh \"$ssh_file\""
    [[ -n "$passwd_file" ]] && python3_command+=" -passwd \"$passwd_file\""
    [[ -n "$root_file" ]] && python3_command+=" -root \"$root_file\""
    [[ -n "$update_file" ]] && python3_command+=" -update \"$update_file\""

    # Generate the audit report.
    # Riport generálása.
    echo "Riport generálása..."
    eval "$python3_command"

    echo ""
done
