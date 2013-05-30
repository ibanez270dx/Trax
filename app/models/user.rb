class User < ActiveRecord::Base

  has_many :tracks

  validates :name, presence: true
  validates :login, presence: true, uniqueness: true
  has_secure_password

  def soundcloud?
    soundcloud_id.present?
  end
end
