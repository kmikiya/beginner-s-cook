class Recipe < ApplicationRecord
  has_many :explanations, dependent: :destroy
  has_many :materials, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reports, dependent: :destroy
  belongs_to :customer
  has_many :material_details, through: :materials
  #has_many :comments, through: :explanations

  accepts_nested_attributes_for :explanations, :material_details
  accepts_attachments_for :explanations, attachment: :process_image
  attr_accessor :average


  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end


  attachment :image
end
