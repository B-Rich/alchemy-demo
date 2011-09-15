# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.14' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'acts_as_ferret', :version => '0.4.8.2'
  config.gem 'authlogic', :version => '~>2'
  config.gem 'awesome_nested_set', :version => '~>1.4'
  config.gem 'declarative_authorization', :version => '>=0.4.1'
  config.gem "fleximage", :version => "~>1.0.4"
  config.gem 'fast_gettext', :version => '>=0.4.8'
  config.gem 'gettext', :lib => false, :version => '>=1.93.0'
  config.gem 'gettext_i18n_rails', :version => '~>0.2'
  config.gem 'jk-ferret', :version => '~>0.11.8', :lib => 'ferret'
  config.gem 'mimetype-fu', :version => '>=0.1.2', :lib => 'mimetype_fu'
  config.gem 'mysql'
  config.gem 'rmagick', :lib => "RMagick2", :version => '>=2.12.2'
  config.gem 'will_paginate', :version => '~>2.3'
  config.autoload_paths += %W( vendor/plugins/alchemy/app/sweepers )
  config.autoload_paths += %W( vendor/plugins/alchemy/app/middleware )
  config.i18n.load_path += Dir[Rails.root.join('vendor/plugins/alchemy/config', 'locales', '*.{rb,yml}')]
  config.time_zone = 'Berlin'
  config.i18n.default_locale = :en
end
