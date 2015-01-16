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


    desc "dump and copy database"
    task :dump_copy do
      puts "dumping and copying database"
    end

    desc "dump, copy and restore database" 
    task :dump_restore do
      puts "dumping, copying and restoring database"
    end

    desc "dump database"
    task :dump do
      puts "dumping database"
    end

    desc "copy database dump to other stage"
    task :copy do
      puts "copying database dump to other stage"
    end

    desc "restore database"
    task :restore do
      puts "restoring database"
    end
  end

  namespace :assets do

    desc "pack and copy asets to other stage"
    task :pack_copy do
      puts "packing and copying"
    end

    desc "pack, copy and unpack assets on other stage"
    task :pack_unpack do
      puts "packing, copying and unpacking assets on other stage"
    end

    desc "pack assets"
    task :pack do
      puts "packing assets"
    end

    desc "copy assets to other stage"
    task :copy do
      puts "copying assets"
    end

    desc "unpack assets on other stage"
    task :unpack do
      puts "unpacking assets"
    end
  end

  
end
