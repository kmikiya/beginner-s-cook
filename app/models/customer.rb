class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :recipes, dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :followings, through: :relationships, source: :followed
  has_many :favorites, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :lists, dependent: :destroy

  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end

  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
  end

  def following?(customer)
    followings.include?(customer)
  end


  attachment :profile_image
  attachment :bg_image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
