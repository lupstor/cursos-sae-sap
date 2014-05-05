require 'validators/range_date_validator'
require 'time'

class Asignacion < ActiveRecord::Base
  self.table_name ="asignaciones"

  belongs_to :usuario, class_name: "Usuario"
  belongs_to :salon, class_name: "Salon"
  belongs_to :curso, class_name: "Curso"

  validates :fecha_inicio, presence: true
  validates :fecha_fin, presence: true
  validates :hora_inicio, presence: true
  validates :hora_fin, presence: true
  validates :usuario_id, presence: true
  validates :curso_id, presence: true
  validates :salon_id, presence: true

  validates_with RangeDateValidator

  #Sobreescribe getter hora_inicio para mostra en formato AM - PM

  def hora_inicio
    if !read_attribute(:hora_inicio).nil?
      Time.parse(read_attribute(:hora_inicio).to_s[11..17].to_s).strftime("%I:%M %p")
    end
  end

  #Sobreescribe getter hora_fin para mostra en formato AM - PM
  def hora_fin
    if !read_attribute(:hora_fin).nil?
      Time.parse(read_attribute(:hora_fin).to_s[11..17].to_s).strftime("%I:%M %p")
    end
  end

end

