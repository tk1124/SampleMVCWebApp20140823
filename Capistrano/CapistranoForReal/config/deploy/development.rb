server '54.64.130.38', roles: %w{web}, user: 'administrator'


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
  :web => 'C:\Intepub\wwwroot\web',
  :app => 'C:\Intepub\wwwroot\app'
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
