set :application, "alchemy-demo"
set :repository,  "git://github.com/magiclabs/#{application}.git"

set :scm, :git

role :web, "alchemy-app.com"
role :app, "alchemy-app.com"
role :db,  "alchemy-app.com", :primary => true

set :deploy_to, "/var/www/web1/html/demo"
ssh_options[:port] = 12312

set(:user) { Capistrano::CLI.ui.ask("Type in the ssh username: ") }
set(:password) { Capistrano::CLI.password_prompt("Type in the password for #{user}: ") }
set :use_sudo, false

after "deploy:symlink", :symlink_database_yml
before "deploy:restart", "deploy:migrate"
before "deploy:restart", "deploy:seed"

# Alchemy recipes from vendor/plugins/alchemy/recipes/alchemy_capistrano_tasks.rb

before "deploy:restart", "alchemy:db:migrate"
before "deploy:restart", "alchemy:assets:copy"

after "deploy:setup", "alchemy:shared_folders:create"
after "deploy:symlink", "alchemy:shared_folders:symlink"

# Custom tasks

desc "Symlinks the database.yml"
task :symlink_database_yml do
  run "ln -nfs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
end

namespace :deploy do
  
  task :start do ; end
  task :stop do ; end
  
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  desc 'Seeds the database'
  task :seed, :roles => :app, :except => { :no_release => true } do
    run "cd #{release_path} && RAILS_ENV=production rake db:seed"
  end
  
end
