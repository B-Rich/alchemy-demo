require 'bundler/capistrano'
require 'alchemy/capistrano'

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

after "deploy:symlink", "deploy:db:symlink"

before "deploy:restart", "deploy:migrate"
before "deploy:restart", "deploy:seed"

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
  
  desc 'Seeds the database'
  task :seed, :roles => :app, :except => { :no_release => true } do
    run "cd #{release_path} && RAILS_ENV=production rake db:seed"
  end
  
  namespace :db do
    
    desc <<-DESC
      Creates the database.yml configuration file in shared path.

      By default, this task uses a template unless a template \
      called database.yml.erb is found either is :template_dir \
      or /config/deploy folders. The default template matches \
      the template for config/database.yml file shipped with Rails.

      When this recipe is loaded, db:setup is automatically configured \
      to be invoked after deploy:setup. You can skip this task setting \
      the variable :skip_db_setup to true. This is especially useful \ 
      if you are using this recipe in combination with \
      capistrano-ext/multistaging to avoid multiple db:setup calls \ 
      when running deploy:setup for all stages one by one.
    DESC
    
    task :setup, :except => { :no_release => true } do
      
      default_template = <<-EOF
      production:
        adapter: mysql
        encoding: utf8
        reconnect: false
        pool: 5
        database: #{ Capistrano::CLI.ui.ask("Database name: ") }
        username: #{ Capistrano::CLI.ui.ask("Database username: ") }
        password: #{ Capistrano::CLI.ui.ask("Database password: ") }
        socket: #{ Capistrano::CLI.ui.ask("Database socket: ") }
      EOF
      
      location = fetch(:template_dir, "config/deploy") + '/database.yml.erb'
      template = File.file?(location) ? File.read(location) : default_template
      
      config = ERB.new(template)
      
      run "mkdir -p #{shared_path}/config" 
      put config.result(binding), "#{shared_path}/config/database.yml"
    end
    
    desc <<-DESC
      [internal] Updates the symlink for database.yml file to the just deployed release.
    DESC
    task :symlink, :except => { :no_release => true } do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
    end
    
  end
  
end
