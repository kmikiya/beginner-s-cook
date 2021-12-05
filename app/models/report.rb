class Report < ApplicationRecord
  belongs_to :customer
  belongs_to :recipe

  attachment :image
end
