class Category < ApplicationRecord
  has_many :recipes
  has_ancestry

end
