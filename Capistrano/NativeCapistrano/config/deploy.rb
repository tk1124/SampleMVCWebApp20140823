require 'winrm'

#
# Remove all default capistrano tasks
#
framework_taksks = [:starting, :started, :updating, :updated, :publishing, :published, :finishing, :finished]

framework_taksks.each do |t|
	Rake::Task["deploy:#{t}"].clear
end

Rake::Task[:deploy].clear

task :deploy do
	run_locally do
		info "deploy"
	end
end



#-------------------------------------------------------------------------------

set :application, 'SampleWebApp'



#
# Prepare to deploy
#
task :prepare do
	run_locally do
		src_file = File.join(fetch(:built_module_path), fetch(:package_name))
		dest_path = fetch :distribution_path
		
info dest_path
		
		#output = capture "copy #{src_file} #{dest_path}"
		#info output
	end
end

task :backup do
  on roles(:web) do
  	archive_name = fetch(:package_name) + '_backup_20140824.zip'
  	backup_file = File.join(fetch(:backup_path), archive_name)
  	target_path = fetch :wwwroot
  	
  	#output = capture "7z a -r #{backup_file} #{target_path}"
  	#info output
  end
end

task :archive_backup => :backup do
	on roles(:web) do
  	archive_name = fetch(:package_name) + '_backup_20140824.zip'
  	backup_file = File.join(fetch(:backup_path), archive_name)
  	
  	#output = capture "copy /-Y #{backup_file} #{fetch :backup_archive_path}"
  	#info output
	end
end

task :get_module do
	on roles(:web) do
		module_path = File.join(fetch(:distribution_path), fetch(:package_name))
		unpack_path = File.join(fetch(:work_path), '20140824')
		
		#execute "mkdir "#{fetch :unpack_path}"
		#output = capture "copy /-Y #{module_path} #{unpack_patc}"
		#info output
	end
end

task :deploy => [:archive_backup, :get_module] do
	on roles(:web) do
	end
end
