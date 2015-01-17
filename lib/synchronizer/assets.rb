module Assets

  def pack_assets
    on roles :web do
      # somehow within path does not work
      #
      #within shared_path do
      #  execute pack_assets_cmd
      #end
      execute "cd #{shared_path}; #{pack_assets_cmd}"
    end
  end


  private 

  def pack_assets_cmd
    "tar cvfzp ./public-#{fetch(:stage)}.tgz ./public" 
  end
end
