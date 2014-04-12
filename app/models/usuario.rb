class Usuario < ActiveRecord::Base

  attr_accessor           :cambiar_password
  #attr_accessible         :cambiar_password

  #attr_accessor :cambiar_password
  #netzke_attribute :cambiar_password

  #Foreign Keys
  has_many :asignaciones, foreign_key: "usuario_id",
           class_name:  "Asignacion",
           dependent:   :destroy


  before_save {
    self.correo = correo.downcase
    self.rol = rol.downcase
    self.nombre = self.nombre.split(" ").map(&:capitalize).join(" ")
  }

  before_create :create_remember_token

  #Constants
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :nombre, presence: true, length: {maximum: 50}
  validates :correo, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :rol, presence: true, length: {maximum: 50}, inclusion: { in: %w(admon profesor secretaria),
                                                                      message: "%{value} Rol no valido" }
  validates :estado_usuario, presence: true
  has_secure_password
  validates :password, length: {minimum: 6} ,:on => :create

  def Usuario.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Usuario.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def cambiar_password
      @cambiar_password
  end
  def cambiar_password=(cambiar_password)
    @cambiar_password = cambiar_password
  end


  private

  def create_remember_token
    self.remember_token = Usuario.hash(Usuario.new_remember_token)
  end

end
