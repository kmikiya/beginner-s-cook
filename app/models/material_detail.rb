class MaterialDetail < ApplicationRecord
  has_many :recipes, through: :materials, dependent: :destroy
  has_many :lists, dependent: :destroy

end
