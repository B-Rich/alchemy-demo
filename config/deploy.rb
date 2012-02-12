require "bundler/capistrano"
require "alchemy/capistrano"
load 'deploy/assets'

set :application, "alchemy-demo"
set :repository,  "git://github.com/magiclabs/#{application}.git"

set :scm, :git
set :deploy_via, :remote_cache
set :copy_exclude, [".svn", ".DS_Store"]

set(:user) { Capistrano::CLI.ui.ask("Type in the ssh username: ") }
set(:password) { Capistrano::CLI.password_prompt("Type in the password for #{user}: ") }
set :use_sudo, false

role :web, "rv2.nethosting4you-server.de"
role :app, "rv2.nethosting4you-server.de"
role :db,  "rv2.nethosting4you-server.de", :primary => true

set :deploy_to, "/var/www/#{user}/html/#{application}"
ssh_options[:port] = 12312

after "deploy:setup", "deploy:db:setup" unless fetch(:skip_db_setup, false)
before "deploy:start", "deploy:seed"
after "deploy:assets:symlink", "deploy:db:symlink"
before "deploy:restart", "deploy:migrate"
after "deploy", "deploy:cleanup"

namespace :logs do
  desc "show last 100 lines of production.log"
  task :tail do
    run "tail -n100 #{shared_path}/log/production.log"
  end

  desc "watch tail of production.log and wait for additional data to be appended to the input"
  task :watch do
    stream("tail -f #{shared_path}/log/production.log")
  end
end

namespace :deploy do
  
  task :start do ; end
  task :stop do ; end
  
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  namespace :db do
    
    desc "[internal] Backups the current database"
    task :dump do
      db_name = Capistrano::CLI.ui.ask("Database name: ")
      run "mysqldump -u#{Capistrano::CLI.ui.ask("Database username: ")} -p#{Capistrano::CLI.ui.ask("Database password: ")} #{db_name} > ~/files/#{db_name}.sql"
    end
    
  end
  
end
