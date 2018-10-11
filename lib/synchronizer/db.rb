module DB

  def dump_db
    _stage = fetch(:stage, nil).to_s
    cfg = read_db_config(_stage)
    execute db_dump_cmd(cfg)
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

  def db_dump_cmd(opts)
    adapter = opts.fetch('adapter')
    cmd = "echo 'WARNING: #{adapter} does not dump db!'"

    case adapter
    when 'postgresql'
      db_dump_file = "#{shared_path}/#{opts.fetch('database')}.dump"
      cmd = "PGPASSWORD=#{opts.fetch('password')} pg_dump -U #{opts.fetch('username')} -h #{opts.fetch('host')} -Fc #{opts.fetch('database')} -f #{db_dump_file}"
      set :db_dump_file, db_dump_file
    when 'sqlite3'
      database_file = "#{shared_path}/#{opts.fetch('database')}"
      database_name = File.basename(database_file,
                                    File.extname(database_file))
      db_dump_file = "#{shared_path}/#{database_name}.sqlite3"
      cmd = "cp #{database_file} #{db_dump_file}"
      set :db_dump_file, db_dump_file
    end

    cmd
  end

  def read_db_config(stage)
    db_cfg = YAML::load(capture("cat #{current_path}/config/database.yml"))
    db_cfg[stage]
  end
end
