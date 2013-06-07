require 'spec_helper'

describe "Tshirt administration" do

  it "should allow an administrator to see a list of shirts for review" do
    sign_in_user
    3.times do
      FactoryGirl.create :tshirt
    end
    visit admin_tshirts_path
    page.should have_content("Tshirt #1")
    page.should have_content("Tshirt #2")
    page.should have_content("Tshirt #3")
  end

  it "should allow an admin to approve a tshirt design"
  it "should allow an admin to preview the generated tshirt template"
end
