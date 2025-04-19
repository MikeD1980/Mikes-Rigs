# CF Card Utilities v1.2 Script

# Check if running as Administrator
if (-Not ([Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host " Checking environment..."
	Write-Host ""
	Write-Host " CF Card Utilities is not running as an administrator - Please run again with Administrator privlidges." -ForegroundColor Red
	Write-Host ""
	Start-Sleep -Seconds 3
	pause
	exit
} else {
	Write-Host " Checking environment..."
	Write-Host ""
    Write-Host " CF Card Utilities is running as administrator, continuing..." -ForegroundColor Green
	Start-Sleep -Seconds 2
}

#Global Variables

$global:CFSize = 0
# GNU licensing Display - showing at start only
    Clear-Host
	Write-Host ""
	Write-Host "                             CF Card Utilities for FAT16 CF Cards" -ForegroundColor Yellow
	Write-Host ""
	Write-Host " This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public "
	Write-Host " License as published by the Free Software Foundation, either version 3 of the License, "
	Write-Host " or (at your option) any later version."
	Write-Host ""
	Write-Host " This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; "
	Write-Host " without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. "
	Write-Host " See the GNU General Public License for more details."
	Write-Host " You should have received a copy of the GNU General Public License along with this program. "
	Write-Host " If not, see https://www.gnu.org/licenses/."
	Write-Host ""
	Write-Host " By continuing, you are agreeing to the above terms, otherwise close the program."
	pause

# Display the menu

function Show-Menu {
	Clear-Host
    Write-Host "=============================================================================================================" -ForegroundColor Green
    Write-Host "                        CF Card Utilities for FAT16 CF Cards up to 2GB" -ForegroundColor Yellow
    Write-Host "                          Version 1.2 Apr-2025 by Michael Dahlenburg" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "                     Please read the README.TXT BEFORE using this utility!" -ForegroundColor Cyan
    Write-Host "     SOME tests are destructive to any existing files on the CF Card - Make sure you BACKUP first!" -ForegroundColor Red
    Write-Host "                 All test results and information will be logged to C:\CFLog.txt" -ForegroundColor Yellow
    Write-Host "=============================================================================================================" -ForegroundColor Green
    Write-Host " $args"

    Write-Host " ALL Available System Drives:" -ForegroundColor Magenta
    Get-Volume | Format-Table -Property DriveLetter, FileSystemLabel, FileSystem, SizeRemaining, Size 

#    Write-Host " Available FAT & FAT32 Drives:" -ForegroundColor Magenta
#    Get-Volume | Where-Object { $_.FileSystem -eq 'FAT' -or $_.FileSystem -eq 'FAT32' } | Format-Table -Property DriveLetter, FileSystemLabel, FileSystem, SizeRemaining, Size 
	
	Write-Host "=============================================================================================================" -ForegroundColor Green
    Write-Host " 1. Perform Capacity Test          - Tests 'real' useable space on a CF Card to detect fake cards" -ForegroundColor White
    Write-Host "  -= Run the above test before Integrity Tests to automatically assign useable drive space =-" -ForegroundColor Yellow
	Write-Host " 2. Quick Integrity Test           - Fast Test to detect faulty CF Cards - Read README.TXT for more info" -ForegroundColor White
    Write-Host " 3. Extended Integrity Test        - Performs a more comprehensive test but takes up to 5 times as long." -ForegroundColor White
    Write-Host " 4. Secure Erase CF Card           - Cleans the drive by writting millions of 0's to the drive twice over" -ForegroundColor White
    Write-Host " 5. Re-Partition & Format CF Card  - Format, Partition, Alignment, CHKDSK and Information Options " -ForegroundColor White
	Write-Host " 6. SMART Test and Stats           - Displays SMART status and variables - if supported by the card" -ForegroundColor White
	Write-Host " 7. BACKUP/RESTORE CF Card         - Backup and Restore CF Card to/from image file (SUB Menu) " -ForegroundColor White
	Write-Host " 8. Speed Test Drive               - Reports drive read and write speed" -ForegroundColor White
    Write-Host " 9. Exit..." -ForegroundColor DarkGray
    Write-Host "=============================================================================================================" -ForegroundColor Green
 Write-Host  CF Size Value: "$CFSize" -ForegroundColor DarkGray
}
# Goto Main Script Logic for the choice options, if needed. switch statement needs to go after all the functions to work

# Define your functions here
# ===================================================================================================================================

function Option1 {
    Write-Host "Perform Capacity Test selected..."
	Start-Sleep -Seconds 2
	#cls
# Add your script for Option 1 here
# Function to write dummy files
function Write-DummyFiles1 {
    param (
        [string]$driveLetter,
        [int]$fileSizeKB
    )
	$global:CFSize = 0
    $fileNumber = 0
    while ($true) {
        $filePath = "$driveLetter\dummya$fileNumber.tmp"
        try {
            $content = New-Object byte[] ($fileSizeKB * 1024)
            [System.IO.File]::WriteAllBytes($filePath, $content)
            $fileNumber++
        } catch {
            break
        }
    }
}

function Write-DummyFiles2 {
    param (
        [string]$driveLetter,
        [int]$fileSizeKB
    )
    $fileNumber = 0
    while ($true) {
        $filePath = "$driveLetter\dummyb$fileNumber.tmp"
        try {
            $content = New-Object byte[] ($fileSizeKB * 1024)
            [System.IO.File]::WriteAllBytes($filePath, $content)
            $fileNumber++
        } catch {
            break
        }
    }
}

function Write-DummyFiles3 {
    param (
        [string]$driveLetter,
        [int]$fileSizeKB
    )
    $fileNumber = 0
    while ($true) {
        $filePath = "$driveLetter\dummyc$fileNumber.tmp"
        try {
            $content = New-Object byte[] ($fileSizeKB * 1024)
            [System.IO.File]::WriteAllBytes($filePath, $content)
            $fileNumber++
        } catch {
            break
        }
    }
}

function Write-DummyFiles4 {
    param (
        [string]$driveLetter,
        [int]$fileSizeKB
    )
    $fileNumber = 0
    while ($true) {
        $filePath = "$driveLetter\dummyd$fileNumber.tmp"
        try {
            $content = New-Object byte[] ($fileSizeKB * 1024)
            [System.IO.File]::WriteAllBytes($filePath, $content)
            $fileNumber++
        } catch {
            break
        }
    }
}

# Select drive letter
$driveLetter = Read-Host "Enter the drive letter (including COLON) (e.g., E:)"

# Check if the drive letter is C:
if ($driveLetter -eq 'C:') {
    Write-Host "You cannot test the system drive. Operation aborted."
exit}
if ($driveLetter -eq 'c:') {
    Write-Host "You cannot test the system drive. Operation aborted."
exit}

# Warning message
$warningMessage = "WARNING: This test is destructive and will erase all files on $driveLetter drive. Do you want to continue? (Y/N)" -ForegroundColor Red
$continue = Read-Host $warningMessage

if ($continue -eq 'Y') {
    # Erase all files from the selected drive
    Remove-Item "$driveLetter\*" -Recurse -Force

    # Write dummy files to the drive
    Write-Host "Writting blocks to drive..."
	Write-Host "Block Size 1 - this may take some time..." -ForegroundColor DarkBlue
	Write-DummyFiles1 -driveLetter $driveLetter -fileSizeKB 10240  # 10MB files
	Write-Host "Block Size 2" -ForegroundColor DarkBlue
    Write-DummyFiles2 -driveLetter $driveLetter -fileSizeKB 1024   # 1MB files
	Write-Host "Block Size 3" -ForegroundColor DarkBlue
    Write-DummyFiles3 -driveLetter $driveLetter -fileSizeKB 10     # 10KB files
	Write-Host "Block Size 4" -ForegroundColor DarkBlue
    Write-DummyFiles4 -driveLetter $driveLetter -fileSizeKB 1      # 1KB files

    # Calculate usable drive capacity
	Write-Host "Calculating drive size from Blocks..."
    $totalSizeBytes = (Get-ChildItem "$driveLetter\dummy*.tmp" | Measure-Object -Property Length -Sum).Sum
    $totalSizeKB = [math]::Round($totalSizeBytes / 1024, 2)
    $totalSizeMB = [math]::Round($totalSizeKB / 1024, 2)
    $Global:CFSize = $totalSizeBytes
    Write-Host " Usable drive capacity: $totalSizeBytes bytes ($totalSizeKB KB, $totalSizeMB MB)" -ForegroundColor Green
	Write-Host ""
	Write-Host " Size that the drive reports to the system:"
#OLD	Get-Volume | Where-Object { $_.FileSystem -eq 'FAT' -or $_.FileSystem -eq 'FAT32' } | Format-Table -Property DriveLetter, FileSystemLabel, FileSystem, Size 
Get-Volume | Where-Object { $_.FileSystem -eq 'FAT' -or $_.FileSystem -eq 'FAT32' } | ForEach-Object {
    [PSCustomObject]@{
        DriveLetter      = $_.DriveLetter
        FileSystemLabel  = $_.FileSystemLabel
        FileSystem       = $_.FileSystem
        SizeInBytes      = $_.Size
        SizeInKB         = [math]::Round($_.Size / 1KB, 2)
        SizeInMB         = [math]::Round($_.Size / 1MB, 2)
    }
} | Format-Table -Property DriveLetter, FileSystemLabel, FileSystem, SizeInBytes, SizeInKB, SizeInMB

    # Log the results
	Write-Host "Logging results to C:\CFLog.txt"
    $logEntry = "Date/Time: $(Get-Date) - Drive Capacity Test Completed - Usable drive capacity: $totalSizeBytes bytes ($totalSizeKB KB, $totalSizeMB MB)"
    Add-Content -Path "C:\CFLog.txt" -Value $logEntry

    # Remove all temporary files from the drive
	Write-Host "Cleaning up..."
    Remove-Item "$driveLetter\dummy*.tmp" -Force
	Write-Host "Done."

    # Pause before exiting
    # Read-Host "Press Enter to exit"
} else {
    Write-Host "Operation cancelled."
}	
}
# ===================================================================================================================================
function Option2 {
param (
    [string]$DriveLetter
)
    Write-Host "Quick Integrity Test selected"
	Start-Sleep -Seconds 2
#	cls
    # Add your script for Option 2 here
    # Quick Integrity Test

    # Prompt for drive letter if not provided
    if (-not $DriveLetter) {
        $DriveLetter = Read-Host "Enter the drive letter (including COLON) (e.g., E:)"
    }

    # Advise the user that the test is destructive
    Write-Host "WARNING: This test is destructive and will erase all data on $DriveLetter drive." -ForegroundColor Red
    $continue = Read-Host "Do you want to continue? (Y/N)"
    if ($continue -ne 'Y') {
        Write-Host "Test cancelled."
        return
    }

    try {
        # Erase the drive
        Write-Host "Erasing drive before test $DriveLetter..."
        Remove-Item -Path "$DriveLetter\*" -Recurse -Force

        # Get the drive size in bytes from the global variable 'CFSize'
if (-not $global:CFSize -or $global:CFSize -eq 0) {
    $driveSizeKB = [int64](Read-Host "Enter the drive size in KB -OR- run Capacity Test first")
    $driveSizeBytes = $driveSizeKB * 1KB
    $global:CFSize = $driveSizeBytes

	
		#Old - doesnt work, just displays the value 1024 times! Here for reference
		# Get the drive size in bytes from the global variable 'CFSize'
        #if (-not $global:CFSize -or $global:CFSize -eq 0) {
        #    $driveSizeKB = Read-Host "Enter the drive size in KB - or run Capacity Test first"
        #    $driveSizeKB = $driveSizeKB * 1KB
        #    $global:CFSize = $driveSizeKB
		}
        

        # Write a dummy file containing zeroes to the drive
        $dummyFilePath = "$DriveLetter\dummyfile.bin"
        $tempFolder = "C:\CFTemp"
        New-Item -Path $tempFolder -ItemType Directory -Force
        $dummyFileSize = $global:CFSize
        Write-Host "Creating a test file of size $dummyFileSize bytes..."
        $null = [System.IO.File]::WriteAllBytes($dummyFilePath, (New-Object byte[] $dummyFileSize))
        Write-Host "Done."

        # Calculate and display the MD5 value of the dummy file
        $md5 = Get-FileHash -Path $dummyFilePath -Algorithm MD5
        $originalMD5 = $md5.Hash
        Write-Host "Original Test File MD5/CRC value : $originalMD5"

        # Copy the file to C:\CFTemp
        $tempFilePath = "C:\CFTemp\dummyfile.bin"
        Copy-Item -Path $dummyFilePath -Destination $tempFilePath

        # Calculate and display the MD5 value of the copied file
        $tempMD5 = Get-FileHash -Path $tempFilePath -Algorithm MD5
        Write-Host "MD5/CRC Read : $tempMD5.Hash"

        # Delete the file on the CF card drive
        Remove-Item -Path $dummyFilePath -Force

        # Copy the file back onto the CF card drive
        Copy-Item -Path $tempFilePath -Destination $dummyFilePath

        # Calculate and display the MD5 value of the file on the CF card drive
        $cfMD5 = Get-FileHash -Path $dummyFilePath -Algorithm MD5
        Write-Host "MD5/CRC Write : $cfMD5.Hash"

        # Copy the file back to the C:\CFTemp folder
        Copy-Item -Path $dummyFilePath -Destination $tempFilePath -Force

        # Calculate and display the MD5 value of the file in C:\CFTemp
        $finalMD5 = Get-FileHash -Path $tempFilePath -Algorithm MD5
        Write-Host "Final MD5/CRC Value : $finalMD5.Hash"

        # Compare the MD5 values
        if ($originalMD5 -eq $finalMD5.Hash) {
            Write-Host "Integrity Test Passed!" -ForegroundColor Green
        } else {
            Write-Host "Integrity Test FAILED" -ForegroundColor Red
        }

        # Append the result with the current time and date to a log file
        $logEntry = "$(Get-Date) - Quick Integrity Test Result: (True = PASS, False = FAIL:) $($originalMD5 -eq $finalMD5.Hash)"
        Add-Content -Path "C:\CFLog.txt" -Value $logEntry

        # Remove the test file from the drive and C:\CFTemp folder
        Remove-Item -Path $dummyFilePath -Force
        Remove-Item -Path $tempFilePath -Force

    } catch {
        Write-Host "An error occurred: $_" -ForegroundColor Red
        $logEntry = "$(Get-Date) - Quick Integrity Test Error: $_"
        Add-Content -Path "C:\CFLog.txt" -Value $logEntry
    }

    # Pause before exiting
    Read-Host "Press Enter to exit"
}

# ===================================================================================================================================
function Option3 {
    param (
        [string]$DriveLetter
    )
    Write-Host "Extended Integrity Test selected"
	Start-Sleep -Seconds 2
	

    if (-not $DriveLetter) {
        $DriveLetter = Read-Host "Enter the drive letter (including COLON) (e.g., E:)"
    }

    Write-Host "WARNING: This test is destructive and will erase all data on $DriveLetter drive." -ForegroundColor Red
    $continue = Read-Host "Do you want to continue? (Y/N)"
    if ($continue -ne 'Y') {
        Write-Host "Test cancelled."
        return
    }

    try {
        Write-Host "Erasing drive before test $DriveLetter..."
        Remove-Item -Path "$DriveLetter\*" -Recurse -Force

        if (-not $global:CFSize -or $global:CFSize -eq 0) {
            $driveSizeKB = [int64](Read-Host "Enter the drive size in KB -OR- run Capacity Test first")
            $driveSizeBytes = $driveSizeKB * 1KB
            $global:CFSize = $driveSizeBytes
        }

        $dummyFilePath = "$DriveLetter\dummyfile.bin"
        $tempFolder = "C:\CFTemp"
        New-Item -Path $tempFolder -ItemType Directory -Force
        $dummyFileSize = $global:CFSize
        Write-Host "Creating a test file of size $dummyFileSize bytes..."
        $null = [System.IO.File]::WriteAllBytes($dummyFilePath, (New-Object byte[] $dummyFileSize))
        Write-Host "Done."

        $originalMD5 = (Get-FileHash -Path $dummyFilePath -Algorithm MD5).Hash
        Write-Host "Original Test File MD5/CRC value: $originalMD5"

        for ($i = 1; $i -le 5; $i++) {
            Write-Host "Iteration $i of file copy..."
            $tempFilePath = "C:\CFTemp\dummyfile_$i.bin"

            # Copy file to temp folder and back
            Copy-Item -Path $dummyFilePath -Destination $tempFilePath -Force
            Copy-Item -Path $tempFilePath -Destination $dummyFilePath -Force

            # Remove temporary file
            Remove-Item -Path $tempFilePath -Force
        }

        $finalMD5 = (Get-FileHash -Path $dummyFilePath -Algorithm MD5).Hash
        Write-Host "Final MD5/CRC Value after 5 iterations: $finalMD5"

        if ($originalMD5 -eq $finalMD5) {
            Write-Host "Integrity Test Passed!" -ForegroundColor Green
        } else {
            Write-Host "Integrity Test FAILED" -ForegroundColor Red
        }

        $logEntry = "$(Get-Date) - Comprehensive Integrity Test Result: (True = PASS, False = FAIL:) $($originalMD5 -eq $finalMD5)"
        Add-Content -Path "C:\CFLog.txt" -Value $logEntry

        Remove-Item -Path $dummyFilePath -Force

    } catch {
        Write-Host "An error occurred: $_" -ForegroundColor Red
        $logEntry = "$(Get-Date) - Comprehensive Integrity Test Error: $_"
        Add-Content -Path "C:\CFLog.txt" -Value $logEntry
    }

    Read-Host "Press Enter to exit"
}

# ===================================================================================================================================
function Option4 {
    Write-Host "Secure Erase CF Card selected"
	Start-Sleep -Seconds 2
	cls

    # Function to write dummy files
    function Write-DummyFiles {
        param (
            [string]$driveLetter,
            [int]$fileSizeKB
        )
        $fileNumber = 0
        while ($true) {
            $filePath = "$driveLetter\dummy$fileNumber.tmp"
            try {
                $content = New-Object byte[] ($fileSizeKB * 1024)
                [System.IO.File]::WriteAllBytes($filePath, $content)
                $fileNumber++
            } catch {
                break
            }
        }
    }

    # Select drive letter
    $driveLetter = Read-Host "Enter the drive letter of drive to wipe, (including COLON) (e.g., E:)"

    # Prevent formatting of the system drive
    if ($driveLetter -eq 'C:' -or $driveLetter -eq 'c:') {
        Write-Host "You cannot wipe the system drive. Operation aborted."
        exit
    }

    # Warning message
    $warningMessage = "WARNING: This operation is destructive and will erase all files on $driveLetter drive. Do you want to continue? (Y/N)"  -ForegroundColor Red
    $continue = Read-Host $warningMessage

    if ($continue -eq 'Y') {
        # Erase all files from the selected drive
        Remove-Item "$driveLetter\*" -Recurse -Force

        # Write dummy files to the drive
        Write-Host "Writing Zeroes to the drive..."
		
        Write-DummyFiles -driveLetter $driveLetter -fileSizeKB 10240  # 10MB files
        Write-DummyFiles -driveLetter $driveLetter -fileSizeKB 1024   # 1MB files
        Write-DummyFiles -driveLetter $driveLetter -fileSizeKB 10     # 10KB files
        Write-DummyFiles -driveLetter $driveLetter -fileSizeKB 1      # 1KB files
        Write-Host ""
        Write-Host "Operation completed."
		Write-Host ""
        # Prompt for FAT16 format
        $formatChoice = Read-Host " Would you like to re-format the drive $driveLetter as FAT16? Selecting N will leave drives format un-touched (Y/N)"
        if ($formatChoice -eq 'Y') {
            Write-Host "Formatting drive $driveLetter as FAT16..."
            try {
                Format-Volume -DriveLetter $driveLetter.TrimEnd(':') -FileSystem FAT -Confirm:$false
                Write-Host "Drive $driveLetter successfully formatted as FAT16."
                $logEntry = "$(Get-Date) - Wipe Operation completed: ZEROES written to drive and Drive $driveletter was formatted as FAT16."
            } catch {
                Write-Host "An error occurred during formatting: $_" -ForegroundColor Red
                $logEntry = "$(Get-Date) - Operation completed with error during formatting: $_"
            }
        } else {
            Write-Host "Skipping FAT16 format and deleting all files only."
            $logEntry = "$(Get-Date) - Wipe Operation completed: ZEROES written to drive and Drive was not formatted."
        }

        # Write log entry
        Add-Content -Path "C:\CFLog.txt" -Value $logEntry
		Write-Host " "
        Write-Host " Operation completed and logged."

    } else {
        Write-Host "Operation cancelled."
        $logEntry = "$(Get-Date) - Operation cancelled by user."
        Add-Content -Path "C:\CFLog.txt" -Value $logEntry
    }
}

# ===================================================================================================================================

function Option5 {
    Write-Host "Re-Partition & Format CF Card selected"
	Start-Sleep -Seconds 2
	cls
    # Add your script for Option 5 here
	# Define log file path
$logPath = "C:\CFLog.txt"


function Display-Menu {
	cls
	Write-Host ""
    Write-Host " =============================================================================" -ForegroundColor Green
    Write-Host "   CF Card Format, Partition, Alignment and Information Options"-ForegroundColor Green
    Write-Host " =============================================================================" -ForegroundColor Green
    Write-Host "  1. Format, Partition, Alignment, CHKDSK - Sub-Menu " -ForegroundColor White
    Write-Host "  2. Check partition alignment on CF Card" -ForegroundColor White
    Write-Host "  3. Display CF Card CHS values for manual BIOS Entry" -ForegroundColor White
    Write-Host "  4. Display drive, file system & partition type, and alignment value" -ForegroundColor White
    Write-Host "  5. Exit " DarkGray
	Write-Host "                                         Press CTRL+C to abort at any time..."
    Write-Host "=============================================================================" -ForegroundColor Green
}

function Handle-Option1 {
    # Script for Formatting and Partitioning a CF Card with Alignment Size Selection
# Define log file
$logFile = "C:\CFLog.txt"

# Function to write to log file
function Log-Message {
    param (
        [string]$message
    )
    $timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $logFile -Value "$timeStamp - $message"
}

# Function to display the menu
function Display-Menu {
    Write-Host ""
    Write-Host " =============================================================================" -ForegroundColor Green
    Write-Host "   Format and Partition Sub-Menu" -ForegroundColor Green
	Write-Host " =============================================================================" -ForegroundColor Green
	Write-Host " 1. FAT16 Partition, Format and Set Alignment Value on CF Card" -ForegroundColor White
    Write-Host " 2. Format CF Card to FAT16" -ForegroundColor White
    Write-Host " 3. CHKDSK Bad Sector Check" -ForegroundColor White
    Write-Host " 4. Enable/Disable 8bit ATA Mode <Not Operational>"  -ForegroundColor Red
    Write-Host " 5. Exit" DarkGray
    Write-Host ""
}

# Function to display partition alignment menu
function Display-AlignmentMenu {
    Write-Host ""
    Write-Host "   Select Partition Alignment" -ForegroundColor White
    Write-Host ""
    Write-Host " 1. 512 KB" -ForegroundColor White
    Write-Host " 2. 1024 KB (Recommended)" -ForegroundColor Yellow
    Write-Host " 3. 2048 KB" -ForegroundColor White
    Write-Host " 4. 4096 KB" -ForegroundColor White
    Write-Host " 5. 16384 KB" -ForegroundColor White
    Write-Host ""
}

# Function to select alignment value
function Get-AlignmentValue {
    Display-AlignmentMenu
    $choice = [int](Read-Host " Enter your choice (1-5)")
    switch ($choice) {
        1 { return 512 }
        2 { return 1024 }
        3 { return 2048 }
        4 { return 4096 }
        5 { return 16384 }
        default {
            Write-Host "Invalid choice. Defaulting to 1024 KB." -ForegroundColor Yellow
            Log-Message "Invalid alignment choice. Defaulting to 1024 KB."
            return 1024
        }
    }
}

# Function to list available drives
function List-Drives {
    Get-Disk | ForEach-Object {
        Write-Host "Disk Number: $($_.Number), Model: $($_.Model), Size: $([math]::Round($_.Size / 1GB, 2)) GB"
    }
}

# Option 1: Partition, format, and set alignment value
function Partition-And-Format {
    Write-Host "Select a disk for partitioning and formatting:"
    List-Drives
    $diskNumber = [int](Read-Host "Enter the disk number of the CF card")
    $volume = Get-Volume | Where-Object { $_.DiskNumber -eq $diskNumber }

    # Safety Check: Ensure the selected disk is not the C drive
    if ($volume.DriveLetter -eq "C") {
        Write-Host "Error: The system drive (C:) cannot be partitioned or formatted. Exiting..." -ForegroundColor Red
        Log-Message "Attempted operation on the system drive (C:). Operation aborted."
        return
    }

    $alignment = Get-AlignmentValue

    try {
        Write-Host "Clearing existing partitions on Disk $diskNumber..." -ForegroundColor Green
        Get-Partition -DiskNumber $diskNumber | Remove-Partition -Confirm:$false
        Log-Message "Existing partitions cleared on Disk $diskNumber."

        Write-Host "Creating a new partition with $alignment KB alignment..." -ForegroundColor Green
        $partition = New-Partition -DiskNumber $diskNumber -Alignment $alignment -UseMaximumSize -AssignDriveLetter
        Log-Message "Partition created successfully on Disk $diskNumber with $alignment KB alignment."

        Write-Host "Formatting the partition to FAT16..." -ForegroundColor Green
        Format-Volume -DriveLetter $partition.DriveLetter -FileSystem FAT -Confirm:$false
        Log-Message "Disk $diskNumber formatted successfully to FAT16."
    } catch {
        Write-Host "An error occurred: $_" -ForegroundColor Red
        Log-Message "Error during partitioning or formatting: $_"
    }
}


# Option 2: Format CF Card to FAT16
function Format-Only {
    Write-Host "Select a disk for formatting:"
    List-Drives
    $diskNumber = [int](Read-Host "Enter the disk number of the CF card")
    $volume = Get-Volume | Where-Object { $_.DiskNumber -eq $diskNumber }

    # Safety Check: Ensure the selected disk is not the C drive
    if ($volume.DriveLetter -eq "C") {
        Write-Host "Error: The system drive (C:) cannot be formatted. Exiting..." -ForegroundColor Red
        Log-Message "Attempted operation on the system drive (C:). Operation aborted."
        return
    }

    try {
        Write-Host "Formatting Drive $($volume.DriveLetter) to FAT16..." -ForegroundColor Green
        Format-Volume -DriveLetter $volume.DriveLetter -FileSystem FAT -Confirm:$false
        Log-Message "Disk $diskNumber formatted successfully to FAT16."
    } catch {
        Write-Host "An error occurred: $_" -ForegroundColor Red
        Log-Message "Error during formatting: $_"
    }
}


# Option 3: CHKDSK for Bad Sectors
function Run-Chkdsk {
    Write-Host "Select a drive for CHKDSK:"
    Get-Volume | ForEach-Object {
        Write-Host "Drive Letter: $($_.DriveLetter), FileSystem: $($_.FileSystem), Size: $([math]::Round($_.Size / 1GB, 2)) GB"
    }

    $driveLetter = Read-Host "Enter the drive letter of the CF card (e.g., D)"

    if (-not $driveLetter) {
        Write-Host "Invalid input. Please provide a valid drive letter." -ForegroundColor Red
        return
    }

    Write-Host "`nSelect CHKDSK mode:"
    Write-Host "1. Fast Check - Find and Fix errors on the disk"
    Write-Host "2. Long Check - Perform Fast check plus Check for Bad Sectors and recover readable data"
    $modeChoice = [int](Read-Host "Enter your choice (1-2)")

    # Determine CHKDSK arguments based on user choice
    $chkdskArgs = ""
    switch ($modeChoice) {
        1 { $chkdskArgs = "/F" }
        2 { $chkdskArgs = "/F /R" }
        default {
            Write-Host "Invalid choice. Returning to main menu..." -ForegroundColor Yellow
            return
        }
    }

    try {
        Write-Host "Running CHKDSK on Drive $driveLetter with selected options..." -ForegroundColor Green

        # Command to run CHKDSK
        $cmdCommand = "chkdsk ${driveLetter}: $chkdskArgs"

        # Log file
        $logFile = "C:\CFLog.txt"

        # Run the command and capture output
        cmd /c "$cmdCommand" 2>&1 | Tee-Object -FilePath $logFile -Append

        Write-Host "CHKDSK completed. Output logged to $logFile." -ForegroundColor Green
        Log-Message "CHKDSK completed successfully on Drive $driveLetter with mode: $($chkdskArgs)."
    } catch {
        Write-Host "An error occurred while running CHKDSK: $_" -ForegroundColor Red
        Log-Message "Error during CHKDSK: $_"
    }
}



# Main Script Loop
do {
    Display-Menu
    $choice = [int](Read-Host "Enter your choice (1-5)")
    switch ($choice) {
        1 { Partition-And-Format }
        2 { Format-Only }
        3 { Run-Chkdsk }
        4 { Write-Host "Option 4 is unused." }
        5 { Write-Host "Exiting..."; Log-Message "Script exited by user."; break }
        default { Write-Host "Invalid choice. Please try again." -ForegroundColor Yellow }
    }
} while ($choice -ne 5)

}

# -==================================================================================================================-
function Handle-Option2 {
Write-Host ""
Write-Host "    Check partition alignment on CF Card selected." -ForegroundColor Green
Write-Host ""
    # Define the log file path
$LogFile = "C:\CFLog.txt"

# Function to write to log and console
function Write-Log {
    param (
        [string]$Message
    )
    $Message | Out-File -FilePath $LogFile -Append
    Write-Output $Message
}

# Get all filesystem drives and display them to the user
$AllDrives = Get-Volume | Where-Object { $_.DriveLetter -ne $null } | 
             Format-Table -Property DriveLetter, FileSystemLabel, FileSystem, SizeRemaining, Size -AutoSize

$DriveList = Get-Volume | Where-Object { $_.DriveLetter -ne $null } 

Write-Log " Available Drives:"
foreach ($Drive in $DriveList) {
    Write-Log "Drive $($Drive.DriveLetter) - Label: $($Drive.FileSystemLabel) - FileSystem: $($Drive.FileSystem)"
}

# Ask user to select a drive letter
$SelectedDriveLetter = Read-Host " Enter the drive letter you want to check (without semi-colon) (e.g., C)"

# Ensure drive letter is valid
$SelectedDrive = $DriveList | Where-Object { $_.DriveLetter -eq $SelectedDriveLetter }

if (-not $SelectedDrive) {
    Write-Log "Invalid drive letter selected. Exiting."
    return
}

Write-Log "Selected drive: $($SelectedDrive.DriveLetter)"
Write-Log "--------------------------------------"

# Get the disk number for the selected drive
$SelectedDisk = Get-Disk | Where-Object { $_.PartitionStyle -ne 'RAW' } |
    Where-Object { $_.Number -in (Get-Partition -DriveLetter $SelectedDriveLetter).DiskNumber }

if (-not $SelectedDisk) {
    Write-Log " No valid partitions found on the selected drive."
    return
}

# Check alignment of each partition on the selected disk
foreach ($Partition in Get-Partition -DiskNumber $SelectedDisk.Number) {
    $Offset = $Partition.Offset
    $Alignment = $Offset % 4096

    if ($Alignment -eq 0) {
        Write-Log " Partition $($Partition.PartitionNumber) is correctly aligned." -ForegroundColor Green
    } else {
        Write-Log " Partition $($Partition.PartitionNumber) is NOT aligned. Offset: $Offset"  -ForegroundColor Red
    }
}

Write-Log " Partition alignment check completed."
pause
}

# -==================================================================================================================-
function Handle-Option3 {
Write-Host ""
Write-Host "    Display CF Card CHS values for manual BIOS Entry selected." -ForegroundColor Green
Write-Host ""
    # Get the list of drives
Write-Host " Available Drives:" -ForegroundColor Green
$drives = Get-WmiObject -Class Win32_DiskDrive

# Display a list of drives
Get-Volume | Format-Table -Property DriveLetter, FileSystemLabel, FileSystem, SizeRemaining, Size


# Log drive details to C:\CFLog.txt
$logFile = "C:\CFLog.txt"

# Prompt user to select a drive letter
$driveLetter = Read-Host " Enter the drive letter of the CF card (without semi-colon) (e.g., D)"

$found = $false

foreach ($drive in $drives) {
    # Get the partitions associated with the drive
    $partitions = Get-WmiObject -Query "ASSOCIATORS OF {Win32_DiskDrive.DeviceID='$($drive.DeviceID)'} WHERE AssocClass=Win32_DiskDriveToDiskPartition"

    foreach ($partition in $partitions) {
        # Get the logical disks associated with the partition
        $logicalDisks = Get-WmiObject -Query "ASSOCIATORS OF {Win32_DiskPartition.DeviceID='$($partition.DeviceID)'} WHERE AssocClass=Win32_LogicalDiskToPartition"

        foreach ($logicalDisk in $logicalDisks) {
            # Check if the logical disk matches the entered drive letter
            if ($logicalDisk.DeviceID -eq "$driveLetter`:" ) {
                $found = $true
                # Get the drive parameters
                $cylinders = $drive.TotalCylinders
                $heads = $drive.TotalHeads
                $sectors = $drive.TotalSectors

                # Calculate the size in MB
                $sizeInBytes = $drive.Size
                $sizeInMB = [math]::Round($sizeInBytes / 1MB, 2)

                # Display and log the drive parameters and size
                Write-Output "Drive Model: $($drive.Model)"
                Write-Output "Cylinders: $cylinders"
                Write-Output "Heads: $heads"
                Write-Output "Sectors: $sectors"
                Write-Output "Size: $sizeInMB MB"
				
				Add-Content -Path $logFile -Value "$(Get-Date) - CHS Parameters Read: "
				Add-Content -Path $logFile -Value "Drive Model: $($drive.Model)"
				Add-Content -Path $logFile -Value "Cylinders: $cylinders"
				Add-Content -Path $logFile -Value "Heads: $heads"
				Add-Content -Path $logFile -Value "Sectors: $sectors"
				Add-Content -Path $logFile -Value "Size: $sizeInMB MB"
				
				Write-Output "Output saved to C:\CFLog.txt"
            }
        }
    }
}

if (-not $found) {
    Write-Output "No drive found with the letter $driveLetter"
	pause
}
pause
}

# -==================================================================================================================-
function Handle-Option4 {

Write-Host ""
Write-Host "    Display drive, file system & partition type, and alignment value selected." -ForegroundColor Green
Write-Host ""
   # Define the log file
$LogFile = "C:\CFLog.txt"

# Function to log messages to the log file
function Log-Message {
    param (
        [string]$Message
    )
    Add-Content -Path $LogFile -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $Message"
}

# Function to display all disks and allow user selection
function Select-Drive {
    Write-Host "`nAvailable Drives:" -ForegroundColor Green
    $disks = Get-Disk
    $driveList = @()

    foreach ($disk in $disks) {
        $driveList += [PSCustomObject]@{
            Number       = $disk.Number
            FriendlyName = $disk.FriendlyName
        }
    }

    # Display drive list for user selection
    $driveList | ForEach-Object {
        Write-Host "Drive Number: $($_.Number), Model: $($_.FriendlyName)" -ForegroundColor Yellow
    }

    # Prompt user to select a drive
    $selectedDriveNumber = Read-Host "Enter the Drive Number to inspect (e.g., 0)"
    $selectedDrive = $driveList | Where-Object { $_.Number -eq [int]$selectedDriveNumber }

    if (-not $selectedDrive) {
        Write-Host "Error: Invalid drive number selected. Exiting script..." -ForegroundColor Red
        Log-Message "Invalid drive number selected."
        break
    }

    Log-Message "Selected Drive Number: $($selectedDrive.Number), Model: $($selectedDrive.FriendlyName)"
    return $selectedDrive
}

# Function to retrieve drive type, file system, partition type, and alignment value for a selected drive
function Get-DriveDetails {
    param(
        [int]$driveNumber
    )

    $disk = Get-Disk | Where-Object { $_.Number -eq $driveNumber }
    if ($disk) {
        Write-Host "Drive Type: $($disk.PartitionStyle)" -ForegroundColor Green
        Log-Message "Drive Type: $($disk.PartitionStyle)"
    } else {
        Write-Host "Drive Type: Not available" -ForegroundColor Yellow
        Log-Message "Drive Type: Not available"
    }

    $volume = Get-Volume | Where-Object { $_.DriveLetter -eq (Get-Partition -DiskNumber $driveNumber | Select-Object -First 1).DriveLetter }
    if ($volume) {
        Write-Host "File System: $($volume.FileSystem)" -ForegroundColor Green
        Log-Message "File System: $($volume.FileSystem)"
    } else {
        Write-Host "File System: Not available for this drive." -ForegroundColor Yellow
        Log-Message "File System: Not available for this drive."
    }

    $partitions = Get-Partition -DiskNumber $driveNumber
    if ($partitions) {
        foreach ($partition in $partitions) {
            $alignmentKB = $partition.Offset / 1024
            Write-Host "Partition Index: $($partition.PartitionNumber)" -ForegroundColor Green
            Write-Host "Offset: $($partition.Offset) bytes" -ForegroundColor Green
            Write-Host "Alignment Size: $alignmentKB KB" -ForegroundColor Green
            Log-Message "Partition Index: $($partition.PartitionNumber), Offset: $($partition.Offset) bytes, Alignment Size: $alignmentKB KB"
        }
    } else {
        Write-Host "No alignment information available for this drive." -ForegroundColor Yellow
        Log-Message "No alignment information available for this drive."
    }

    $partitionInfo = Get-CimInstance -Query "SELECT * FROM MSFT_Partition WHERE DiskNumber=$driveNumber" -Namespace "Root\Microsoft\Windows\Storage"
    if ($partitionInfo) {
        foreach ($partition in $partitionInfo) {
            Write-Host "Partition Type: $($partition.Type)" -ForegroundColor Green
            Log-Message "Partition Type: $($partition.Type)"
        }
    } else {
        Write-Host "No partition information available for this drive." -ForegroundColor Yellow
        Log-Message "No partition information available for this drive."
    }
pause
}

# Main script execution
$selectedDrive = Select-Drive
Get-DriveDetails -driveNumber $selectedDrive.Number

}

# Main Script
do {
    Display-Menu
    $selection = Read-Host " Please enter your choice (1-5)"
    
    switch ($selection) {
        "1" { Handle-Option1 }
        "2" { Handle-Option2 }
        "3" { Handle-Option3 }
        "4" { Handle-Option4 }
        "5" { Write-Host "Returning to Main Menu..." }
        default { Write-Host "Invalid choice. Please try again." }
    }
} while ($selection -ne "5")


}
# ===================================================================================================================================
function Option6 {
    Write-Host "SMART Test and Stats Selected"
	Start-Sleep -Seconds 2
	cls
	
# SMART Module v1.0 by MikeD
Clear-Host
Write-Host ""
Write-Host "  SMART Test - checks a drives SMART failure prediction.              SMART Module v1.0"
Write-Host ""
Write-Host " Some CF Cards support basic SMART parameters, mostly just a basic failure prediction based on power on hours"
Write-Host " and is not necissarily accurate. Just be aware, this test is not comprehensive and still needs work."
Write-Host ""

# Display a list of drives
# Show FAT and FAT32 drives
Get-Volume | Where-Object { $_.FileSystem -eq 'FAT' -or $_.FileSystem -eq 'FAT32' } | Format-Table -Property DriveLetter, FileSystemLabel, FileSystem, SizeRemaining, Size 

# Show all drives:
# Get-Volume | Format-Table -Property DriveLetter, FileSystemLabel, FileSystem, SizeRemaining, Size

# Prompt the user to select a drive
$driveLetter = Read-Host "Enter the drive letter of the disk you want to test - without a semi-colon (e.g., C)"

# Check the SMART status of the selected drive
$smartStatus = Get-WmiObject -Namespace root\wmi -Query "SELECT * FROM MSStorageDriver_FailurePredictStatus WHERE InstanceName LIKE '%$driveLetter%'"
$smartStatus | Format-Table -Property InstanceName, PredictFailure, Reason

# Display the SMART status
if ($smartStatus.PredictFailure -eq $true) {
    Write-Host "Warning: The drive is predicting a failure!" -ForegroundColor Red
} else {
    Write-Host "The drive is not predicting a failure." -ForegroundColor Green
}

# Pause before exiting
Write-Host "Press any key to exit..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")	
	
}
# ===================================================================================================================================
function Option7 {
    Write-Host "BACKUP/RESTORE CF Card Selected"
	Start-Sleep -Seconds 2
	cls
	
    function Show-Menu {
    Clear-Host
    Write-Host "BACKUP Options:  Note that FAT16 drives MBR is not fully supported" -ForegroundColor Yellow
    Write-Host "========================================================================" -ForegroundColor Green
    Write-Host "1: Backup CF Card  (Note FAT16 drives MBR might not be saved)" -ForegroundColor White
    Write-Host "2: Restore CF Card  (Note FAT16 drives MBR may not be restored)" -ForegroundColor White
    Write-Host "3: View Available Backup Files under C:\CFBackup" -ForegroundColor White
    Write-Host "4: Exit to main menu..." DarkGray
}

function Backup-CFCard {
    $cfDrive = Read-Host "Enter the CF Card drive letter (e.g., E:)"
    $backupDir = "C:\CFFiles"
    if (-not (Test-Path $backupDir)) {
        New-Item -ItemType Directory -Path $backupDir
    }
    $timestamp = Get-Date -Format "yyyyMMddHHmm"
    $backupFile = "$backupDir\CFBackup$timestamp.CFC"
    $logFile = "C:\CFLog.txt"
    Write-Host "Backing up CF Card to C:\CFBackup\CFBackup$timestamp.CFC (Year/Month/Day/Hours/Minutes Format)..."
    try {
        dism /Capture-Image /ImageFile:$backupFile /CaptureDir:$cfDrive\ /Name:"CFBackup"
        Add-Content -Path $logFile -Value "$(Get-Date) - Backup Performed on $backupFile to $cfDrive"
        Write-Host "Backup completed. Log updated."
    } catch {
        Write-Host "Error during backup: $_"
        Add-Content -Path $logFile -Value "$(Get-Date) -  Backup Failed on $backupFile to $cfDrive - Error: $_"
    }
    Pause
}

function Restore-CFCard {
    $cfDrive = Read-Host "Enter the CF Card drive letter to restore to (e.g., E:)"
    Write-Host "NOTE that FAT16 drives may not be bootable."
    Write-Host "Warning: This will overwrite the CF Card!" -ForegroundColor Red
    Write-Host "========================================================================" -ForegroundColor Green
    $backupDir = "C:\CFFiles"
    $backupFiles = Get-ChildItem -Path $backupDir -Filter *.CFC
    $backupFiles | ForEach-Object { Write-Host $_.Name }
    $backupFile = Read-Host "Enter one of the following backup file names to restore from -"
    $logFile = "C:\CFLog.txt"
    
    if (-not (Test-Path "$backupDir\$backupFile")) {
        Write-Host "Error: The backup file '$backupFile' does not exist. Returning to menu..."
        Pause
        return
    }

    Write-Host "Restoring CF Card..."
    try {
        dism /Apply-Image /ImageFile:$backupDir\$backupFile /ApplyDir:$cfDrive\ /Index:1
        Add-Content -Path $logFile -Value "$(Get-Date) - Restore Performed on $backupFile to $cfDrive"
        Write-Host "Restore completed. Log updated."
    } catch {
        Write-Host "Error during restore: $_"
        Add-Content -Path $logFile -Value "$(Get-Date) - Restore Failed on $backupFile to $cfDrive - Error: $_"
    }
    Pause
}

function View-BackupFiles {
    $backupDir = "C:\CFFiles"
    $backupFiles = Get-ChildItem -Path $backupDir -Filter *.CFC
    Write-Host "Backup files found in ${backupDir}:"
    $backupFiles | ForEach-Object { Write-Host $_.Name }
    Pause
}

function exitbackup {
    Write-Host "Exiting to main menu..."
    break
}

while ($true) {
    Show-Menu
    $choice = Read-Host "Enter your choice"
    switch ($choice) {
        1 { Backup-CFCard }
        2 { Restore-CFCard }
        3 { View-BackupFiles }
        4 { return }
        default { Write-Host "Invalid choice. Please try again." }
    }
}

}
# ===================================================================================================================================
function Option8 {
    Write-Host "Speed Test Drive selected"
	Start-Sleep -Seconds 2
	Clear-Host
    # List available drives using Get-Volume
Get-Volume | Format-Table -Property DriveLetter, FileSystemLabel, FileSystem, SizeRemaining, Size -AutoSize

# Prompt user to select a drive
$driveLetter = Read-Host "Select a drive letter (e.g., C)"

# Function to perform read/write test
function Perform-Test {
    param (
        [int]$fileSizeMB,
        [string]$testType
    )

    $filePath = "$($driveLetter):\dummyfile_$fileSizeMB.tmp"
    $dummyContent = New-Object byte[] ($fileSizeMB * 1MB)
    $logFile = "C:\CFLog.txt"

    # Measure write speed
    Write-Host "Creating and writing a dummy $fileSizeMB MB file on drive $driveLetter..."
    $writeStart = Get-Date
    [System.IO.File]::WriteAllBytes($filePath, $dummyContent)
    $writeEnd = Get-Date
    $writeDuration = ($writeEnd - $writeStart).TotalSeconds
    $writeSpeedMB = $fileSizeMB / $writeDuration
    Write-Host "$testType file test write speed: $([math]::Round($writeSpeedMB, 2)) MB/s"

    # Measure read speed
    $tempDir = "C:\Temp"
    if (-not (Test-Path -Path $tempDir)) {
        New-Item -ItemType Directory -Path $tempDir
    }
    $copyPath = "$tempDir\dummyfile_$fileSizeMB.tmp"
    Write-Host "Copying the file to a temporary directory on C drive..."
    $readStart = Get-Date
    Copy-Item -Path $filePath -Destination $copyPath
    $readEnd = Get-Date
    $readDuration = ($readEnd - $readStart).TotalSeconds
    $readSpeedMB = $fileSizeMB / $readDuration
    Write-Host "$testType file test read speed: $([math]::Round($readSpeedMB, 2)) MB/s"

    # Log results
    $logEntry = "$(Get-Date) - $testType file test: Write Speed = $([math]::Round($writeSpeedMB, 2)) MB/s, Read Speed = $([math]::Round($readSpeedMB, 2)) MB/s"
    Add-Content -Path $logFile -Value $logEntry

    # Clean up
    Remove-Item -Path $filePath
    Remove-Item -Path $copyPath

    return [PSCustomObject]@{
        WriteSpeed = $writeSpeedMB
        ReadSpeed = $readSpeedMB
    }
}

# Perform small file test (5MB)
$smallFileTest = Perform-Test -fileSizeMB 5 -testType "Small"

# Perform large file test (50MB)
$largeFileTest = Perform-Test -fileSizeMB 50 -testType "Large"

# Calculate average speeds
$averageWriteSpeed = ($smallFileTest.WriteSpeed + $largeFileTest.WriteSpeed) / 2
$averageReadSpeed = ($smallFileTest.ReadSpeed + $largeFileTest.ReadSpeed) / 2

# Display summary with colored border
$borderColor = "Yellow"
$border = "*" * 50
Write-Host -ForegroundColor $borderColor $border
Write-Host -ForegroundColor $borderColor "                  Test Results Summary                  "
Write-Host -ForegroundColor $borderColor $border
Write-Host "Small file test write speed: $([math]::Round($smallFileTest.WriteSpeed, 2)) MB/s"
Write-Host "Small file test read speed: $([math]::Round($smallFileTest.ReadSpeed, 2)) MB/s"
Write-Host "Large file test write speed: $([math]::Round($largeFileTest.WriteSpeed, 2)) MB/s"
Write-Host "Large file test read speed: $([math]::Round($largeFileTest.ReadSpeed, 2)) MB/s"
Write-Host "Average Write Speed: $([math]::Round($averageWriteSpeed, 2)) MB/s"
Write-Host "Average Read Speed: $([math]::Round($averageReadSpeed, 2)) MB/s"
Write-Host -ForegroundColor $borderColor $border

# Log average speeds
$logFile = "C:\CFLog.txt"
$logEntry = "$(Get-Date) - Average speeds: Write Speed = $([math]::Round($averageWriteSpeed, 2)) MB/s, Read Speed = $([math]::Round($averageReadSpeed, 2)) MB/s"
Add-Content -Path $logFile -Value $logEntry

# Pause before exiting
Write-Host " Results logged to C:\CFLog.txt"
# Read-Host "Press Enter to exit"

}
# ===================================================================================================================================
function Option9 {
    Write-Host "Goodbye!"
	Start-Sleep -Seconds 2
    exit
}
# ===================================================================================================================================
# Main script logic - must be at end of script
do {
    Show-Menu
    $choice = Read-Host "Enter your choice (1-9)"
    switch ($choice) {
        1 { Option1 }
        2 { Option2 }
        3 { Option3 }
        4 { Option4 }
        5 { Option5 }
        6 { Option6 }
        7 { Option7 }
        8 { Option8 }
        9 { Option9 }
        default { Write-Host "Invalid choice, please select a number between 1 and 9" -ForegroundColor Red }
    }
    Pause
} while ($choice -ne 9)
