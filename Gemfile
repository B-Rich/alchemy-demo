if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

source 'http://rubygems.org'

gem 'rails', '~> 3.2.12'
gem 'mysql2'
gem 'alchemy_cms', github: 'magiclabs/alchemy_cms', branch: '2.6-stable'
gem 'alchemy-demo_kit', github: 'magiclabs/alchemy-demo_kit', branch: 'master'

group :development do
  gem 'debugger'
  gem 'capistrano'
  gem 'capistrano-maintenance'
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
