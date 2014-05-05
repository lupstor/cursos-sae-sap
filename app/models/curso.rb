class Curso < ActiveRecord::Base

  has_many :asignaciones, foreign_key: "curso_id",
           class_name:  "Asignacion",
           dependent:   :destroy

  before_save {
    self.nombre_curso = nombre_curso.split(" ").map(&:capitalize).join(" ")
  }
  validates :nombre_curso, presence: true, length: {maximum: 50},uniqueness: {case_sensitive: false}


end
