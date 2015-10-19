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

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
