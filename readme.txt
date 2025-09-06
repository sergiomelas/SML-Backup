                     ##################################################################
                     ##################################################################
                     ###                         SML Backup                         ###
                     ### Developed by sergio melas (sergiomelas@gmail.com) 2011-23  ###
                     ##################################################################
                     ##################################################################



WARNING & DISCLAIMER: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃                                                                                                                 ┃
┃     NEVER RUN THIS SOFTWARE FROM A SUBDIRECTORY OF YOUR HOME FOLDER, THIS COULD DAMAGE YOUR SYSTEM              ┃
┃                              Run instead from the backup external disk                                          ┃
┃                                                                                                                 ┃
┃       We assume no responsibility for errors or omissions in the software or documentation available.           ┃
┃      In no event shall we be liable to you or any third parties for any special, punitive, incidental,          ┃
┃     indirect or consequential damages of any kind, or any damages whatsoever, including, without limitation,    ┃
┃     those resulting from loss of use, data or profits, and on any theory of liability, arising out of or in     ┃
┃     connection with the use of this software.                                                                   ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


* Description:
  - This collection of scripts implements incremental backups of your home folder using rsynk with a pretty interface
  - The incremental backups are fully integrated with timeshift for system backup
  - This software will reside in the backup disk

* Usage:
  - Click on the "Backup" launcher to create a backup or generate an incremental one afterwards
  - Drag and drop backup folders to the "Delete" launcher to delete them
  - Click "Timeshift OS Backups"laucher to acess the system backups timeshift interface

* Installation Instructions:
  -Needed dependencies :
    zenity rsync original-awk
    (for debian just install running the script, see below)

    -Prepare the disk with compression
      -Insert a USB HD you want to use as backup drive

      -Format in in BTRFS with a name you prefer for example  "Backup_Disk" using a partition manager giving access to you as owner

      -Activate BTRFS compression on external disk, <CL>=1-15 is compression level , higher more compression but slowr:
         sudo btrfs property set '/media/<User>/Backup_Disk'  compression zstd:<CL>
         sudo btrfs filesystem defrag -czstd -rv    '/media/<User>/Backup_Disk'

         Example for: <User>=sergio, disk="Time Travel" compression level=15
         sudo btrfs property set '/media/sergio/Time Travel'  compression zstd:15
         sudo btrfs filesystem defrag -czstd -rv    '/media/sergio/Time Travel'
      -Do the system backup manually the first time:
         Run timeshift the first time manually to create the system snapshot structure
         Select the disk you created above as disk target, selsct rsynk backup type

  -Now proceed to the installation of the scripts:
     -Copy the content of the payload ZIP file inside the target backup drive (pay attention there are hidden files be shure to
      copy all of them)
     -run install.sh dragging and droping it in a console (need to answer some questions)

* Restore system
   - Install debian as usual (use same accounts names)
   - After restore the system from a snapshot and reboot
   - Loging as your user
   - Restore the user files with
      sudo sudo cp /media/<User>/Backup_Disk/Backup_2025-02-05_04:09:12/<user> /home/<user>

##################################################################################################################
Change log:
 -V1.0 2011: Initial version
 -V1.1 2019: Added support for btrfs compression
 -v2.0 2023: First pubblic release, added deleting old backups and many improvements
 -v2.1 2023: Corrected bug you could delete last backup
 -v2.2 2024: Added timeshift system backup integration
 -v2.3 2025: Corrected bug on timeshift integration

