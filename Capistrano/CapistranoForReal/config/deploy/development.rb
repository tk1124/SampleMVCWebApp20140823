server 'localhost', roles: %w{web}, user: 'administrator'


set :password_file, 'password'
password_file = 'password'

#
#
#
set :package_name, 'SampleWebApp.zip'
set :built_module_path, ''
set :distribution_path, ''
set :work_path, 'C:\work'
set :backup_path, 'C:\work\backup'
set :backup_archive_path, 'C:\work\archive'
set :backup_filename, '_Backup_'

set :wwwroot, 'C:\Inetpub\wwwroot'

set :deploy_path, {
  :web => 'C:\Inetpub\wwwroot',
  :app => 'C:\Inetpub\wwwroot'
};

set :backup_path, {
  :web => 'C:\work\backup\web',
  :app => 'C:\work\backup\app'
};

set :backup_prefix, {
  :web => 'WEB',
  :app => 'APP'
};

set :backup_ext, '.zip'

set :timestamp, Time.now.strftime("%Y%m%d_%H%M%S")



#
# Set password to each host
#
