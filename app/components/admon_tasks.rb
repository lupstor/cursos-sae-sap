class AdmonTasks < Netzke::Base

  js_configure do |c|
    c.extend = "Ext.tab.Panel"
  end

  component :usuarios do |c|
    c.klass = UsuariosCrud
    c.title = "Usuarios"
  end

  component :cursos do |c|
    c.klass = CursosCrud
    c.title = "Cursos"
  end

  component :salones do |c|
    c.klass = SalonesCrud
    c.title = "Salones"
  end

  def configure(c)
    super
    c.items = [:cursos,:usuarios,:salones]
  end

end