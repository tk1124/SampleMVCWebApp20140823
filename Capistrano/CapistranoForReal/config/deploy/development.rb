server 'ec2-54-64-38-77.ap-northeast-1.compute.amazonaws.com', user: 'administrator', roles: %w{web}

set :package_name, 'SampleWebApp.zip'
set :built_module_path, ''
set :distribution_path, ''
set :work_path, 'C:\work'
set :backup_path, 'C:\work\backup'
set :backup_archive_path, 'C:\work\archive'

set :wwwroot, 'C:\Inetpub\wwwroot'
