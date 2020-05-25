class Post < ApplicationRecord
    belongs_to :user
    has_many :favorites, dependent: :destroy
     has_many :comments, dependent: :destroy
     has_many :comments
    has_one_attached :image
    has_many :likes, dependent: :destroy
    validates :user_id, presence: true
    acts_as_commontable dependent: :destroy
end
