class Anuncios < Netzke::Base
  # Configure client class
  js_configure do |c|
    c.mixin # mix in methods from javascripts
  end

  # Self-configure
  def configure(c)
    super

  end

  # Endpoint callable from client class
  endpoint :set_params do |params, this|
    #Convert to array and format date
    this.show_panel("Anuncios", nil)
  end

  endpoint :anuncio_save do |params, this|

    anuncio = params[:texto_anuncio].to_s
    puts "Guardando anuncio : " + anuncio
    usuario = Usuario.find (session[:user_id])
    nuevo = Anuncio.new
    nuevo.usuario_id = usuario.id
    nuevo.anuncio = anuncio
    nuevo.save

  end

  endpoint :get_anuncio do |params, this|
    numero_anuncio = params[:numero_anuncio].to_i
    texto_anuncio = ""
    counter = 1
    Anuncio.order(:id).reverse_order.limit(3).each { |u|
      if counter == numero_anuncio
        texto_anuncio = u.anuncio
        break
      elsif counter == numero_anuncio
        texto_anuncio = u.anuncio

        break
      elsif counter == numero_anuncio
        texto_anuncio = u.anuncio
        break
      end
      counter = counter +1
    }
    this.refrescar_anuncios(texto_anuncio);
  end


end