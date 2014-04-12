
require 'validators/range_date_validator'
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





end

