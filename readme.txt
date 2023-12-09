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
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


Description:
This collection of scripts implement incremental backups of your home folder using rsynk with a pretty interface
This software will reside in the backup disk
- Click on the "Backup" launcher to create a backup
- Drag and drop backup folders to the "Delete" launcher to delete them


Installation Instructions:
  -Needed dependencies :
    zenity rsync original-awk
    (for debian just install running the script, see below)
  -Prepare the disk with compression
      -Insert a USB HD you want to use as backup drive

      -Format in in BTRFS with a name you prefer for example  "Backup_Disk" using a partition manager giving access to you as owner

      -Activate BTRFS compression on external disk:
         sudo btrfs property set '/media/<Your User>/Backup_Disk'  compression zstd:1
         sudo btrfs filesystem defrag -czstd -rv    '/media/<Your User>/Backup_Disk'

  -Now proceed to the installation of the scripts:
     -Copy the content of the payload ZIP file inside the target backup drive (pay attention there are hidden files be shure to copy all of them)
     -run install.sh dragging and droping it in a console (need to swer some questions)

Note: To create first backup click the backup icon, At each run an incremental backup is created


##################################################################################################################
Change log:

V1.0 2011: -Initial version
V1.1 2019: -Added support for btrfs compression
v2.0 2023: -First pubblic release, added deleting old backups and many improvements

