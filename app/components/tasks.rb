class Tasks < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "Task"
    c.scope = lambda{ |rel|
                      if session[:selected_bike_id]
                        rel.where(:task_list_id => Bike.find_by_id(session[:selected_bike_id]).task_list.id)
                      else
                        #show nothing, whatever this works
                        rel.where(:task_list_id => 0)
                      end
                    }
  end

  #override with nil to remove actions
  def default_bbar
    [ :apply, :add_in_form]
  end
end
