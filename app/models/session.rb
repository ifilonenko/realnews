# == Schema Information
#
# Table name: sessions
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  session_code :string
#  ip_address   :string
#  is_active    :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Session < ActiveRecord::Base
  belongs_to :user

  before_create :activate
  before_create { self.is_active = true }

  def save_with_session_code
    self.session_code = SecureRandom.urlsafe_base64 unless session_code
    self.save
  end
  
  def code
    self.session_code
  end

  def disable
    self.update_attribute(:is_active, false)
  end

  private
  def activate
    self.is_active = true
    self.session_code ||= SecureRandom.urlsafe_base64
  end
end
