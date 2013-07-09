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
    t.submit
    click_link t.title
    click_button "Approve Tee"
    Tshirt.last.state.should == 'published'
  end

  it "should allow an admin to preview the generated tshirt template" do
    3.times do
      tshirt = FactoryGirl.create :tshirt
      tshirt.user = @user
      tshirt.save
    end
    visit admin_tshirts_path
    t = Tshirt.last
    within(:xpath, "//tr[@data-tshirt-id='#{t.id}']") do
      find(".transfer-link").click
    end
    page.current_path.should == t.artwork.transfer_11x17.url
  end

  it "should show the admin a preview link unless the tshirt is published" do
    3.times do
      tshirt = FactoryGirl.create :tshirt
      tshirt.user = @user
      tshirt.save
    end
    visit admin_tshirts_path
    t = Tshirt.last
    click_link t.title
    page.current_path.should == tshirt_preview_path(t)
  end

  it "should show the admin the public tshirt link if the tshirt is published" do
    3.times do
      tshirt = FactoryGirl.create :tshirt
      tshirt.user = @user
      tshirt.save
    end
    t = Tshirt.last
    t.submit
    t.approve
    visit admin_tshirts_path
    click_link t.title
    page.current_path.should == tshirt_path(t)
  end
end
