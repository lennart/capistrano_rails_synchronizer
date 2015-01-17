module Helper

  def destination
    _stage =  fetch(:stage, nil).to_s
    if dest = fetch(:sync_to, nil)
      dest
    else
      ask(:sync_to, stages.delete_if { |x| x == _stage }.join('|') )
      dest = fetch(:sync_to, nil) 
    end
  end

end
