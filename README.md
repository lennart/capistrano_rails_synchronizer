# capistrano_rails_synchronizer
capistrano tasks to synchronize your Rails app between stages

expects postgres database

expects ssh-agent for deployment-user in use

add in Capfile:

require 'synchronizer' 

## adopt config/deploy/stage...

``set :sync_db_to, 'your.hostname.here:/var/www/your_app_root'``

``set :sync_assets_to, 'your.hostname.here:/var/www/your_app_root' ``


## provides additional cap tasks:

dump database, pack assets and download ...

``cap staging sync:local``

dump database and download...

``cap staging sync:db:to_local``

pack assets and download...

``cap staging sync:assets:to_local``

dump/pack and transfer to configured target:

``cap production sync:transfer``


dump db and transfer to target:

``cap production sync:db:transfer``


pack assets and transfer to target:

``cap production sync:assets:transfer``
