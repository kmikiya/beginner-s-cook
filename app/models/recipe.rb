class Recipe < ApplicationRecord
  has_many :explanations, dependent: :destroy
  has_many :materials, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :customer

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  attachment :image
end
