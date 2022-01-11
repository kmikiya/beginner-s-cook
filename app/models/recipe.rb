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

  def roughs
    self.materials.map{|m| m.rough/100}#材料を1グラムあたりに変換
  end

  def calorie
    array = [*0.. self.roughs.count-1]#材料の数を数え上げてる
    (array.map{|m| roughs[m]*MaterialDetail.where(id: self.materials.pluck(:material_detail_id)).pluck(:calorie)[m]}.sum*(100/ self.materials.sum(:rough))).round(1)
  end

  def sugar
    array = [*0.. self.roughs.count-1]
    (array.map{|m| roughs[m]*MaterialDetail.where(id: self.materials.pluck(:material_detail_id)).pluck(:sugar)[m]}.sum*(100/ self.materials.sum(:rough))).round(1)
  end

  def protein
    array = [*0.. self.roughs.count-1]
    (array.map{|m| roughs[m]*MaterialDetail.where(id: self.materials.pluck(:material_detail_id)).pluck(:protein)[m]}.sum*(100/ self.materials.sum(:rough))).round(1)
  end

  def lipids
    array = [*0.. self.roughs.count-1]
    (array.map{|m| roughs[m]*MaterialDetail.where(id: self.materials.pluck(:material_detail_id)).pluck(:lipids)[m]}.sum*(100/ self.materials.sum(:rough))).round(1)
  end

  def dietary_fiber
    array = [*0.. self.roughs.count-1]
    (array.map{|m| roughs[m]*MaterialDetail.where(id: self.materials.pluck(:material_detail_id)).pluck(:dietary_fiber)[m]}.sum*(100/ self.materials.sum(:rough))).round(1)
  end

  def salt
    array = [*0.. self.roughs.count-1]
    (array.map{|m| roughs[m]*MaterialDetail.where(id: self.materials.pluck(:material_detail_id)).pluck(:salt)[m]}.sum*(100/ self.materials.sum(:rough))).round(2)
  end

end
