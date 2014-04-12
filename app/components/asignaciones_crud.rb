class AsignacionesCrud < Netzke::Basepack::Grid

  def configure(c)
    super
    c.model = "Asignacion"
    c.enable_edit_inline = false
    c.viewConfig = {
        stripeRows: true,
        enableTextSelection: true
    }
    c.columns = [
        {name: :"curso__nombre_curso", header: "Curso", width: 400},
        {name: :"usuario__nombre", scope: ->(relation){relation.where(rol: "profesor")}, header: "Profesor", width: 300},
        {name: :"salon__nombre_salon", header: "Salon", width: 200}
    ]
  end

  def preconfigure_record_window(c)
    super
    c.form_config.klass = FormAsignacion
    c.width = 600
  end

end

