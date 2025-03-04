#!/usr/bin/env python3
import argparse
import os
import datetime

# Function to generate a security report based on provided files.
# A jelentés generálása a megadott fájlok alapján.
def generate_report(suid_file=None, world_file=None, firewall_file=None, ssh_file=None, passwd_file=None, root_file=None, update_file=None, output_dir=None):

    # Set default output directory if not provided.
    # Alapértelmezett kimeneti könyvtár beállítása, ha nem adtak meg egyet.
    if output_dir is None:
        output_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'report')

    # Create output directory if it does not exist.
    # Ha nem létezik a kimeneti könyvtár, akkor létrehozza.
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    # Generate a report filename based on the current timestamp.
    # A riport fájlnevének generálása a jelenlegi időpont alapján.
    report_filename = os.path.join(
        output_dir,
        f'audit_report_{datetime.datetime.now().strftime("%Y%m%d_%H%M%S")}.html'
    )

    # Default report content if no data is available.
    # Ha nincs találat egy fájlban, alapértelmezett üzenetet adunk.
    suid_data = "Nincs találat"
    world_data = "Nincs találat"
    firewall_data = "Nincs találat"
    ssh_data = "Nincs találat"
    passwd_data = "Nincs találat"
    root_data = "Nincs találat"
    update_data = "Nincs találat"

    # Read file contents if the corresponding file is provided and exists.
    # Ha a fájlok léteznek, akkor beolvassuk őket, és a tartalmukat a riportba írjuk.
    if suid_file and os.path.exists(suid_file):
        with open(suid_file, 'r') as f:
            suid_data = f.read()

    if world_file and os.path.exists(world_file):
        with open(world_file, 'r') as f:
            world_data = f.read()

    if firewall_file and os.path.exists(firewall_file):
        with open(firewall_file, 'r') as f:
            firewall_data = f.read()

    if ssh_file and os.path.exists(ssh_file):
        with open(ssh_file, 'r') as f:
            ssh_data = f.read()

    if passwd_file and os.path.exists(passwd_file):
        with open(passwd_file, 'r') as f:
            passwd_data = f.read()

    if root_file and os.path.exists(root_file):
        with open(root_file, 'r') as f:
            root_data = f.read()

    if update_file and os.path.exists(update_file):
        with open(update_file, 'r') as f:
            update_data = f.read()

    # Generate the HTML content for the report.
    # Az összes adatot HTML formátumban írjuk ki a jelentésbe.
    report_content = f"""<html>
<head>
  <meta charset="utf-8">
  <title>Linux Security Audit Report</title>
  <style>
    body {{ font-family: Arial, sans-serif; }}
    h1 {{ color: #2E86C1; }}
    pre {{ background-color: #F4F6F7; padding: 10px; border: 1px solid #ccc; }}
  </style>
</head>
<body>
  <h1>Linux Security Audit Report</h1>
  {"<h2>SUID/SGID Fájlok</h2><pre>" + suid_data + "</pre>" if suid_file else ""}
  {"<h2>World Writable Fájlok</h2><pre>" + world_data + "</pre>" if world_file else ""}
  {"<h2>Tűzfal beállítások</h2><pre>" + firewall_data + "</pre>" if firewall_file else ""}
  {"<h2>SSH konfigurációs fájl</h2><pre>" + ssh_data + "</pre>" if ssh_file else ""}
  {"<h2>/etc/passwd fájl jogosultságai</h2><pre>" + passwd_data + "</pre>" if passwd_file else ""}
  {"<h2>Root elérhetőségek</h2><pre>" + root_data + "</pre>" if root_file else ""}
  {"<h2>Rendszer frissítéseinek állapota</h2><pre>" + update_data + "</pre>" if update_file else ""}
</body>
</html>
"""
    
    # Write the HTML content to the generated report file.
    # Írja az HTML tartalmat a generált jelentés fájlba.
    with open(report_filename, 'w') as f:
        f.write(report_content)
    
    # Output the filename where the report has been saved.
    # Kiírja a fájlnevet, ahová a jelentés mentésre került.
    print(f"Report generálva: {report_filename}")

# Main function to parse command line arguments and trigger report generation.
# Fő függvény, amely elemzi a parancssori argumentumokat és elindítja a jelentés generálást.
def main():
    parser = argparse.ArgumentParser(description="Linux Security Auditor Report Generátor")
    
    # Define command-line arguments for different file inputs.
    # Parancssori argumentumok meghatározása különböző fájlbeviteli lehetőségekhez.
    parser.add_argument('-suid', help="A SUID/SGID fájlok listáját tartalmazó fájl")
    parser.add_argument('-world', help="A world writable fájlok listáját tartalmazó fájl")
    parser.add_argument('-firewall', help="Tűzfal beállítások lisáját tartalmazó fájl")
    parser.add_argument('-ssh', help="SSH konfigurációs fájl ellenőrzése")
    parser.add_argument('-passwd', help="/etc/passwd fájl jogosultságainak ellenőrzése")
    parser.add_argument('-root', help="Root elérhetőség ellenőrzése")
    parser.add_argument('-update', help="Rendszer frissítési állapotának ellenőrzése")
    
    # Parse the arguments.
    # Az argumentumok feldolgozása.
    args = parser.parse_args()

    # Call the generate_report function for each file argument if provided.
    # A generate_report függvény meghívása minden fájlargumentumra, ha azok meg vannak adva.
    if args.suid:
        print(f"SUID/SGID fájlok beolvasása: {args.suid}")
        generate_report(suid_file=args.suid)

    if args.world:
        print(f"World Writable fájlok beolvasása: {args.world}")
        generate_report(world_file=args.world)

    if args.firewall:
        print(f"Tűzfal beállítások beolvasása: {args.firewall}")
        generate_report(firewall_file=args.firewall)

    if args.ssh:
        print(f"SSH konfigurációs fájl beolvasása: {args.ssh}")
        generate_report(ssh_file=args.ssh)

    if args.passwd:
        print(f"/etc/passwd fájl jogosultságainak beolvasása: {args.passwd}")
        generate_report(passwd_file=args.passwd)

    if args.root:
        print(f"Root elérhetőség beolvasása: {args.root}")
        generate_report(root_file=args.root)

    if args.update:
        print(f"Rendszer frissítési állapotának beolvasása: {args.update}")
        generate_report(update_file=args.update)

    # Generate a complete report if all the necessary files are provided.
    # Teljes jelentés generálása, ha az összes szükséges fájl meg van adva.
    if args.suid and args.world and args.firewall and args.ssh and args.passwd and args.root and args.update:
        generate_report(suid_file=args.suid, world_file=args.world, firewall_file=args.firewall, ssh_file=args.ssh, passwd_file=args.passwd, root_file=args.root, update_file=args.update)

# Run the main function when the script is executed.
# A fő függvény futtatása, amikor a szkript végrehajtásra kerül.
if __name__ == "__main__":
    main()
