class User < ActiveRecord::Base

  has_many :tracks

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password

end
