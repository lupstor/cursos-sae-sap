class FormUsuario< Netzke::Basepack::Form
  def configure(c)
    super
    c.width = 200
    c.model = 'Usuario'
    c.items = [
        {
            field_label: 'Nombre:',
            name: :nombre
        },
        {
            field_label: 'Correo:',
            name: :correo
        },
        {
            field_label: 'Rol:',
            name: :rol
        },
        {
            field_label: 'Estado:',
            name: :estado_usuario
        },
        {
            field_label: 'Password:',
            name: :password,
            inputType: 'password'
        },
        {
            field_label: 'Confirmar pass:',
            name: :password_confirmation,
            inputType: 'password'
        }
    ]
  end

end