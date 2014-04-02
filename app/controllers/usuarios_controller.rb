class UsuariosController < ApplicationController

  before_action :signed_in_user


  def index
    @users = Usuario.paginate(page: params[:page])
  end

  def show
    begin
      @user = Usuario.find(params[:id])
    rescue Exception => e
      flash[:error] = e.message
      redirect_to error_request_url
    end
  end

  def new
    @user = Usuario.new
  end

  def create
    @user = Usuario.new(user_params)
    is_save = false

    begin
      if @user.save
        flash[:success] = "Bienvenido a plataforma de Cursos SAE/SAP!"
        is_save = true
      end
    rescue Exception => e
      puts e.message
      flash.now[:error] = e.message
    end

    if is_save
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = Usuario.find(params[:id])
  end

  def update
    @user = Usuario.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    Usuario.find(params[:id]).destroy
    flash[:success] = "Usuario deleted."
    redirect_to users_url
  end

  private

  def user_params
    params.require(:usuario).permit(:nombre, :correo, :password,
                                    :password_confirmation, :rol,
                                    :estado_usuario)
  end

  # Before filters
  def correct_user
    @user = Usuario.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
