class FormAsignacion< Netzke::Basepack::Form

  js_configure do |c|
    c.mixin
  end


  def configure(c)

    c.model = 'Asignacion'
    super


    c.items = [


        {
            field_label: 'Curso',
            name: "curso__nombre_curso"

        },
        {
            field_label: 'Profesor',
            name: "usuario__nombre", scope: ->(relation) { relation.where(rol: "profesor") }
        },
        {
            field_label: 'Salon',
            name: "salon__nombre_salon"
        },
        {
            xtype: 'datefield',
            anchor: '100%',
            fieldLabel: 'Fecha Inicio',
            name: :fecha_inicio
        },
        {
            xtype: 'datefield',
            anchor: '100%',
            fieldLabel: 'Fecha Fin',
            name: :fecha_fin
        }, {
            xtype: 'timefield',
            name: :hora_inicio,
            fieldLabel: 'Hora Inicio',
            minValue: '6:00 AM',
            maxValue: '10:00 PM',
            increment: 10,
            anchor: '100%'
        }, {
            xtype: 'timefield',
            name: :hora_fin,
            fieldLabel: 'Hora Fin',
            minValue: '6:00 AM',
            maxValue: '10:00 PM',
            increment: 10,
            anchor: '100%'
        },
        {
            xtype: 'fieldset',
            flex: 1,
            columns: 2,
            title: 'Dias',
            defaultType: 'checkbox',

            layout: {
                type: 'column'
            },
            items: [{
                        name: :lunes,
                        columnWidth: '.25',
                        labelAlign: 'right'
                    }, {
                        name: :martes,
                        labelAlign: 'right',
                        columnWidth: '.10'
                    }, {
                        name: :miercoles,
                        labelAlign: 'right',
                        columnWidth: '.10'

                    }, {
                        name: :jueves,
                        labelAlign: 'right',
                        columnWidth: '.10'

                    }, {
                        name: :viernes,
                        labelAlign: 'right',
                        columnWidth: '.10'

                    }, {
                        name: :sabado,
                        labelAlign: 'right',
                        columnWidth: '.10'

                    }, {
                        name: :domingo,
                        labelAlign: 'right',
                        columnWidth: '.10'

                    }
            ]
        }

    ]


  end

end