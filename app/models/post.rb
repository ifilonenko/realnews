# == Schema Information
#
# Table name: posts
#
#  id                 :integer          not null, primary key
#  description        :text
#  is_deleted         :boolean
#  image_url          :string
#  player_type        :string
#  player_embed       :string
#  like_count         :integer
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  validates :user_id, presence: true
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  before_create :default_values
  def as_json(options = {})
      if options[:limited] 
        exclude = [:endorsers, :email, :num_endorsements, :num_posts]
        more_hash = {}
      else
        more_hash = {
          id: self.id,
          like_count: self.like_count,
          is_liked: User.find(options[:id]).liked?(self.id),
          description: self.description,
        }
        more_hash[:user] = self.user.as_json(limited: true)
      end
      super(except: exclude).merge(more_hash)
  end
  private
  def default_values
    self.like_count = 0
  end
end
