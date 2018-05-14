Vagrant.configure("2") do |config|

config.vm.define "DARKSURGEON" do |cfg|
  cfg.vm.box = "./DARKSURGEON_w10_1803_x64_hyperv.box"
  cfg.vm.hostname = "DARKSURGEON"
  cfg.vm.guest = :windows
  cfg.vm.communicator = "winrm"
  cfg.vm.boot_timeout = 300

  # Disabling Shared Folders
  cfg.vm.synced_folder ".", "/vagrant", disabled: true

  # System Administrator Credentials
  # Recommend Changing These In Production
  cfg.winrm.username = "darksurgeon"
  cfg.winrm.password = "darksurgeon"

  cfg.vm.provider 'hyperv' do |hv|
    hv.ip_address_timeout = 240
    hv.memory = 4096
    end
  end
end
