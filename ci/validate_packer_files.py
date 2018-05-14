import os
import sys

packer_test_failed_files = []    

def test_packer_files():
    # check for critical files
    critical_files_list = [
        "darksurgeon_packer.json",
        "Vagrantfile",
        "./configuration/configuration-files/start_layout.xml",
        "./configuration/iso-scripts/answer.iso",
        "./configuration/iso-scripts/Autounattend.xml",
        "./configuration/iso-scripts/Post-Autounattend.xml",
        "./configuration/iso-scripts/Set-WinRMConfiguration.ps1",
        "./configuration/iso-scripts/Autounattend.xml",
        "./configuration/helper-scripts/Get-GitRepository.ps1",
        "./configuration/helper-scripts/Install-ChocolateyPackage.ps1",
        "./configuration/helper-scripts/Install-PowershellModule.ps1"
        ]

    for file in critical_files_list:
        if os.path.exists(file):
            print('Found expected file: %s') % file
        else:
            print('Did not find expected file: %s') % file
            packer_test_failed_files.append(file)

    if len(packer_test_failed_files) > 0:
        print('Test failed. Missing packer files.')
        print(packer_test_failed_files)
        sys.exit(1)

    else: 
        print('Test passed. No packer files missing.')
        sys.exit(0)

test_packer_files()