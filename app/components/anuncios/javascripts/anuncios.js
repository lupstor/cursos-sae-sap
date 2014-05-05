{


    initComponent: function () {
        /*Required to override initComponent*/
        this.callParent();
        this.setParams();

        // this.anuncioSave();
    }
,
    showPanel: function (title, end_text, events) {
        /*var element = Ext.getBody().createChild({cls: 'panel-container'});*/
        var element = Ext.get('anuncios_div').createChild({cls: 'panel-container'});

        /* Event options*/

        var that = this;


        Ext.widget('panel', Ext.applyIf(
            {

                frame: true,
                requires: ['Ext.button.Button'],
                width: 220,
                height: 500,
                title: title,
                bodyStyle: "padding: 0px;",
                items: [
                    {
                        xtype: 'textareafield',
                        id: 'taAnuncios',
                        name: 'taAnuncios',
                        width: 200,
                        height: 300
                    },
                    {
                        layout: {
                            type: 'table',
                            columns: 3
                        },
                        xtype: 'radiogroup',
                        width: 500,
                        items: [
                            {
                                xtype: 'radiofield',
                                id: 'A1',
                                name: 'show',
                                boxLabel: '1    ',
                                checked: true,
                                flex:100,
                                inputValue: 'A1'
                            },
                            {
                                xtype: 'radiofield',
                                id: 'A2',
                                name: 'show',
                                boxLabel: '2 ',
                                inputValue: 'A2',
                                flex:100

                            },
                            {
                                xtype: 'radiofield',
                                id: 'A3',
                                name: 'show',
                                boxLabel: '3     ',
                                inputValue: 'A3',
                                flex:500

                            }
                        ],
                        listeners: {
                            change: function (field, newValue, oldValue) {
                                var value = newValue.show;
                                if (Ext.isArray(value)) {
                                    return;
                                }
                                if (value == 'A1') {
                                    that.getAnuncio({numero_anuncio: "1"});
                                } else if (value == 'A2') {
                                    that.getAnuncio({numero_anuncio: "2"});
                                } else if (value == 'A3') {
                                    that.getAnuncio({numero_anuncio: "3"});
                                }
                            }
                        }
                    },
                    {
                        xtype: 'button',
                        text: 'Nuevo',

                        handler: function () {
                            var text_anuncio = Ext.fly("taAnuncios-inputEl").getValue();
                            if (text_anuncio != "") {
                                that.anuncioSave({texto_anuncio: text_anuncio});
                                //Ext.get('taAnuncios-inputEl').dom.value = "";
                            }
                        }
                    }

                ],

                collapsible: true,
                collapseDirection: Ext.Component.DIRECTION_LEFT
            },
            {
                renderTo: element,
                bodyPadding: 7
            }
        ));
        this.getAnuncio({numero_anuncio: "1"});


    }
,

    refrescarAnuncios: function (anuncio) {
        Ext.get('taAnuncios-inputEl').dom.value = anuncio;

    }

}





