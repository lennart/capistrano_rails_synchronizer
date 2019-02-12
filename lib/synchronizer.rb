require 'synchronizer/db'
require 'synchronizer/assets'
require 'synchronizer/helper'

begin 
  load File.expand_path("../tasks/sync.rake", __FILE__) 
rescue
  puts "WARNING: make sure to add 'require: false' to gem 'capistrano-rails-synchronizer' your Gemfile"
end
