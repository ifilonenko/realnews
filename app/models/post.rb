# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  description  :text
#  is_deleted   :boolean
#  player_type  :string
#  player_embed :string
#  tagphoto_url :string
#  like_count   :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Post < ActiveRecord::Base
  has_one :tagphoto, class_name: 'Image', as: :imageable
  belongs_to :user
  has_many :likes
  validates :user_id, presence: true
  before_create :default_values
  def as_json(options = {})
      if options[:limited] 
        exclude = [:player_type, :player_embed]
        more_hash = {}
      else
        more_hash = {
          id: self.id,
          like_count: self.like_count,
          is_liked: User.find(options[:id]).liked?(self.id),
          description: self.description,
          is_deleted: self.is_deleted,
          image_url: self.image_url,
          player_type: self.player_type,
          player_embed: self.player_embed
        }
        more_hash[:user] = self.user.as_json(limited: true)
      end
      super(except: exclude).merge(more_hash)
  end
  private
  def default_values
    self.is_deleted = false
    self.like_count = 0
  end
end
