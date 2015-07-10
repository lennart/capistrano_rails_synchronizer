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

  desc 'syncs db and assets to local'
  task :local do
    invoke 'sync:db:dump_to_local'
    invoke 'sync:assets:copy_to_local'
  end

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

    desc 'dump database'
    task :dump do
      on roles :db do
        info 'dumping database'
        dump_db
        info 'finished dumping'
      end
    end

    desc 'create db-dump and copy to local'
    task :dump_to_local do
      on roles :db do
        invoke 'sync:db:dump'
        copy_db_to_local
      end
    end

    desc 'copy database dump to other stage'
    task :copy do
      on roles :db do |host|
        invoke 'sync:db:dump'
        info "copying database dump from #{host} to other stage #{fetch(:sync_db_to)}"
        copy_db_cmd
      end
    end

  end

  namespace :assets do

    desc 'copies asets to destination'
    task :copy do
      on roles :web do
        invoke 'sync:assets:pack'
        info "copying assets to destination #{fetch(:sync_assets_to)}"
        copy_assets_cmd
      end
    end

    desc 'copy assets to local'
    task :copy_to_local do
      on roles :web do
        invoke 'sync:assets:pack'
        copy_assets_to_local
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
        pack_assets
      end
    end
  end
  
end
