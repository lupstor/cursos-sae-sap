class Salon < ActiveRecord::Base
  has_many :asignaciones, foreign_key: "salon_id",
           class_name:  "Asignacion",
           dependent:   :destroy

  validates :nombre_salon, presence: true, length: {maximum: 50},uniqueness: {case_sensitive: false}
  self.table_name = "salones"
end