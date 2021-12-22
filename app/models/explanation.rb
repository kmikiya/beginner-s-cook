class Explanation < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :recipe
  #accepts_nested_attributes_for :recipe

  accepts_nested_attributes_for :comments

  attachment :process_image

  #validates :process_image, presence: true
  validates :explanation, presence: true
end