# == Schema Information
#
# Table name: endorses
#
#  id          :integer          not null, primary key
#  endorser_id :integer
#  endorsed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class EndorseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
