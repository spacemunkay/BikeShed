module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', id: "add_#{association.to_s.singularize}" , class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_dashboard
    content_tag :p do
      content_tag :a, href: root_path, class: 'btn btn-default', title: 'Back to dashboard' do
        content_tag :span, '', class: 'glyphicon glyphicon-home'
      end
    end
  end
end
