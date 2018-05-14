# DARKSURGEON
CircleCI Status: [![CircleCI](https://circleci.com/gh/cryps1s/DARKSURGEON/tree/master.svg?style=svg&circle-token=ca6d1b0e40ebf6408c581810c0c328b9b807e516)](https://circleci.com/gh/cryps1s/DARKSURGEON/tree/master)

## About DARKSURGEON

DARKSURGEON is a Windows packer project to empower incident response, digital forensics, malware analysis, and network defense.

DARKSURGEON has three stated goals:

* Accelerate incident response, digital forensics, malware analysis, and network defense with a preconfigured Windows 10 environment complete with tools, scripts, and utilities. 
* Provide a framework for defenders to customize and deploy their own programmatically-built Windows images using Packer and Vagrant.
* Reduce the amount of latent telemetry collection, minimize error reporting, and provide reasonable privacy and hardening standards for Windows 10.

If you haven't worked with packer before, this project has a simple premise:

Provide all the tools you need to have a productive, secure, and private Windows virtual machine so you can spend less time tweaking your environment and more time fighting bad guys.

**Please note this is an alpha project** and it will be subject to continual development, updates, and package breakage.

### Development Principles

DARKSURGEON is based on a few key development principles:

* **Modularity is key**. Each component of the installation and configuration process should be modular. This allows for individuals to tailor their packer image in the most flexible way.
* **Builds must be atomic**. A packer build should either complete all configuration and installation tasks without errors, or it should fail. A packer image with missing tools is a failure scenario.
* **Hardened out of the box**. To the extent that it will not interfere with investigative workflows, all settings related to proactive hardening and security controls should be enabled. Further information on DARKSURGEON security can be found later in this post. 
* **Instrumented out of the box**.  To the extent that it will not interfere with investigative workflows, Microsoft Sysmon, Windows Event Logging, and osquery will provide detailed telemetry on host behavior without further configuration.
* **Private out of the box**. To the extent that it will not interfere with investigative workflows, all settings related to privacy, Windows telemetry, and error reporting should minimize collection.

### Hardening

DARKSURGEON is hardened out of the box, and comes with scripts to enable High or Low security modes.

All default installations of DARKSURGEON have the following security features enabled:

* Windows Secure Boot is Enabled.
* Windows Event Log Auditing is Enabled. (Palantir Windows Event Forwarding Guidance)
* Windows Powershell Auditing is Enabled. (Palantir Windows Event Forwarding Guidance)
* Windows 10 Privacy and Telemetry are Reduced to Minimal Settings. (Microsoft Guidance)
* Sysinternals Sysmon is Installed and Configured. (SwiftonSecurity Public Ruleset)
* LLMNR is Disabled.
* NBT is Disabled.
* WPAD is Removed.
* Powershell v2 is Removed.
* SMB v1 is Removed.
* Application handlers for commonly-abused file extensions are changed to notepad.exe.

Additionally, the user may specify a Low or High security mode by using the appropriate scripts. The default setting is to build an image in Low Security mode.

 Low Security mode is primarily used for virtual machines intended for reverse engineering, malware analysis, or systems that cannot support VBS security controls.

 In Low Security mode, the following hardening features are configured:

* Windows Defender Anti-Virus Real-Time Scanning is Disabled.
* Windows Defender SmartScreen is Disabled.
* Windows Defender Credential Guard is Disabled.
* Windows Defender Exploit Guard is Disabled.
* Windows Defender Exploit Guard Attack Surface Reduction (ASR) is Disabled.
* Windows Defender Application Guard is Disabled.
* Windows Defender Application Guard does not enforce isolation.

**Note: High Security mode is still in development.**

High Security mode is primarily used for production deployment of sensitive systems (e.g. Privileged Access Workstations) and may require additional tailoring or configuration.

 In High Security mode, the following hardening features are configured:

* Windows Defender Anti-Virus Real-Time Scanning is Enabled.
* Windows Defender SmartScreen is Enabled and applied to All Traffic.
* Windows Defender Credential Guard is Enabled.
* Windows Defender Exploit Guard is Enabled.
* Windows Defender Exploit Guard Attack Surface Reduction (ASR) is Enabled.
* Windows Defender Application Guard is Enabled.
* Windows Defender Application Guard enforces isolation.

### Telemetry

Whether analyzing unknown binaries or working on sensitive projects, endpoint telemetry powers detection and response operations. DARKSURGEON comes pre-configured with the following telemetry sources available for analysis:

* Windows Event Log Auditing is enabled. [(Palantir Windows Event Forwarding Guidance).](https://github.com/palantir/windows-event-forwarding)
* Windows Powershell Auditing is enabled. [(Palantir Windows Event Forwarding Guidance).](https://github.com/palantir/windows-event-forwarding)
* Sysinternals Sysmon is installed and configured. [(SwiftonSecurity Ruleset)](https://github.com/SwiftOnSecurity/sysmon-config)

### Privacy

Your operational environment contains some of the most sensitive data from your network, and it's important to safeguard that from prying eyes. DARKSURGEON implements the following strategies to maximize privacy without hindering workflows:

* Windows 10 telemetry settings are configured to minimize collection.
* Cortana, diagnostics, tracking, and other services are disabled.
* Windows Error Reporting (WER) is disabled.
* Windows Timeline, shared clipboard, device hand-off,  and other synchronize-by-default applications are disabled or neutered. 
* Microsoft Guidance for reducing telemetry and data collection has been implemented.

### Packages

Out of the box, DARKSURGEON comes equipped with tools, scripts, and binaries to make your life as a defender easier.

**Android Analysis:**

Tools, scripts, and binaries focused on android analysis and reverse engineering.

* APKTool (FLARE)

**Blue Team:**

Tools, scripts, and binaries focused on blue team, network defense, and alerting/detection development.

* ACE
* Bloodhound / Sharphound
* CimSweep
* Dumpsterfire
* EndGame Red Team Automation (RTA)
* Kansa
* Posh-Git
* Invoke-ATTACKAPI
* LOLBAS (Living Off the Land Binaries And Scripts)
* OSX Collector
* Posh-SecMod
* Posh-Sysmon
* PowerForensics
* PowerSploit
* Practical Malware Analysis Labs (FLARE)
* Revoke-Obfuscation
* Yara (FLARE)

**Debuggers:**

Tools, scripts, and binaries for debugging binary artifacts.

* Ollydbg (FLARE)
* OllyDump (FLARE)
* OllyDumpEx (FLARE)
* Ollydbg2 (FLARE)
* OllyDump2Ex (FLARE)
* x64dbg (FLARE)
* Windbg (FLARE)

**Disassemblers:**

Tools, scripts, and binaries for disassembling binary artifacts.

* IDA Free Trial (FLARE)
* Binary Ninja Demo (FLARE)
* Radare2 (FLARE)

**Document Analysis:**
Tools, scripts, and binaries for performing analysis of documents.

* OffVis (FLARE)
* OfficeMalScanner (FLARE)
* PDFId (FLARE)
* PDFParser (FLARE)
* PDFStreamDumper (FLARE)

**DotNet Analysis:**

Tools, scripts, and binaries for performing analysis of DotNet artifacts.

* DE4Dot (FLARE)
* DNSpy (FLARE)
* DotPeek (FLARE)
* ILSpy (FLARE)

**Flash Analysis:**

Tools, scripts, and binaries for performing analysis of flash artifacts.

* FFDec (FLARE)

**Forensic Analysis:**

Tools, scripts, and binaries for performing forensic analysis on application and operating system artifacts.

* Amcache Parser
* AppCompatCache Parser
* IISGeolocate
* JLECmd
* LECmd
* JumpList Explorer
* PECmd
* Registry Explorer
* Regshot (FLARE)
* Shellbags Explorer
* Timeline Explorer
* TSK (The Sleuthkit)
* Volatility
* X-Ways Forensics Installer Manager (XWFIM)

**Hex Editors:**

* FileInsight (FLARE)
* HxD (FLARE)
* 010 Editor (FLARE)

**Java Analysis:**

* JD-GUI (FLARE)
* Dex2JAR

**Network Analysis:**

* Burp Free
* FakeNet-NG (FLARE)
* Wireshark (FLARE)

**PE Analysis:**

* DIE (FLARE)
* EXEInfoPE (FLARE)
* Malware Analysis Pack (MAP) (FLARE)
* PEiD (FLARE)
* ExplorerSuite (CFF Explorer) (FLARE)
* PEStudio (FLARE)
* PEview (FLARE)
* Resource Hacker (FLARE)
* VirusTotal Uploader

**Powershell Modules:**

* Active Directory
* Azure Management
* Pester

**Python Libraries:**

* Cryptography
* Hexdump
* OLETools
* LXML
* Pandas
* Passivetotal
* PEFile
* PyCryptodome
* Scapy
* Shodan
* Sigma
* Visual C++ for Python
* Vivisect
* WinAppDBG
* Yara-Python

**Red Team:**

* Grouper
* Inveigh
* Nmap
* Powershell Empire
* PowerupSQL
* PSAttack
* PSAttack Build Tool
* Responder

**Remote Management:**

* AWS Command Line (AWSCLI)
* OpenSSH
* Putty
* Remote Server Administration Tools (RSAT)

**Utilities:**

* 1Password
* 7Zip
* Adobe Flash Player
* Adobe Reader
* API Monitor
* Bleachbit
* Boxstarter
* Bstrings
* Checksum
* Chocolatey
* Cmder
* Containers (Hyper-V)
* Curl
* Cyber Chef
* Docker
* DotNet 3.5
* DotNet 4
* Exiftool
* FLOSS (FLARE)
* Git
* GoLang
* Google Chrome
* GPG4Win
* Hashcalc
* Hashdeep
* Hasher
* Hashtab
* Hyper-V
* Irfanview
* Java JDK8
* Java JRE8
* JQ
* Jupyter
* Keepass
* Microsoft Edge
* Mozilla Firefox
* Mozilla Thunderbird
* Neo4j Community
* NodeJS
* Nuget
* Office365 ProPlus
* OpenVPN
* Osquery
* Python 2.7
* Qbittorrent
* RawCap
* Slack
* Sublime Text 3
* Sysinternals Suite
* Tor Browser
* UnixUtils
* UPX
* Visual C++ 2005
* Visual C++ 2008
* Visual C++ 2010
* Visual C++ 2012
* Visual C++ 2013
* Visual C++ 2015
* Visual C++ 2017
* Visual Studio Code
* Windows 10 SDK
* Windows Subsystem for Linux (WSL)
* Winlogbeat
* XorSearch
* XorStrings

**Visual Basic Analysis:**

* VBDecompiler

## Building DARKSURGEON

### Build Process

DARKSURGEON is built using the HashiCorp application packer. The total build time for a new instance of DARKSURGEON is around 2–3 hours.

1. Packer creates a new virtual machine using the DARKSURGEON JSON file and your hypervisor of choice (e.g. Hyper-V, Virtualbox, VMWare).
2. The answers.iso file is mounted inside the DARKSURGEON VM along with the Windows ISO. The answers.iso file contains the unattend.xml needed for a touchless installation of windows, as well as a powershell script to configure Windows Remote Management (winrm).
3. Packer connects to the DARKSURGEON VM using WinRM and copies over all files in the helper-scripts and configuration-files directory to the host.
4. Packer performs serial installations of each of the configured powershell scripts, performing occasional reboots as needed. 
5. When complete, packer performs a sysprep, shuts down the virtual machine, and creates a vagrant box file. Additional outputs may be specified in the post-processors section of the JSON file.

### Setup

**Note: Hyper-V is currently the only supported hypervisor in this alpha release. VirtualBox and VMWare support are forthcoming.**

1. Install packer, vagrant, and your preferred hypervisor on your host.
2. Download the repository contents to your host.
3. Download a Windows 10 Enterprise Evaluation ISO (1803).
4. Move the ISO file to your local DARKSURGEON repository.
5. Update DARKSURGEON.json with the ISO SHA1 hash and file name.
6. (Optional) Execute the powershell script New-DARKSURGEONISO.ps1 to generate a new answers.iso file. There is an answers ISO file included in the repository but you may re-build this if you don't trust it, or you would like to modify the unattend files: `powershell.exe New-DARKSURGEONISO.ps1`
7. Build the recipe using packer: `packer build -only=[hyperv-iso|vmware|virtualbox] .\DARKSURGEON.json`

## Configuring DARKSURGEON

DARKSURGEON is designed to be modular and easy to configure. An example configuration is provided in the *DARKSURGEON.json* file, but you may add, remove, or tweak any of the underlying scripts.

Have a custom CA you need to add? Need to add a license file for IDA? No problem. You can throw any files you need in the **configuration-files** directory and they'll be copied over to the host for you.

Want to install a custom package, or need some specific OS tweaks? No worries. Simply make a new powershell script (or modify an existing one) in the **configuration-scripts** directory and add it as a build step in the packer JSON file.

## Using DARKSURGEON

**Note: Hyper-V is currently the only supported hypervisor in this alpha release. VirtualBox and VMWare support are forthcoming.**

Once DARKSURGEON has successfully built, you'll receive an output  vagrant box file. The box file contains the virtual machine image and vagrant metadata, allowing you to quickly spin up a virtual machine as needed.

1. Install vagrant and your preferred hypervisor on your host.
2. Navigate to the DARKSURGEON repository (or the location where you've saved the DARKSURGEON box file). 
3. Perform a vagrant up: `vagrant up`

Vagrant will now extract the virtual machine image from the box file, read the metadata, and create a new VM for you. Want to kill this VM and get a new one?

Easy, just perform the following:
`vagrant destroy && vagrant up`

Once the DARKSURGEON virtual machine is running, you can login using one of the two local accounts:

**Note**: These are default accounts with default credentials. You may want to consider changing the credentials in your packer build.

**Administrator Account:**

Username: Darksurgeon

Password: darksurgeon

**Local User Account:**

Username: Unprivileged

Password: unprivileged

If you'd rather not use vagrant, you can either import the VM image manually, or look at one of the many other post-processor options provided by packer.

## Downloading DARKSURGEON

If you'd rather skip the process of building DARKSURGEON and want to trust the box file I've built, [you can simply download it here.](https://darksurgeon.io/files/DARKSURGEON_w10_1803_x64_hyperv.box)

## Contributing

Contributions, fixes, and improvements can be submitted directly against this project as a GitHub issue or pull request. Tools will be reviewed and added on a case-by-case basis.

## Frequently Asked Questions

### Why is Hyper-V the preferred hypervisor?

I strongly believe in the value of Windows Defender Device Guard and Virtualization Based Security, which require the usage of Hyper-V for optimal effectiveness. As a result, other Hypervisors are not recommended on the host machine. I will do my best to accomodate other mainline hypervisors, but I would encourage all users to try using Hyper-V.

### Why does the entire packer build fail on a chocolatey package error?

This was a design decision that was made to guarantee that all packages which were expected made it into the final packer build. The upside of this decision is that it guarantees all expected tools will be available in the finalized product. The downside is that additional complexity and fragility are inserted the build pipeline, as transient or chocolatey errors may cause a build to fail.

If you wish to ignore this functionality, you are free to modify the underlying script to ignore errors on package installation.

### Does this project support using a Chocolatey Professional/Business/Consultant license?

Yes. If you add your license file (named `chocolatey.license.xml`) to the configuration-files directory when performing a packer build, it will automatically be imported by the `Set-ChocolateySettings.ps1` script. Please ensure that your usage of a chocolatey license adheres to their End-User License Agreement.

### Why are the build functions broken into dozens of individual powershell scripts

Flexibility is key. You may opt to use -- or not use -- any of these scripts, and in any order. Having individual files, while increasing project complexity, ensures that the project can be completely customized without issue.

### I want to debug the build. How do I do so?

Add the `Set-Breakpoint.ps1` script into the provisioner process at the desired point. This will cause the packer build to halt for 4 hours as it waits for the script to complete.

## Troubleshooting

### The packer build process never starts and hangs on the UEFI screen.

This is most likely a timing issue caused by the emulated key presses not causing the image to boot from the mounted Windows ISO. Restart your VM and hit any button a few times until the build process starts.

### Packer timed out during the build. I didn't receive an error.

Due to the size of the packages that are downloaded and installed, you may have exceeded the default packer build time limit.

### My VM is running, but packer doesn't seem to connect via WinRM.

Connect to the guest and check the following:

* WinRM is accessible from your packer host. (`Test-NetConnection -ComputerName <Packer IP Address> -Port 5985`)
* WinRM is allowed on the guest firewall.

### I keep getting anti-virus, checksum, or other issues with Chocolatey. What gives?

Unfortunately these packages can be a moving target. New updates can render the static checksum in the chocolatey package incorrect, anti-virus may mistakenly flag binaries, etc. Global chocolatey options can be specified to prevent these errors from occurring, but I will do my best to respond to bug reports filed as issues on underlying chocolatey packages.

## License Acceptance

You as a user of this project must review, accept, and comply with the license terms of each downloaded/installed package. If you do not wish to comply with the license terms of any specific software component, please remove that package from your packer build, or do not use this project.

## License

MIT License

Copyright (c) 2018

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Further Reading and Acknowledgements

This project stands on the shoulders of giants, and I cannot properly thank all of the original authors for their work, contributions, and inspiration.

* [Joe Fitzgerald for pioneering Windows packer projects.](https://github.com/joefitzgerald)
* The FLARE team at FireEye for their awesome work on the [chocolatey packages and repository for the FLAREVM project.](https://github.com/fireeye/flare-vm)
* [Chris Long](https://twitter.com/Centurion) for his awesome work on DetectionLab and the packer CI pipeline.
* All of the authors, chocolatey package maintainers, and tool writers that made this possible.
* Friends and colleagues for challenging me to finally open source this project.