class User < ApplicationRecord
    acts_as_commontator
    has_many :following, through: :active_relationships, source: :followed
    has_many :followed_users, foreign_key: :follower_id, class_name: "Follow"
has_many :followees, through: :followed_users, source: :person_being_followed
has_many :following_users, foreign_key: :followee_id, class_name: "Follow"
has_many :followers, through: :following_users, source: :person_doing_the_following
    has_many :followed_users, foreign_key: :follower_id, class_name:    
    "Follow"
    has_many :followees, through: :followed_users
    has_many :following_users, foreign_key: :followee_id, class_name:    
    "Follow"
    has_many :followers, through: :following_users
    has_many :likes, dependent: :destroy
    has_many :posts, dependent: :destroy
    has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id",
    dependent:
    :destroy
    has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "followed_id",
    dependent:
    :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower
    before_save { email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
        end
        def feed
            Post.where("user_id IN (SELECT followed_id FROM relationships
                             WHERE  follower_id = :user_id)
                             OR user_id = :user_id", user_id: id)
          end
        
          def follow(other_user)
            following << (other_user)
          end
        
          # Unfollows a user.
          def unfollow(other_user)
            following.delete(other_user)
          end
        
          # Returns true if the current user is following the other user.
          def following?(other_user)
            following.include?(other_user)
          end
        
        end