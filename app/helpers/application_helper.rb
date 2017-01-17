module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', id: "add_#{association.to_s.singularize}" , class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def top_menu(right = nil)
    content_tag :nav, class: 'navbar navbar-default' do
      content_tag :div, class: 'container-fluid' do
        content_tag :div, class: 'row' do
          [
            content_tag(:div, link_to_dashboard, class: 'col-xs-3'),
            content_tag(:div, header_logo, class: 'col-xs-6'),
            content_tag(:div, class: 'col-xs-3') { content_tag :div, right, class: 'pull-right' },
          ].join.html_safe
        end
      end
    end
  end

  def link_to_dashboard
    link_to root_path, class: 'navbar-brand', title: 'Back to dashboard' do
      content_tag :i, '', class: "glyphicon glyphicon-home"
    end
  end

  def header_logo
    content_tag :div, 'Velocipede', class: 'navbar-text text-center'
  end
end
