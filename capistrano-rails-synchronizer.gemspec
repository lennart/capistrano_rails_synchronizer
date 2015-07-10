Gem::Specification.new do |gem|
  gem.name          = 'capistrano-rails-synchronizer'
  gem.version       = '0.1.5'
  gem.authors       = ['rene paulokat']
  gem.email         = ['rene@so36.net']
  gem.description   = %q{Rails specific Capistrano tasks to synchonize stages}
  gem.summary       = %q{Rails specific Capistrano tasks to synchonize stages}
  gem.homepage      = 'https://github.com/erpe/capistrano-rails-synchonizer'
  gem.licenses      = ['MIT']
  gem.files         = [ 'lib/capistrano-rails-synchronizer.rb', 
                        'lib/synchronizer.rb',
                        'lib/synchronizer/db.rb',
                        'lib/synchronizer/assets.rb',
                        'lib/synchronizer/helper.rb',
                        'lib/tasks/sync.rake']
  gem.cert_chain = ['certs/rp.pem']
  gem.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/
  gem.add_dependency 'capistrano-rails', '~> 1.1'
  gem.post_install_message = "thanks for all the fish and \nadd 'require \"synchronizer\"' to your Capfile"
end
