class List < ApplicationRecord
  belongs_to :customer
  belongs_to :material_detail

  validates :material_detail_id, uniqueness: true
end
