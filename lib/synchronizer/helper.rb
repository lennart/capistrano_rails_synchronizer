module Helper

  def destination
    puts "deprecated... will vanish soon..."
    _stage =  fetch(:stage, nil).to_s
    dest = fetch(:sync_to, nil)
    if dest
      dest
    else
      ask(:sync_to, stages.delete_if { |x| x == _stage }.join('|') )
      dest = fetch(:sync_to, nil)
    end
  end

  def scp_file(src, dest)
    capture "scp #{src} #{dest}"
  end

  def _cset(name, *args, &block)
    unless exists?(name)
      set(name, *args, &block)
    end
  end

  def clean_db_dump
    if test("[ -f '#{fetch(:db_dump_file)}' ]")
      execute :rm, '-v', fetch(:db_dump_file)
    end
  end

  def clean_assets_dump
    if test("[ -f '#{fetch(:assets_archive_file)}' ]")
      execute :rm, '-v', fetch(:assets_archive_file)
    end
    if test("[ -f '#{fetch(:storage_archive_file)}' ]")
      execute :rm, '-v', fetch(:storage_archive_file)
    end
  end
end
