class User < ActiveRecord::Base

  validates :name, presence: true
  validates :login, presence: true, uniqueness: true
  has_secure_password

  def soundcloud?
    soundcloud_id.present?
  end
end
