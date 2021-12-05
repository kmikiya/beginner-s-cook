class Recipe < ApplicationRecord
  has_many :explanations, dependent: :destroy
  has_many :materials, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reports, dependent: :destroy
  belongs_to :customer
  has_many :material_details, through: :materials

  accepts_nested_attributes_for :explanations, :material_details, allow_destroy: true
  accepts_attachments_for :explanations, attachment: :process_image

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end


  attachment :image
end
