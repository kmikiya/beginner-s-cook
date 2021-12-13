class MaterialDetail < ApplicationRecord
  has_many :materials, dependent: :destroy
  has_many :lists, dependent: :destroy

  validates :name, uniqueness: true
end
