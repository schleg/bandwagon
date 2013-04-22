class Tshirt < ActiveRecord::Base
  attr_accessible :description, :state, :title, :user_id
end
