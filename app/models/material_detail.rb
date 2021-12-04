class MaterialDetail < ApplicationRecord
  has_many :materials, dependent: :destroy
end
