class Usuario < ActiveRecord::Base

  #Foreign Keys

  before_save {
    self.correo = correo.downcase
    self.rol = rol.downcase
  }

  before_create :create_remember_token

  #Constants
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :nombre, presence: true, length: {maximum: 50}
  validates :correo, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :rol, presence: true, length: {maximum: 50}
  validates :estado_usuario, presence: true
  has_secure_password
  validates :password, length: {minimum: 6}

  def Usuario.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Usuario.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end


  private

  def create_remember_token
    self.remember_token = Usuario.hash(Usuario.new_remember_token)
  end

end
