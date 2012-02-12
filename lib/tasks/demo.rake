namespace :demo do
	desc "Resets the demo website to defaults."
	task :reset => :environment do
		mysql_config = Rails.configuration.database_configuration[Rails.env]
		username = mysql_config['username']
		password = mysql_config['password']
		database = mysql_config['database']
		
		# TODO: set maintenance notice
		
		# recreate database
		Rake::Task['db:drop'].invoke
		Rake::Task['db:create'].invoke
		# read backup into database
		system `mysql -u#{username} -p#{password} #{database} < /var/www/#{username}/files/#{database}.sql`
		
		# delete all uploaded files
		system `rm -Rf /var/www/#{username}/html/alchemy-demo/shared/uploads/*`
		# copy backup upload-files into working-directory
		system `cp -Rf /var/www/#{username}/files/uploads/* /var/www/#{username}/html/alchemy-demo/shared/uploads/`
		
		# clear cache
		Rake::Task['tmp:cache:clear'].invoke
		system `rm -Rf /var/www/#{username}/html/alchemy-demo/current/public/pictures/*`

		# Reindex the text search
		Rake::Task['ferret:rebuild_index'].invoke

		# Restart the application
		system `touch /var/www/#{username}/html/alchemy-demo/current/tmp/restart.txt`
	end
	
end
