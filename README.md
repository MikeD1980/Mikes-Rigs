# CF Card Utilities

  =====================================
    CF CARD UTILITIES  v1.2 April-2025  by Michael Dahlenburg
  =============================================
   For Comments on improvements, suggestions and issues, email me at mickdahl@adam.com.au

  This software is licensed under the GNU General Public License as published 
  by the Free Software Foundation and may be freely copied and modified with the
  terms and conditions as laid out in the included document - gpl-3.0.txt

  ============================================================================================   
  FOREWORD:
       Please be aware unexpected bugs or situations may occur that could cause data loss as 
       result of using this utility.             Please report any bugs!
              ...And please be careful! This program is destructive and it can wipe drives if 
              used incorrectly! I have tried to prevent this by listing all drives at the start
              of the program and at each utility prompt so you can check the drive you wish to 
              work with is correct, it prevents you working with the C drive and 'Are you sure?' 
              prompts have been added before destructive operations occur, but I cant stop you 
              accidentally selecting the wrong drive letter nor am I to be held responsible for 
              its incorrect or accidental use or configurations outside of the intended scope.
              Preferably use this on a test PC, virtual machine or old PC with no critical 
              information on its drives.

  ============================================================================================     

  This is my CF Card Utilities program I created as no simple utility exists
  (that I am aware of!) which can easily perform some useful operations on a CF Card,
  in particular, FAT16 partitionned cards of smaller sizes as used on retro PC's, hence
  this programs primary support for FAT drives under 2GB.

  I have written this in Win10 Powershell, as I use it reguarly for work and play, 
  and while there are probably better ways of doing it, I set the challenge to see just how 
  comprehensive a power shell based utility could be.
  It is compiled into a stand-alone executable using PS2EXE-GUI v0.5.0.31 by Ingo Karstein.

  As a retro computing enthusiast, I was quite surprised to find no CF Card manufacturers
  or 3rd parties ever made a utilities program with any form of diagnostics.
  The only thing I have really found is the SD Card formatter, which is great if you mess up
  a drives partitioning, but only partitions/formats cards to the drives defaults and I noticed,
  doesn't align the partition properly.
  So, I wrote this program to fill in the gap :)
  I hope you find it useful and if you have any ideas for improvements, changes etc, 
  please let me know!

  Currently CF cards up to 2GB are supported and while primarily intended for CF Cards,
  it will also work on SD cards and USB drives, the only thing that wont work is the SMART Test
  (not that it works on most CF Cards anyhow! )

  Requirements:
  * Windows 10 22H2 [Version 10.0.19045.5737] or later, or any Windows 11
  * USB 2.0/3.0 CF Card reader (preferably dont use a USB 1.1 reader! You will be waiting a while.)
  * Any CF Card up to 2GB in capacity

  IMPORTANT NOTE: When running the utilities, read the prompts and enter details exactly as requested.
                  Sometimes the drive letter with a colon is required, other times it is not.
                  If you get a heap of powershell errors, check you entered the drive letter incorrectly.

     Note that most test functions will log the results to a logfile at C:\CFLog.txt - to keep record.

  The Utilities included are as follows:

  1. Perform Capacity Test

     After erasing the drive, This writes dummy files of varying sizes scaling down to 1kb to 
     the CF Card to determine how much of the space is real and useable. 
     This is for the purpose of catching out 'fake' cf cards, ones that report higher capacities than 
     they actually are. It will work on SD cards and USB drives but is untested on larger than 2GB
     drives. It would also take an insane amount of time on drives over 2GB, so if this is of interest
     to you, I can alter the program to check larger drives faster.
      
     It also has the side effect of secure erasing a drive, as when it writes the dummy files,
     every sector on the partition is over-written with files containing zeroes.
     Note that this also exists as a separate function 4, which includes an optional format afterwards.
     
     When the capacity test completes, it gives you the useable drive size and stores this value
     to be used for the integrity tests. 
     This value is populated on the main menu after the test is performmed, as 'CF Size Value'.
     
     The capacity test time for an average 512mb CF Card (@2-5mb/s) is 2:00-2:30 (avg. 2min:15sec)
     - If it is taking much longer than this, then the write speed has been greatly reduced which
     may indicate an old/well used drive or an old USB 1.0/1.1 CF Card interface.


  2. Quick Integrity Test

     This test checks the intergrity of a CF Cards ability to read and write data without error.
     It works by creating a dummy file on the CF card, copying it off the CF Card, copying it back onto
     the card, then off again, and checks the files integrity by the way of performming MD5 checksums
     (CRC) at each operation, reflecting the CF Cards ability to reliably read and write data across
     every sector of the drive.
     If the initially created files CRC value matches the CRC of the last copied file, its a pass.
     If they dont match, its a fail, and I would seriously not be using that card in future.
     Any single 'bit' of information that becomes changed, will be reflected in the CRC value, reliably
     indicating the integrity of the drives ability to read, write and store data.
     There is a small chance it may be the reader, use some electrical cleanner and clean the CF card
     slot, and USB connection top the PC, or try another USB port. If you encounter a CRC error
     and it seems OK after cleanning the slot, I would recommend running the Extended test a few times
     to be sure.

     It uses the formatted partition size determined by running the previous 'Perform Capacity Test'
     or if it was not run, prompting the user for a drive size value. This value needs to be spot on which
     is why I strongly recommend performming the capacity test first - especially since running it, you
     will realise the reported size and actual size are never spot on!
     Manually entering the value may be helpful if for some reason you want to over-ride the size detected 
     by the Capacity Test or you only want to test the first half of the drive. 
     If you are unsure, just run the Capacity Test first :)

     What it cant do - Find out what location on the drive has the failure, and if the card can reliably
     hold data over time. Finding the location is a little trickier and to be honest, if one sector has
     failed, would you even trust the rest of the drive from that point on?

  3. Extended Integrity Test
     
     This test functions the same as the Quick Integrity Test, except it copies the same diagnostic file back and forth
     between the CF Card and temporary folder it creates on the C drive, 5 times, and checks the files integrity
     by the way of performming MD5 checksums (CRC) at each operation, reflecting the CF Cards ability to reliably
     read and write data.
     This is more likely to catch out an issue, but takes much longer and causes a small amount of write wear 
     to the drive. If the CRC integrity fails on this test, take the same course of action as mentionned for the
     Quick Integrity Test

  4. Secure Erase CF Card

     This test is pretty self explainatory, it fills the drive with dummy files filled with zeroes to make data recovery
     impossible. They say to run these type of erase functions 3 times over, but I cant see how more than 1 will
     make any difference - trying to recover anything with recovery utilities (i tried testdisk which is pretty good)
     I have found to be impossible.
     After filling the drive with zeroes, while not really necissary, asks if you would like to re-format the drive.

  5. Re-Partition & Format CF Card  - Format, Partition, Alignment, CHKDSK and Information Options 

       This MENU has formatting, partitioning, alignment, CHKDSK and information options as follows:
     
    1. Re-Partition & Format CF Card  - Format, Partition, Alignment, CHKDSK and Information Options 
       
        1. Format, Partition, Alignment, CHKDSK - Sub-Menu

               Format and Partition Sub-Menu :

               1. FAT16 Partition, Format and Set Alignment Value on CF Card

                  This option will erase the partition, allow selection of alignment size (more on this later), 
                  to create a correctly aligned partition, and performs FAT16 format.

               2. Format CF Card to FAT16

                  This option just performs a FAT16 format to a selected CF Card.

               3. CHKDSK Bad Sector Check

                  This options runs the regular CHKDSK built into Windows with an option to select a file system check
                  or check for bad sectors and file system checks equivelant to using the /F and /F /R CHKDSK parameters.

               4. Enable/Disable 8bit ATA Mode <Not Operational>

                  Not currently operational, I got the code to work once under certain conditions, then it never worked again,
                  so Ill need to spend some time on this one as there is more to it that I first thought...
   
    2. Check partition alignment on CF Card
    
       A straightforward check which asks for the drive to check and checks the partition is correctly aligned by checking 
       the partition is divisable by 4096. It shows a pass or fail and logs the results to the logfile.
             
    3. Display CF Card CHS values for manual BIOS Entry

       Displays Cylinders, Heads and Sectors for entry into legacy BIOS'es - such as is used on old mainboards without 
       auto-detect functionality.
       
    4. Display drive, file system & partition type, and alignment value

       Allows you to select drive, and displays Drive Type (MBR/GPT), File System type (FAT/FAT32/NTFS), Partition Index (
       to check the drive is setup correctly for your application (usually for Legacy/Retro systems)

       For example, you might get this output:
          Type: MBR
          File System: FAT 
          Partition Index: 1 
          Offset: 32768 bytes 
          Alignment Size: 32 KB  
          Partition Type: XINT13

       It is interpreted as follows:
       Drive Type: MBR: MBR supports up to 4 primary partitions or 3 primary + 1 extended partition. 
                    limited to a maximum drive size of 2 TB.
       File System: FAT: FAT stands for File Allocation Table, a simple file system used in older computers and portable storage devices.
                    It’s widely compatible but less efficient for larger drives compared to newer file systems like NTFS or exFAT.
       Partition Index: 1: This indicates the partition's position on the disk, starting from index 1 (1 = the first partition).
                    If the drive has multiple partitions, the index helps identify and manage them.
       Offset: 32768 bytes: The partition begins 32,768 bytes (or 32 KB) from the start of the disk. This offset is well-aligned, 
                    ensuring optimal performance.
       Alignment Size: 32 KB: This is the size of the alignment between the partition and the physical sectors of the disk.
                    Proper alignment (divisible by 4 KB) ensures efficient data access, especially on CF/SD Cards, USB Drives and SSDs.
       Partition Type: XINT13: This refers to a partition type using Extended INT 13h BIOS interrupt extensions, 
                    supporting larger storage devices. Commonly associated with FAT file systems and older BIOS environments.

    6. SMART Test and Stats

       This will check the SMART status and show any parameters - if supported. Many CF Card do not support any SMART features, but
       some surprisingly, do show some stats or if it is predicting a failure - based on power on hours. I dont have a list of drives
       that do and do not support various features, that would take an insane amount of time for very little reward, so this
       just searches and displays any SMART features. 
       If it supports none, it will just show a pass, but beware if it shows a failure
       predicted, it supports some SMART parameter that indicated that failure!

    7. BACKUP/RESTORE CF Card

       This will show a Sub-Menu with backup and restore options. Its pretty straight forward, option 1 backs up, option 2 restores.
       Option 3 will show you available backup files stored under C:\CFBackup. You can copy the file names displayed here using
       the mouse to highlight the filename and press CTRL+C, then when restoring, press CTRL+V to paste the file name.
       These images are actually .WIM files renamed as .CFC files.

    8. Speed Test Drive

       This performs a speed test on the CF Card by creating 2 different sized (5mb and 50mb) dummy file and copying it to and from the drive while
       measuring the transfer speed. It then displays the results for small and large file transfer times, as well as an average read/write speed.
       As with most utility functions, the results are logged to the logfile.

  Other Details:
   
     The program will prevent you from wiping your C drive by accident. All other drives are not protected, so be careful!


 KNOWN BUGS/ISSUES:


 TROUBLESHOOTING:

  Q. When trying to format the drive, it shows the following:
    'ERROR: No MSFT_Volume objects found with property 'DriveLetter' equal to ':'.  Verify the value of the property and retry.'
  A. - Basically a Syntax error. Type the drive letter without colon (ie E not E:) - Follow the prompts exactly! They tell you if
       you need a semi colon or not.

  Most other previous issues are resolved, including it now forces you to run as administrator, or it will not load.


 CHANGELOG:
  v0.1  3/23          - Proof of concepts - powershell scripts
  v0.2-0.8 5/23-9/24  - Combined series of powershell scripts into 1 executable
  v1.0 11/24          - Made a nice menu but very not user friendly :)
  v1.1 1/25           - Tidied up and added more friendly user prompts, added extended integrity test, fixed a bug that stoped the
                        C drive protection detection from working (!)
                        chose distribution license to keep it free (GNU) and wrote this README.
  v1.2 4/25           - Major re-write. Decided to Release source code and compiled script on GITHUB for distribution.

  CHECKSUM:

  - To ensure executable has not been tampered with:

  SHA256 Checksum: 
  Name: CF_Util.exe
  Size: 76288 bytes (74 KiB)
  SHA256: 6502920EBA8FEA4F18C044A67C0A66804CB6D58E35F8E9196D2968BEFCB4A0F4


 LICENSING AGREEMENT:

 This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License 
 as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
 of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

  You should have received a copy of the GNU General Public License along with this program. 
   If not, see <https://www.gnu.org/licenses/>.
