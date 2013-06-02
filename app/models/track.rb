class Track < ActiveRecord::Base

  has_one :user

  validates :title, presence: true
  validates :instrument, presence: true

  INSTRUMENTS = %w(guitar bass drums vocals other)

end
