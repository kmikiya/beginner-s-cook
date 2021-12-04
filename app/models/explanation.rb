class Explanation < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :recipe
  accepts_nested_attributes_for :recipe

  attachment :process_image
end
