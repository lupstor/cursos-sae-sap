class UsuariosCrud < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "Usuario"
    c.viewConfig = {
        stripeRows: true,
        enableTextSelection: true
    }
    c.columns = [
        {name: :nombre, header: "Nombre", width: 400},
        {name: :correo, header: "Correo", width: 275},
        :rol,
        :estado_usuario
    ]
  end

  def preconfigure_record_window(c)
    super
    c.form_config.klass = FormUsuario
  end

end