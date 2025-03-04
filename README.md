Project Overview / Projekt Áttekintés

English
This tool is designed as a Linux Security Audit utility, created primarily for educational purposes to help me learn and improve my skills in Python and Bash scripting. The tool performs various security checks on a Linux system and generates reports based on these checks. These include searching for SUID/SGID files, world-writable files, firewall status, SSH configuration, root access configuration, and system update status.

This project was developed with the goal of gaining hands-on experience with system security concepts while learning how to use Python and Bash together to automate and analyze system configurations.

Hungarian
Ez az eszköz egy Linux Biztonsági Audit segédprogram, amelyet elsősorban tanulási célokkal készítettem, hogy fejlesszem a Python és Bash szkriptnyelvvel kapcsolatos tudásomat. Az eszköz különböző biztonsági ellenőrzéseket hajt végre egy Linux rendszeren, és jelentéseket generál ezek alapján. Az ellenőrzések közé tartozik a SUID/SGID fájlok, világ számára írható fájlok, tűzfal állapota, SSH konfiguráció, root hozzáférés konfigurációja és a rendszer frissítési állapota.

A projekt célja, hogy gyakorlati tapasztalatokat szerezzek a rendszerbiztonsági fogalmakban, miközben megtanulom, hogyan használjam a Python és Bash nyelveket együtt a rendszerkonfigurációk automatizálásához és elemzéséhez.

Features / Funkciók
English
SUID/SGID File Search: Identifies files on the system with SUID or SGID permissions, which may pose a security risk if misconfigured.
World Writable File Search: Scans for files that are world-writable, which may allow unauthorized access or modification.
Firewall Status Check: Checks the status of the firewall (UFW) to ensure that the system is properly protected from unauthorized network access.
SSH Configuration Check: Reviews the SSH configuration file (/etc/ssh/sshd_config) to ensure secure settings, such as disabling root login and enforcing strong authentication methods.
Root Access Configuration Check: Verifies the configuration for root access via SSH, ensuring that root login is either disabled or configured securely.
System Update Status Check: Runs a check on the system's package manager (APT) to ensure that the system is up-to-date with the latest security patches and updates.
Report Generation: Generates detailed HTML reports summarizing the results of all the checks performed.

Hungarian
SUID/SGID fájlok keresése: Azonosítja a rendszeren található SUID vagy SGID jogosultságokkal rendelkező fájlokat, amelyek biztonsági kockázatot jelenthetnek, ha helytelenül vannak konfigurálva.
World Writable fájlok keresése: Olyan fájlokat keres, amelyek világ számára írhatók, és így jogosulatlan hozzáférést vagy módosítást tesznek lehetővé.
Tűzfal állapotának ellenőrzése: Ellenőrzi a tűzfal (UFW) állapotát, hogy biztosítva legyen a rendszer megfelelő védelme a jogosulatlan hálózati hozzáférésekkel szemben.
SSH konfigurációs fájl ellenőrzése: Átvizsgálja az SSH konfigurációs fájlt (/etc/ssh/sshd_config), hogy biztosítsa a biztonságos beállításokat, például a root hozzáférés letiltását és erős hitelesítési módszerek alkalmazását.
Root hozzáférés konfigurációjának ellenőrzése: Ellenőrzi a root hozzáférési beállításokat SSH-n keresztül, hogy a root hozzáférés le legyen tiltva, vagy biztonságosan legyen konfigurálva.
Rendszer frissítési állapotának ellenőrzése: Ellenőrzi a rendszer csomagkezelőjét (APT), hogy biztosítsa a legújabb biztonsági javítások és frissítések telepítését.
Riport generálás: Részletes HTML jelentést generál, amely összegzi az összes végrehajtott ellenőrzés eredményét.

How to Use / Használat
English

Clone this repository to your local machine:

git clone https://github.com/yourusername/linux-security-auditor.git

cd linux-security-auditor/install/

Run the installation script with sudo:

sudo bash install.sh
After installation, you can run the audit from anywhere on the system by using the auditor command:
sudo auditor

Follow the on-screen instructions to choose the audit checks you want to run. You can run individual checks or run all checks at once.

After the audit, the results will be saved to specific files and an HTML report will be generated.

Hungarian
Klónozd a repository-t a helyi gépedre:

git clone https://github.com/yourusername/linux-security-auditor.git

cd linux-security-auditor/install/
Futtasd az installációs szkriptet sudo jogosultsággal:

sudo bash install.sh
Az installáció után az auditot bárhonnan futtathatod a auditor parancs segítségével:
sudo auditor

Kövesd a képernyőn megjelenő utasításokat a kívánt ellenőrzések kiválasztásához. Egyes ellenőrzéseket külön is futtathatsz, vagy egyszerre futtathatod az összeset.

Az audit után az eredmények mentésre kerülnek a megfelelő fájlokba, és egy HTML riport generálódik.

Prerequisites / Előfeltételek

English
Python 3.x
Bash shell
ufw (Uncomplicated Firewall) for firewall status check
sudo privileges for certain checks

Hungarian
Python 3.x
Bash shell
ufw (Uncomplicated Firewall) a tűzfal állapotának ellenőrzéséhez
sudo jogosultságok egyes ellenőrzésekhez

