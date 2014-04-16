class Anuncio < ActiveRecord::Base
  validates :anuncio, presence: true
  belongs_to :usuario, class_name: "Usuario"

end
