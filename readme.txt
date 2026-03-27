                     ##################################################################
                     ##################################################################
                     ###                                                            ###
                     ###                         SML Backup                         ###
                     ### Developed by sergio melas (sergiomelas@gmail.com) 2011-26  ###
                     ###                                                            ###
                     ##################################################################
                     ##################################################################

WARNING & DISCLAIMER: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃                                                                                                         ┃
┃ NEVER RUN THIS SOFTWARE FROM A SUBDIRECTORY OF YOUR HOME FOLDER; THIS COULD DAMAGE YOUR SYSTEM          ┃
┃                           Run instead from the backup external disk                                     ┃
┃                                                                                                         ┃
┃    We assume no responsibility for errors or omissions in the software or documentation available.      ┃
┃    In no event shall we be liable to you or any third parties for any special, punitive, incidental,    ┃
┃ indirect or consequential damages of any kind, or any damages whatsoever, including, without limitation,┃
┃ those resulting from loss of use, data or profits, arising out of or in connection with this software.  ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

* Description:
  - Implements incremental backups of your home folder using rsync with a clean Zenity interface.
  - Fully integrated with Timeshift for complete system snapshots.
  - Designed to reside and run directly from the external backup disk.
  - Automated "State & Status" logic to detect and repair interrupted backups or lost disk connections.

* Usage:
  - Backup: Click the "Backup" launcher to create a new snapshot or an incremental one.
  - Delete: Drag and drop backup folders onto the "Delete" launcher for safe removal.
  - Restore: Drag and drop backup folders onto the "Restore" launcher for safe restore and reboot.
  - Timeshift: Click "Timeshift OS Backups" to access the system snapshot management interface.

* Installation Instructions:
  - Needed Dependencies:
      zenity, rsync, original-awk
      (Debian users can install these via the provided install script).

  - Prepare the Disk with Compression (BTRFS):
      1. Format a USB HD as BTRFS using a partition manager. Ensure your user is the owner.
      2. Activate BTRFS Transparent Compression (Set <CL> from 1-15; higher is more compressed but slower):
         sudo btrfs property set '/media/<User>/Backup_Disk' compression zstd:<CL>
         sudo btrfs filesystem defrag -czstd -rv '/media/<User>/Backup_Disk'

      Example (User: sergio, Disk: "Time Travel", Compression Level: 15):
         sudo btrfs property set '/media/sergio/Time Travel' compression zstd:15
         sudo btrfs filesystem defrag -czstd -rv '/media/sergio/Time Travel'

  - Fix Persistent Mount Point (Recommended):
      To prevent duplicate mount points (e.g., ".../Backup_Disk 1"), set a static
      path in /etc/fstab to ensure the "State & Status" logic functions correctly.

      1. Connect Disk: Plug in your USB drive and ensure it is mounted by the system.
      2. Identify Disk UUID: Run 'lsblk -f' to find your BTRFS partition and copy its UUID.
      3. Safely Extract: Right-click the disk in the file manager and select "Unmount"
         or "Safely Remove", or run: sudo umount /run/media/<User>/<Current_Label>
      4. Create Directory: sudo mkdir -p /media/<Mount_Name>
      5. Set Permissions: sudo chown <User>:<User> /media/<Mount_Name>
      6. Edit /etc/fstab: Add the following line to the end of the file:
         UUID=<UUID>  /media/<Mount_Name>  btrfs  defaults,nofail,user,compress=zstd:<CL>  0  2
      7. Apply Changes: Run 'sudo systemctl daemon-reload' followed by 'sudo mount -a'.

      Example (User: sergio, Mount Name: timetravel, Disk: "Time Travel", UUID: a1b2c3d4-e5f6-7890-abcd-1234567890ab, CL: 15):
          (Disk is connected at '/run/media/sergio/Time Travel')
          sudo umount /run/media/sergio/'Time Travel'
          sudo mkdir -p /media/timetravel
          sudo chown sergio:sergio /media/timetravel
          (In /etc/fstab): UUID=a1b2c3d4-e5f6-7890-abcd-1234567890ab  /media/timetravel  btrfs  defaults,nofail,user,compress=zstd:15  0  2
          sudo systemctl daemon-reload
          sudo mount -a

      8. Desktop Environment Integration (KDE / Gnome):
      After setting up /etc/fstab, configure your desktop to auto-mount
      the device correctly at login:

        KDE Plasma (See Device Auto-Mount settings):
        - Open "System Settings" > "Device Auto-Mount".
        - Check "On Login" and "On Attach" for your backup disk (e.g., "Time Travel").
        - This ensures KDE triggers the mount point you defined in fstab
          as soon as you plug it in or log in.

        Gnome:
        - Open "Disks" utility > Select Disk > "Edit Mount Options".
        - Ensure "Mount at system startup" is checked so it matches fstab logic.

  - Initial System Setup:
      1. Run Timeshift manually the first time to create the snapshot structure.
      2. Select your BTRFS disk as the target and choose "RSYNC" as the backup type.

- Script Installation:
      CRITICAL: You MUST complete the "Fix Persistent Mount Point" step above BEFORE
      running the installer. If you change the mount path later, the .desktop
      launchers will break and you will need to run install.sh again.

      1. Ensure the disk is mounted at your permanent path (e.g., /media/timetravel).
      2. Copy the payload ZIP content to the root of the backup drive.
      3. Run install.sh by dragging it into a terminal and following the prompts.
      4. The installer will automatically link the launchers to the current path
         and install dependencies (zenity, rsync, original-awk, timeshift).

- Restore System & Data:
      1. Prepare Environment (CRITICAL):
         If you are on a fresh OS installation, you MUST first complete the
         steps in the "Fix Persistent Mount Point" and "Script Installation"
         sections above. This ensures the disk is mounted correctly and all
         dependencies (zenity, rsync, etc.) are installed on the new system.

      2. Restore Home: Drag and drop the desired backup folder (e.g., Backup_YYYY-MM-DD...)
         onto the "Restore" launcher.
         - Note: The script will enter "Deep Freeze" mode, terminating browsers and system
           tasks (Chrome, Firefox, Discord, etc.) to prevent data corruption.

      3. Identity Validation: If the username doesn't match the backup, the script
         will prompt you to select the correct user folder manually.

      4. System Restore: After the Home restoration, the script will offer to
         launch Snapshot restoration via Timeshift.

      5. Finalize: Follow the prompt to reboot. A "Maintenance" mask will cover
         the screen during the final cache sync to ensure total data integrity.

##################################################################################################################
Change Log:
 -V1.0 2011-09-08: Initial version.
 -V1.1 2019-06-05: Added support for BTRFS compression.
 -V2.0 2023-04-03: First public release; added old backup deletion and UI improvements.
 -V2.1 2023-07-06: Fixed bug allowing deletion of the last good backup.
 -V2.2 2024-03-02: Added Timeshift system backup integration.
 -V2.3 2025-12-23: Improved Timeshift integration; added management for interrupted backups/lost connections.
 -V2.4 2026-02-05: Added Restore, Fixed Timeshift sanitation loop.
 -V2.5 2026-03-27: Added Persistent Mount Point guide, optimized process
                   synchronization during Restore, and mandatory Script
                   Installation for fresh OS consistency.

