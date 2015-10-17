# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  like_count :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  validates :user_id, presence: true
  before_create :default_values
  def as_json(options = {})
      more_hash = {
        like_count: self.like_count,
        is_liked: User.find(options[:id]).liked?(self.id)
      }
    super(options).merge(post: more_hash)
  end
  private
  def default_values
    self.like_count = 0
  end
end
