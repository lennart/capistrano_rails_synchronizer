require 'sync_stage'
require 'pp'

desc 'copies database and assets to destination'
task :sync do
  on roles :all do
    info 'synchronizing data...'
  end
  invoke 'sync:db:copy'  
  invoke 'sync:assets:copy'
end

namespace :sync do
  desc "syncronizes stages"
  task :env_to_remote do
    from = fetch(:rails_env, :staging)
    #worker = SyncStage::Worker.new(OpenStruct.new(app: rails_env))
    ask(:sync_to, stages.join('|'))
    if fetch(:sync_to).to_s == fetch(:rails_env).to_s
      raise "nonsense - synchronize yourself..."
    end
    on roles [:db, :web] do
      info "yai - about to synchronize stage  '#{from}' to  '#{fetch(:sync_to)}'"
      puts fetch(:current_path)
    end
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

    #desc 'dump database'
    task :dump do
      on roles :db do
        info 'dumping database'
      end
    end

    desc 'copy database dump to other stage'
    task :copy do
      on roles :db do
        invoke 'sync:db:dump'
        info 'copying database dump to other stage'
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
        info 'copying assets to destination'
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
