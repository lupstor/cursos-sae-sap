class FormUsuario< Netzke::Basepack::Form
  def configure(c)
    super
    c.model = 'Usuario'
    c.items = [
        {
            field_label: 'Nombre',
            name: :nombre,
            width: 400

        },
        {
            field_label: 'Correo',
            name: :correo
        },
        {
            field_label: 'Rol',
            name: :rol,
            xtype: :combo,
            store: ['profesor', 'secretaria','admon'],
            editable: false,
        },
        {
            field_label: 'Password',
            name: :password,
            inputType: 'password',
        },
        {
            field_label: 'Confirmar password',
            name: :password_confirmation,
            inputType: 'password'
        }
    ]

  end


  js_configure do |c|
    # Overriding initComponent
    c.init_component = <<-JS
      function(){
        this.callParent();

      Ext.onReady(function () {
          var div3 = Ext.getDom('tabbar-1009-body');
          //alert(div3.value);

      });

    }
    JS

  end

end