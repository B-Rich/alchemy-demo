namespace :demo do

  desc "Resets the demo website to defaults."
  task :reset => :environment do
    mysql_config = Rails.configuration.database_configuration[Rails.env]
    username = mysql_config['username']
    password = mysql_config['password']
    database = mysql_config['database']

    # Set maintenance notice
    system `echo "<h1>We are doing maintenance. Please stay tuned</h1>" > /var/www/alchemy-demo/shared/system/maintenance.html`

    # recreate database
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke

    # read backup into database
    system `mysql -u#{username} -p#{password} #{database} < /home/#{username}/files/alchemy-demo.sql`

    # delete all uploaded files
    system `rm -Rf /var/www/alchemy-demo/shared/uploads/*`

    # copy backup upload-files into working-directory
    system `cp -Rf /home/#{username}/files/uploads/* /var/www/alchemy-demo/shared/uploads/`

    # clear cache
    Rake::Task['tmp:cache:clear'].invoke
    system `rm -Rf /var/www/alchemy-demo/current/public/pictures/*`

    # Reindex the text search
    Rake::Task['ferret:rebuild_index'].invoke

    # Restart the application
    system `rm /var/www/alchemy-demo/shared/system/maintenance.html`
    system `touch /var/www/alchemy-demo/current/tmp/restart.txt`
  end

end
