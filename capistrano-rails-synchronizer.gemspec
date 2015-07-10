Gem::Specification.new do |gem|
  gem.name          = 'capistrano-rails-synchronizer'
  gem.version       = '0.1.2'
  gem.authors       = ['rene paulokat']
  gem.email         = ['rene@so36.net']
  gem.description   = %q{Rails specific Capistrano tasks to synchonize stages}
  gem.summary       = %q{Rails specific Capistrano tasks to synchonize stages}
  gem.homepage      = 'https://github.com/erpe/capistrano-rails-synchonizer'

  gem.files         = [ 'lib/capistrano-rails-synchronizer.rb', 'lib/tasks/sync.rake']
  #gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  #gem.require_paths = ['lib']

  gem.add_dependency 'capistrano-rails', '~> 1.1'
end
