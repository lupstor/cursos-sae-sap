class UsuariosCrud < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "Usuario"
    c.enable_edit_inline = false
    c.viewConfig = {
        stripeRows: true,
        enableTextSelection: true
    }
    c.columns = [
        {name: :nombre, header: "Nombre", width: 450},
        {name: :correo, header: "Correo", width: 375},
        :rol
    ]
  end

  def preconfigure_record_window(c)
    super
    c.form_config.klass = FormUsuario
    c.width = 400
  end

end