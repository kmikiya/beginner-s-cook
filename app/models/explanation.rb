class Explanation < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :recipe
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :recipe

  accepts_nested_attributes_for :comments

  attachment :process_image

  validates :process_image_id, presence: true
end
