require 'spec_helper'

describe "Tshirt management" do

  let(:user) { FactoryGirl.create :user }
  let(:admin) { FactoryGirl.create :admin }

  before :each do
    sign_in_user user
  end

  describe "by a user" do

    it "should only allow a user to submit a tshirt for review by default" do
      tshirt = FactoryGirl.create :tshirt, user: user
      visit tshirt_preview_path(tshirt)
      visible_states = page.all(".state-button").collect(&:value)
      visible_states.should == ["Submit for Approval"]
    end

    it "should allow a user to submit a tshirt for review" do
      tshirt = FactoryGirl.create :tshirt, user: user
      visit tshirt_preview_path(tshirt)
      click_button "Submit for Approval"
      tshirt.reload
      tshirt.state.should == 'submitted'
    end

    it "should not allow a state change once a tshirt is being reviewed" do
      tshirt = FactoryGirl.create :tshirt, user: user
      visit tshirt_preview_path(tshirt)
      click_button "Submit for Approval"
      tshirt.reload
      tshirt.state.should == "submitted"
      visit tshirt_preview_path(tshirt)
      visible_states = page.all(".state-button").collect(&:value)
      visible_states.should == []
    end

    it "should allow user to resubmit a tshirt if rejected" do
      tshirt = FactoryGirl.create :tshirt, user: user
      tshirt.submit
      tshirt.reload
      tshirt.reject(admin)
      tshirt.reload
      tshirt.submit
      tshirt.reload
      tshirt.state.should == "submitted"
    end

    it "should allow a user to create a tshirt" do
      visit new_tshirt_path
      fill_in :tshirt_title, with: Faker::Lorem.sentence.titlecase
      fill_in :tshirt_description, with: Faker::Lorem.paragraph
      click_button "Create My Tee"
      page.current_path.should == tshirt_preview_path(Tshirt.last)
    end

    it "should disallow accsess to another user's tshirts" do
      other_user = FactoryGirl.create :user
      tshirt = FactoryGirl.create :tshirt, user: other_user
      visit tshirt_preview_path(tshirt)
      page.current_path.should == tshirt_preview_path(tshirt)
    end
  end

end
