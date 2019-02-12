module Assets

  def pack_assets
    on roles :web do
      execute "cd #{shared_path}; #{pack_assets_cmd}"
      execute "cd #{shared_path}; #{pack_storage_cmd}"
    end
  end


  def copy_assets_to_local
    download! "#{fetch(:assets_archive_file)}", "#{fetch(:assets_archive_file).split('/')[-1]}"
    download! "#{fetch(:storage_archive_file)}", "#{fetch(:storage_archive_file).split('/')[-1]}"
  end

  def copy_assets_cmd
    if dest = fetch(:sync_assets_to, nil)
      scp_file(fetch(:assets_archive_file), dest)
      scp_file(fetch(:storage_archive_file), dest)
    else
      raise "missing variable sync_assets_to"
    end
  end


  private

  def pack_assets_cmd
    assets_archive = "#{shared_path}/public-#{fetch(:stage)}.tgz"
    set :assets_archive_file, assets_archive
    "tar cvfzp #{assets_archive} ./public"
  end

  def pack_storage_cmd
    storage_archive = "#{shared_path}/storage-#{fetch(:stage)}.tgz"
    set :storage_archive_file, storage_archive
    "tar cvfzp #{storage_archive} ./storage"
  end
end
