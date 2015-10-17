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

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
