class CursosCrud <Netzke::Basepack::Grid

  def configure(c)
    super
    c.model = "Curso"
    c.viewConfig = {
        stripeRows: true,
        enableTextSelection: true
    }
    c.columns = [
        {name: :nombre_curso, header: "Nombre", width: 950}


    ]
  end

  def preconfigure_record_window(c)
    super
    c.width = 400
  end
end