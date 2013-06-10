require 'spec_helper'

describe "Tshirt administration" do

  before :each do
    @user = FactoryGirl.create :admin
    sign_in_user @user
  end

  it "should allow an administrator to see a list of shirts for review" do
    3.times do
      tshirt = FactoryGirl.create :tshirt
      tshirt.user = @user
      tshirt.save
    end
    visit admin_tshirts_path
    Tshirt.all.each do |tshirt|
      page.should have_content(tshirt.title)
    end
  end

  it "should allow an admin to approve a tshirt design" do
    3.times do
      tshirt = FactoryGirl.create :tshirt
      tshirt.user = @user
      tshirt.save
    end
    visit admin_tshirts_path
    t = Tshirt.last
    t.state = 'submitted'
    t.save
    click_link t.title
    click_button "Approve Tee"
    Tshirt.last.state.should == 'published'
  end

  it "should allow an admin to preview the generated tshirt template"

end
