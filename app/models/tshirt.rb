class Tshirt < ActiveRecord::Base
  attr_accessible :description, :state, :title, :user_id, :artwork, :artwork_cache, :state_requested
  extend FriendlyId
  friendly_id :title, use: :slugged
  validates_presence_of :title
  mount_uploader :artwork, ArtworkUploader
  belongs_to :user
  attr_accessor :state_requested

  state_machine :state, :initial => :unpublished do

    event :submit do
      transition [:unpublished, :rejected] => :submitted
    end

    event :reject do
      transition [:submitted] => :rejected
    end

    event :approve do
      transition [:submitted] => :published
    end

    event :unpublish do
      transition [:published] => :unpublished
    end
  end
end
