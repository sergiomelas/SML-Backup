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

  - Initial System Setup:
      1. Run Timeshift manually the first time to create the snapshot structure.
      2. Select your BTRFS disk as the target and choose "RSYNC" as the backup type.

  - Script Installation:
      1. Copy the payload ZIP content to the root of the backup drive (include all hidden files like .running).
      2. Run install.sh by dragging it into a terminal and follow the prompts.

* Restore System:
  1. Install Debian as usual using the same account names.
  2. Restore the system via Timeshift from an existing snapshot and reboot.
  3. Restore user files from the terminal:
     sudo cp -rp /media/<User>/Backup_Disk/Backup_YYYY-MM-DD_HH:MM:SS/<user> /home/

##################################################################################################################
Change Log:
 -V1.0 2011-09-08: Initial version.
 -V1.1 2019-06-05: Added support for BTRFS compression.
 -V2.0 2023-04-03: First public release; added old backup deletion and UI improvements.
 -V2.1 2023-07-06: Fixed bug allowing deletion of the last good backup.
 -V2.2 2024-03-02: Added Timeshift system backup integration.
 -V2.3 2025-12-23: Improved Timeshift integration; added management for interrupted backups/lost connections.
 -V2.4 2026-02-05: Fixed Timeshift sanitation loop; implemented buttonless UI with direct process-kill logic.
