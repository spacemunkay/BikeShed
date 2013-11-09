class Tasks < Netzke::Basepack::Grid
  def configure(c)
    super

    #disable by default, will be enabled once bike is clicked
    c.disabled = true
    task_list_id = nil
    if session[:selected_bike_id]
      task_list_id = Bike.find_by_id(session[:selected_bike_id]).task_list.id
    end

    c.header = false
    c.model = "Task"
    c.force_fit = true
    c.scope = lambda{ |rel|
                      if session[:selected_bike_id]
                        rel.where(:task_list_id => Bike.find_by_id(session[:selected_bike_id]).task_list.id)
                      else
                        #show nothing, whatever this works
                        rel.where(:task_list_id => 0)
                      end
                    }
    c.strong_default_attrs = {
      :task_list_id => task_list_id
    }
    c.columns = [
        :done,
        :task,
        :notes
      ]
  end

  def default_fields_for_forms
    fields = []
    fields << { :no_binding => true, :xtype => 'displayfield', :fieldLabel => "No Bike Selected", :value => "Select a Bike First!"}
    fields.concat( [
        :done,
        :task,
        :notes
      ])
  end

  #override with nil to remove actions
  def default_bbar
    [ :apply, :add_in_form]
  end
end
