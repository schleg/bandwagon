require 'spec_helper'

describe TshirtsController do

  describe "GET 'new'" do
    it "returns http success" do
      sign_in FactoryGirl.create(:user)
      get 'new'
      response.should be_success
    end
  end

end
