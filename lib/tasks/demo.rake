namespace :demo do
	desc "Resets the demo website to defaults."
	task :reset => :environment do
		mysql_config = Rails.configuration.database_configuration[Rails.env]
		username = mysql_config['username']
		password = mysql_config['password']
		database = mysql_config['database']
		
		# set maintanance notice
		
		
		# read backup into database
		system `mysql -u#{username} -p#{password} #{} < /var/www/#{username}/files/#{database}.sql`
		
		# copy backup upload-files into working-directory
		system `cp -Rf /var/www/#{username}/files/uploads /var/www/#{username}/html/alchemy-demo/shared/`
		
		# clear cache
		Rake::Task['tmp:cache:clear'].invoke
	end
	
end