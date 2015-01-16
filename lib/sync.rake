require 'sync_stage'
require 'pp'

namespace :sync do
  desc "syncronizes stages"
  task :env_to_remote do
    #pp self.methods
    pp env
    pp fetch(:rails_env, :staging)
    from = fetch(:rails_env, :staging)
    pp keys
    #worker = SyncStage::Worker.new(OpenStruct.new(app: rails_env))
    ask(:sync_to, stages.join('|'))
    if fetch(:sync_to).to_s == fetch(:rails_env).to_s
      raise "nonsense - synchronize yourself..."
    end
    puts "yai - about to synchronize stage  '#{from}' to  '#{fetch(:sync_to)}'"
    puts fetch(:current_path)
  end

  namespace :db do
    desc "synchonize database"
    task :dump_db do
      puts "dumping database"
    end

    desc "restore database"
    task :restore_db do
      puts "restoring database"
    end
  end

  namespace :assets do
    desc "synchronize assets"
    task :pack_assets do
      puts "packing assets"
    end

    desc "copy assets to other stage"
    task :copy_assets do
      puts "copying assets"
    end
  end

  
end
