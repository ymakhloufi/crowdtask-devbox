HOSTS=["pma.crowdtask.local", "www.crowdtask.local", "crowdtask.local", "api.crowdtask.local"]

current_dir       = File.dirname(File.expand_path(__FILE__))
config_file       = "#{current_dir}/config.yml"
config_file_local = "#{current_dir}/config.local.yml"

config = YAML.load_file(config_file)

if File.exist?(config_file_local)
    config.merge!(YAML.load_file(config_file_local))
end

HOSTNAME = config['hostname']
MEMORY   = config['memory']
CPUS     = config['cpus']

# Check to determine whether we're on a windows or linux/os-x host,
# later on we use this to launch ansible in the supported way
# source: https://stackoverflow.com/questions/2108727/which-in-ruby-checking-if-program-exists-in-path-from-ruby
def which(cmd)
    exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
    ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
        exts.each { |ext|
            exe = File.join(path, "#{cmd}#{ext}")
            return exe if File.executable? exe
        }
    end
    return nil
end

Vagrant.configure("2") do |config|

    # VM guest settings
    config.vm.box = "hbsmith/awslinux"
    config.vm.network "private_network", ip: "192.168.111.101"
    config.ssh.forward_agent = true
    config.disksize.size = '20GB'

    # VM hardware config
    config.vm.provider :virtualbox do |vb|
        vb.name = HOSTNAME
        vb.memory = MEMORY
        vb.cpus = CPUS
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
        vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    end

    # Check if the hostnamager plugin exists and use it if it does.
    if Vagrant.has_plugin? 'vagrant-hostmanager'
        config.hostmanager.enabled = true
        config.hostmanager.manage_host = true
        config.hostmanager.ignore_private_ip = false
        config.hostmanager.include_offline = true
        config.hostmanager.aliases = HOSTS
    end

    # Mount a shared folder and code directories
    config.vm.synced_folder "./share", "/home/vagrant/share",
        owner: "vagrant",
        group: "vagrant",
        mount_options: ["dmode=777,fmode=777"]
    config.vm.synced_folder "./code", "/home/vagrant/code",
        owner: "vagrant",
        group: "vagrant",
        mount_options: ["dmode=777,fmode=777"]
    config.vm.synced_folder "./ansible", "/home/vagrant/ansible",
        owner: "vagrant",
        group: "vagrant",
        mount_options: ["dmode=777,fmode=777"]

    # If ansible is in your path it will provision from your HOST machine
    # If ansible is not found in the path it will be instaled in the VM and provisioned from there
    if which('ansible-playbook')
        config.vm.provision "ansible" do |ansible|
            ansible.playbook = "ansible/playbook.yml"
            ansible.inventory_path = "ansible/inventory"
            ansible.limit = 'all'
            #ansible.tags = ['elasticsearch']
        end
    else
        config.vm.provision :shell, path: "ansible/windows.sh", args: [HOSTNAME]
    end

end
