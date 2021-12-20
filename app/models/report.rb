class Report < ApplicationRecord
  belongs_to :customer
  belongs_to :recipe

  attachment :image

  validates :impression, presence: true
  validates :evaluation, presence: true
  validates :image, presence: true
end
