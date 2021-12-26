class Category < ApplicationRecord
  has_many :recipes
  has_ancestry

  attr_accessor :child_name
  attr_accessor :grandchild_name

end
