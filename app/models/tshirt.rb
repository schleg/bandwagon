class Tshirt < ActiveRecord::Base
  attr_accessible :description, :state, :title, :user_id, :artwork, :artwork_cache
  extend FriendlyId
  friendly_id :title, use: :slugged
  validates_presence_of :title
  mount_uploader :artwork, ArtworkUploader
  belongs_to :user
end
