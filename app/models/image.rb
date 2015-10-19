# == Schema Information
#
# Table name: images
#
#  id                :integer          not null, primary key
#  imageable_id      :integer
#  imageable_type    :string
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  has_attached_file :file
  validates_attachment_size :file, :less_than => 5.megabytes
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/
end
