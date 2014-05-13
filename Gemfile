source 'https://rubygems.org'

########################################
# Core
########################################

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

# Use MySQL
gem 'mysql2'

# jQuery
gem 'jquery-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :production do
  # App server
  gem 'unicorn'
end

group :development do
  # Use debugger
  # gem 'debugger'

  # Better Errors
  gem 'better_errors'
  gem 'binding_of_caller'

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

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby'
