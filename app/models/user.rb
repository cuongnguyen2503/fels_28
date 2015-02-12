class User < ActiveRecord::Base
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :learned_words, dependent: :destroy

  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 200 },
                   format: { with: VALID_EMAIL_REGEX },
                   uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user
  def remember
    self.remember_token = User.new_token
    update_attributes(remember_digest: User.digest(remember_token))
  end

  # Check whether the given token is matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user
  def forget
    update_attributes(remember_digest: nil)
  end

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end  

  # Gets words learned in a course
  def get_learned_words_in(course_id)
    learned_words_id = "select word_id from learned_words
                        where user_id = #{id}"
    Word.where("course_id = #{course_id}
                and words.id in (#{learned_words_id})")
  end

  # Gets words not learned in a course
  def get_not_learned_words_in(course_id)
    learned_words_id = "select word_id from learned_words
                        where user_id = #{id}"
    Word.where("course_id = #{course_id}
                and words.id not in (#{learned_words_id})")
  end
end
