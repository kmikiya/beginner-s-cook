class Material < ApplicationRecord
  belongs_to :recipe
  belongs_to :material_detail

  validates :rough, presence: true
  validates :amount, presence: true
  #validates :material_detail_id, uniqueness: true
end
