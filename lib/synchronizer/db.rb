module DB

  def dump_db
    _stage = fetch(:stage, nil).to_s
    cfg = read_db_config(_stage)
    execute pg_dump_cmd(cfg)
  end

  private

  def pg_dump_cmd(opts)
    str = "PGPASSWORD=#{opts.fetch('password')} pg_dump -U #{opts.fetch('username')} -h #{opts.fetch('host')} -Fc #{opts.fetch('database')} -f #{shared_path}/#{opts.fetch('database')}.dump"
    str
  end


  def read_db_config(stage)
    db_cfg = YAML::load(capture("cat #{shared_path}/config/database.yml"))
    db_cfg[stage]
  end
end
