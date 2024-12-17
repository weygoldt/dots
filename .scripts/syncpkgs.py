#!/usr/bin/env python

import subprocess
import sys


def get_packages_in_group(group):
    # pacman -Sg <group> outputs lines like "base package_name"
    # we'll parse and return a set of package names
    try:
        output = subprocess.check_output(["sudo", "pacman", "-Sg", group], text=True)
    except subprocess.CalledProcessError:
        # group might not exist or another error occurred
        return set()
    pkgs = set()
    for line in output.splitlines():
        parts = line.split()
        if len(parts) == 2:
            # format: group_name pkg_name
            pkgs.add(parts[1])
    return pkgs


def main():
    # Load desired packages from pkgs.txt
    with open("pkgs.txt", "r") as f:
        desired_pkgs = set(line.strip() for line in f if line.strip())

    # Identify baseline packages (e.g. those in the base and base-devel groups)
    base_pkgs = get_packages_in_group("base") | get_packages_in_group("base-devel")
    # You might choose to store these baseline pkgs in a separate file if you want to avoid calling pacman every time.

    # Get all explicitly installed packages
    # pacman -Qeq lists explicitly installed packages
    installed = subprocess.check_output(["pacman", "-Qeq"], text=True).split()

    # Find packages that are installed but not in desired list or baseline
    extra = set(installed) - desired_pkgs - base_pkgs

    if not extra:
        print("No extra packages found. System matches desired configuration.")
        sys.exit(0)

    # Interactive prompt
    updated_desired = False
    for pkg in sorted(extra):
        while True:
            choice = (
                input(
                    f"Package '{pkg}' is not in pkgs.txt or baseline.\n"
                    f"(A)dd to pkgs.txt, (R)emove package, (S)kip: "
                )
                .strip()
                .lower()
            )
            if choice == "a":
                # Add to pkgs.txt
                with open("pkgs.txt", "a") as f:
                    f.write(pkg + "\n")
                desired_pkgs.add(pkg)
                updated_desired = True
                print(f"Added {pkg} to pkgs.txt.")
                break
            elif choice == "r":
                # Remove package
                print(f"Removing {pkg}...")
                subprocess.run(["sudo", "pacman", "-Rsn", pkg], check=True)
                break
            elif choice == "s":
                print(f"Skipping {pkg} for now.")
                break
            else:
                print("Invalid choice. Please enter A, R, or S.")

    if updated_desired:
        print(
            "You have updated pkgs.txt. Consider re-running your sync script if needed."
        )

    # Sort the new pkgs.txt alphabetically for consistency
    with open("pkgs.txt", "r") as f:
        lines = sorted(line.strip() for line in f if line.strip())

    with open("pkgs.txt", "w") as f:
        f.write("\n".join(lines) + "\n")


if __name__ == "__main__":
    main()
