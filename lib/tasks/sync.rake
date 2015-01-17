require 'pp'
require 'synchronizer'

include DB
include Assets
include Helper


desc 'copies database and assets to destination'
task :sync do
  on roles :all do
    info "synchronizing data to #{destination}"
  end
  invoke 'sync:db:copy'  
  invoke 'sync:assets:copy'
end

namespace :sync do

  desc 'dumps the database and copies the dump to destination stage'
  task :db do
    invoke 'sync:db:copy' 
  end

  desc 'tars assets and copies the archive to destination stage'
  task :assets do
    invoke 'sync:assets:copy'
  end

  desc 'restores assets and database on destination host'
  task :restore do
    invoke 'sync:db:restore'
    invoke 'sync:assets:unpack'
  end

  namespace :db do

    #desc 'dump database'
    task :dump do
      on roles :db do
        info 'dumping database'
      end
    end

    desc 'copy database dump to other stage'
    task :copy do
      on roles :db do |host|
        invoke 'sync:db:dump'
        dump_db
        info "copying database dump from #{host} to other stage #{destination}"
      end
    end

    desc 'restore database'
    task :restore do
      on roles :db do
        invoke 'sync:db:copy'
        info 'restoring database'
      end
    end

  end

  namespace :assets do

    desc 'copies asets to destination'
    task :copy do
      on roles :web do
        invoke 'sync:assets:pack'
        info "copying assets to destination #{destination}"
      end
    end

    desc 'pack, copy and unpack assets on other stage'
    task :unpack do
      on roles :web do
        invoke 'sync:assets:copy'
        info 'unpacking assets'
      end
    end

    #desc 'pack assets'
    task :pack do
      on roles :web do
        info 'packing assets'
      end
    end
  end
  
end
