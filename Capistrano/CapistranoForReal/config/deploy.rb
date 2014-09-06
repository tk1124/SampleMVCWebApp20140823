require 'winrm'

#
# Remove all default capistrano tasks
#
framework_taksks = [:starting, :started, :updating, :updated, :publishing, :published, :finishing, :finished]

framework_taksks.each do |t|
  Rake::Task["deploy:#{t}"].clear
end

Rake::Task[:deploy].clear


#-------------------------------------------------------------------------------

set :application, 'SampleWebApp'

#
# Methods
#
def init_passwords
  filename = File.join(Dir.getwd, 'config/deploy', fetch(:password_file))
  
  File.open(filename) do |f|
    passwords = {}
    
    f.each do |line|
      pair = line.split()
      
      passwords[pair[0]] = pair[1]
    end
    
    set :passwords, passwords
  end
end


def get_password(hostname)
  init_passwords unless fetch(:passwords)

  fetch(:passwords)[hostname]
end

def winrm_cmd(host, cmd)
  hostname = host.hostname
  username = host.user
  endpoint = "http://#{hostname}:5985/wsman"
  pass = get_password(host.hostname)
  
  std_o = "remote> #{cmd}"
  std_e = ''
  winrm = WinRM::WinRMWebService.new(endpoint, :plaintext, :user => username, :pass => pass, :basic_auth_only => true)
  winrm.cmd(cmd) do |o, e|
    std_o ? (std_o += o) : std_o = o
    std_e = e
  end

  std_o += fetch :package_name
  yield std_o, std_e
end


def compress_files(src_path, dest_file_path)
  std_o = ''
  std_e = ''
  
  cmd = "7z a -r -tzip #{dest_file_path} #{src_path}"
  winrm_cmd host, cmd do |stdout, stderr|
    std_o = stdout
    std_e = stderr
  end
  
  yield std_o, std_e
end

#
# Prepare to deploy
#
task :backup do
  on roles(:all) do |host|
    host.roles.each do |role|
      src_path = fetch(:deploy_path)[role]
      
      if src_path
        dest_path = fetch(:backup_path)[role]
        filename = fetch(:backup_filename)
        prefix = fetch(:backup_prefix)[role]
        
        src_path = File.join(src_path, '*')
        file_path = File.join(dest_path, prefix + filename+ fetch(:timestamp) + fetch(:backup_ext))
        
        compress_files(src_path, file_path) do |stdout, stderr|
          info stdout if stdout
          info stderr if stderr
        end
      end
    end
  end
end

task :archive_backup => :backup do
end

task :deploy => :archive_backup do
  on roles(:web) do
  end
end

