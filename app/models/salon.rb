class Salon < ActiveRecord::Base
  validates :nombre_salon, presence: true, length: {maximum: 50},uniqueness: {case_sensitive: false}
  self.table_name = "salones"
end