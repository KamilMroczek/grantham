source 'https://rubygems.org'

ruby "2.0.0"

gem 'rails', '4.0.1'

gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.0.0' # Use CoffeeScript for .js.coffee assets and views
gem 'jquery-rails' # Use jquery as the JavaScript library
gem 'turbolinks' # Turbolinks makes following links in your web application faster.
gem 'jbuilder', '~> 1.2' # Build JSON APIs with ease.
gem 'awesome_print'
gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails',
                              :github => 'anjlab/bootstrap-rails'
gem 'anjlab-widgets'

gem 'paperclip'
gem 'aws-sdk'

gem 'haml'
gem 'haml-rails'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

group :development do
  gem 'annotate'
end

group :test, :development do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'timecop'
  gem 'spork'
  gem 'rspec-set'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'bullet'
  gem 'active_record_query_trace'
  gem 'brakeman'
  gem 'rails_best_practices'
# gem 'debugger', group: [:development, :test]
end


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
