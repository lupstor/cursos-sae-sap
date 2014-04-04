class AdmonTasks < Netzke::Base

  js_configure do |c|
    c.extend = "Ext.tab.Panel"
  end

  component :usuarios do |c|
    c.klass = UsuariosCrud

    c.title = "Usuarios"
  end

  def configure(c)
    super
    c.items = [:usuarios]
  end

end