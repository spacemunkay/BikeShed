class AppView < Netzke::Basepack::Viewport
  js_configure do |c|
    c.layout = :fit
  end

  def configure(c)
    super
    c.items = [
      {netzke_component: :app_tab_panel, region: :center}
    ]
  end

  component :app_tab_panel
end
