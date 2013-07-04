source 'https://rubygems.org'

########################################
# Core
########################################

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.beta1'

# Use MySQL
gem 'mysql2'

# jQuery
gem 'jquery-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 4.0.0.beta1'
  gem 'coffee-rails', '~> 4.0.0.beta1'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  # App server
  gem 'unicorn'
end

group :development do
  # Use debugger
  gem 'debugger'

  # Pry
  gem 'pry-rails'
  gem 'pry-plus'

  # App Server
  gem 'thin'

  # Quiet Assets
  gem 'quiet_assets'
end

########################################
# Convenience
########################################

# Embed the V8 JavaScript interpreter into Ruby.
gem 'therubyracer', platforms: :ruby

# Use Less stylesheet language
gem "less-rails"

# Twitter Bootstrap
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

