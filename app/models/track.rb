class Track < ActiveRecord::Base

  has_one :user
  has_and_belongs_to_many :tags
  has_attached_file :audio

  validates :title, presence: true

end
