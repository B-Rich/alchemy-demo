source 'http://rubygems.org'

gem 'rails', '3.2.11'
gem 'mysql2'
gem 'alchemy_cms', github: 'magiclabs/alchemy_cms', branch: 'master'
gem 'alchemy-demo_kit', github: 'magiclabs/alchemy-demo_kit', branch: 'master'

group :development do
  gem 'debugger',   :platforms => :ruby_19
  gem 'ruby-debug', :platforms => :ruby_18
  gem 'capistrano'
end

group :assets do
  gem 'sass-rails',      '~> 3.2.3'
  gem 'coffee-rails',    '~> 3.2.1'
  gem 'uglifier',        '>= 1.0.3'
  gem 'turbo-sprockets-rails3'
end

group :production do
  gem 'therubyracer'
end
