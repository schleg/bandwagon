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

    before_transition :submitted => :rejected do |tshirt, transition|
      raise ArgumentError unless transition.args.first.is_a?(User)
      tshirt.can_change_state? transition.args.first, transition.from, transition.to
    end
  end

  def can_change_state?(user, from, to)
    valid_transitions = []
    if user.has_role? :admin
      valid_transitions = [
        ['submitted', 'rejected'],
        ['submitted', 'published'],
        ['rejected', 'submitted'],
        ['published', 'unpublished'],
        ['unpublished', 'submitted']
      ]
    else
      valid_transitions = [
        ['unpublished', 'submitted'],
        ['rejected', 'submitted']
      ]
    end
    valid_transitions.include? [from, to]
  end

  def available?
    state == 'published'
  end
end
