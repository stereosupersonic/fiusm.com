RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Gems
  config.gem 'erubis'
  config.gem 'systemu'
  config.gem 'nokogiri'
  config.gem 'rdiscount'

  config.gem 'haml'
  config.gem 'compass'
  config.gem 'compass-960-plugin', :lib => 'ninesixty'
  config.gem 'liquid'

  config.gem 'inherited_resources'
  config.gem 'facebooker'
  config.gem 'authlogic'
  config.gem 'declarative_authorization'

  config.gem 'ruby-hmac', :lib => 'hmac'
  config.gem 'gdata'

  config.gem 'will_paginate'
  config.gem 'openx'

  config.gem 'acts_as_revisable'
  config.gem 'paperclip'
  config.gem 'rmagick', :lib => 'RMagick'

  # Time Zone
  config.time_zone = 'Eastern Time (US & Canada)'
  
  # Middleware load path
  %W(app/middleware app/models/radio).each do |path|
    config.load_paths << Rails.root.join(path).to_s
  end
end
