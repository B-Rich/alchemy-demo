source 'http://rubygems.org'

gem 'rails', '3.1.3'
gem 'mysql2', '~> 0.3.7'
gem 'alchemy_cms', :git => 'git://github.com/magiclabs/alchemy_cms', :branch => 'next_stable'
#gem 'alchemy_cms', :path => '../alchemy-cms/alchemy_cms'

group :development do
  #gem 'mongrel'
  gem 'ruby-debug19', :require => 'ruby-debug', :platforms => :ruby_19
  gem 'ruby-debug', :platforms => :ruby_18
  gem 'capistrano'
	gem 'rails-dev-tweaks', '~> 0.5.1'
end

group :assets do
	gem 'sass-rails', '~> 3.1.4'
	gem 'coffee-rails', '~> 3.1.1'
	gem 'uglifier', '>= 1.0.3'
end

group :production do
	gem 'execjs'
	gem 'therubyracer'
end
