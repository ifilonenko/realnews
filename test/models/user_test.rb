# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  fname            :string
#  lname            :string
#  full_name        :string
#  bio              :string
#  email            :string
#  password_digest  :string
#  num_endorsements :integer
#  num_posts        :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
