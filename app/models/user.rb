# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  fname            :string
#  lname            :string
#  full_name        :string
#  email            :string
#  password_digest  :string
#  num_endorsements :integer
#  num_posts        :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class User < ActiveRecord::Base
  include UsersHelper
  has_many :sessions
  has_many :likes
  has_many :endorsers
  has_many :posts, dependent: :destroy
  validates :fname, presence: true, length: { maximum: 50 }
  validates :lname, length: { maximum: 50 } # For parsing reasons lname may not exist
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6, too_short: "should have at least %{count} characters" }, on: :create
  before_save { |client| client.email = email.downcase }
  has_secure_password 
  before_create :default_values
  # On create do a validation
  def default_values
    self.num_posts = 0
    self.num_endorsements = 0
    self.full_name = !self.lname.blank? ? self.fname + " " + self.lname : self.fname
  end

  # Endorsers a user
  def endorse(endorsed_id)
    endorsed = User.find(endorsed_id)
    endorse = Endorse.create(endorser_id: self.id, endorsed_id: endorsed_id) 
    if endorse.valid? || endorsed.blank?
      User.increment_counter(:num_endorsements,endorsed)
    end
    endorse.valid? || endorse.blank? ? true : false
  end

  # Unendorsers a user.
  def unendorse(endorsed_id)
    endorsed = User.find(endorsed_id)
    unendorse = Endorse.destroy_all(endorser_id: self.id, endorsed_id: endorsed_id) 
    if !unendorse.blank? || endorsed.blank?
      User.decrement_counter(:num_endorsements, endorsed) unless endorsed.num_endorsements == 0
    end
    unendorse.blank? || endorsed.blank? ? false : true
  end
  # Returns true if the current user endorsed the other user.
  def endorsed?(endorsed_id)
    Endorse.where(endorser_id: self.id, endorsed_id: endorsed_id).exists?
  end
  # Returns list of endorser ids
  def endorser_ids 
    Endorse.where(endorsed_id: self.id).pluck(:endorser_id)
  end
  # Returns list of endorsers names and ids
  def endorsers
    eids = endorser_ids
    eids.count < 1 ? [] : User.where('id IN (?)', eids).pluck(:full_name, :id)
  end
  # Likes a post
  def like(post_id)
    post = Post.find(post_id)
    like = Like.create(post_id: post_id, user_id: self.id) 
    if like.valid? || post.blank?
      User.increment_counter(:like_count,self)
      Post.increment_counter(:like_count,post)
    end
    like.valid? || post.blank? ? true : false
  end 

  # Unlikes post
  def unlike(post_id)
    post = Post.find(post_id)
    unlike = Like.destroy_all(user_id: self.id, post_id: post_id)
    if !unlike.blank? || post.blank?
      User.decrement_counter(:like_count, self) unless self.like_count == 0
      Post.decrement_counter(:like_count, post) unless post.like_count == 0
    end
    unlike.blank? || post.blank? ? false : true
  end

  # Returns true if the post was liked by the user
  def liked?(post_id)
    Like.where(post_id: post_id, user_id: self.id).exists?
  end
end