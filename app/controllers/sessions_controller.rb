class SessionsController < ApplicationController


  def new

  end

  def create
    user = Usuario.find_by(correo: params[:session][:correo].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = "Bienvenido/a ["+ user.nombre + "] a plataforma de Cursos SAE/SAP"
      redirect_back_or root_url
    else
      flash.now[:error] = 'Combinación inválida correo/contraseña'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
