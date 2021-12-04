class Recipe < ApplicationRecord
  has_many :explanations, dependent: :destroy
  has_many :materials, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :customer

  attachment :image
end
