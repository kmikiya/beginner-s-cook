class Recipe < ApplicationRecord
  is_impressionable counter_cache: true
  has_many :explanations, dependent: :destroy
  has_many :materials, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reports, dependent: :destroy
  belongs_to :customer
  has_many :material_details, through: :materials
  #has_many :comments, through: :explanations
  belongs_to :category

  accepts_nested_attributes_for :explanations, :materials, allow_destroy: true
  accepts_attachments_for :explanations, attachment: :process_image
  attr_accessor :average


  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  validates :title, presence: true
  validates :comment, presence: true, length: { minimum: 3, maximum: 140 }
  #validates :category_id, presence: true
  validates :image, presence: true
  validates :people, presence: true



  attachment :image
end
