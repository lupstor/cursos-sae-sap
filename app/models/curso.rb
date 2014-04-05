class Curso < ActiveRecord::Base
  before_save {
    self.nombre_curso = nombre_curso.split(" ").map(&:capitalize).join(" ")
  }
  validates :nombre_curso, presence: true, length: {maximum: 50},uniqueness: {case_sensitive: false}

end
