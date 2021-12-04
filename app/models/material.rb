class Material < ApplicationRecord
  belongs_to :recipe
  belongs_to :material_detail
end
