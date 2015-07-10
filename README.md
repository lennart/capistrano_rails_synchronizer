# capistrano_rails_synchronizer
capistrano tasks to synchronize your Rails app between stages

Status: draft

## adopt config/deploy/stage...

``set :sync_db_to, 'your.hostname.here:/var/www/your_app_root'``
``set :sync_assets_to, 'your.hostname.here:/var/www/your_app_root' ``


## provides additional cap tasks:

``cap staging sync:local``
``cap staging sync:db:copy_to_local``
``cap staging sync:assets:copy_to_local``

