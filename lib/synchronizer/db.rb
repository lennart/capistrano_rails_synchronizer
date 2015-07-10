module DB

  def dump_db
    _stage = fetch(:stage, nil).to_s
    cfg = read_db_config(_stage)
    execute pg_dump_cmd(cfg)
  end

  def copy_db_cmd
    if dest = fetch(:sync_db_to, nil)
      scp_file(fetch(:db_dump_file), dest)
    else
      raise "missing variable sync_db_to"
    end
  end
  
  def copy_db_to_local
   download! "#{fetch(:db_dump_file)}", "#{fetch(:db_dump_file).split('/')[-1]}"
  end

  private

  def pg_dump_cmd(opts)
    db_dump_file = "#{shared_path}/#{opts.fetch('database')}.dump"
    set :db_dump_file, db_dump_file
    str = "PGPASSWORD=#{opts.fetch('password')} pg_dump -U #{opts.fetch('username')} -h #{opts.fetch('host')} -Fc #{opts.fetch('database')} -f #{db_dump_file}"
    str
  end


  def read_db_config(stage)
    db_cfg = YAML::load(capture("cat #{shared_path}/config/database.yml"))
    db_cfg[stage]
  end
end
