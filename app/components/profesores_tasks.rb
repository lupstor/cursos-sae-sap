class ProfesoresTasks < Netzke::Base

  js_configure do |c|
    c.extend = "Ext.tab.Panel"
  end

  component :asignaciones do |c|
    c.klass = AsignacionesCrud
    c.title = "Asignaciones"
  end


  def configure(c)
    super
    c.items = [:asignaciones]
  end


end