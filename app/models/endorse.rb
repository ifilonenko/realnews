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

class Endorse < ActiveRecord::Base
  belongs_to :endorser, class_name: "User"
  belongs_to :endorsed, class_name: "User"
  validates :endorser_id, presence: true
  validates :endorsed_id, presence: true
  validates_uniqueness_of :endorser_id, scope: :endorsed_id
end
