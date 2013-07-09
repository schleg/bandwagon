require 'spec_helper'

describe "Tshirt pre-ordering" do

  let(:user) { FactoryGirl.create :user }

  before :each do
    sign_in_user user
  end

  describe "by a user" do

    describe "when the tshirt is published" do

      it "should allow user to view the pre-order page" do
        tshirt = FactoryGirl.create :tshirt
        tshirt.submit
        tshirt.reload
        tshirt.approve
        visit tshirt_path(tshirt)
        page.current_path.should == tshirt_path(tshirt)
      end
    end

    describe "when the tshirt is unpublished" do

      it "should not allow the user to view the pre-order page" do
        tshirt = FactoryGirl.create :tshirt
        tshirt.submit
        visit tshirt_path(tshirt)
        page.current_path.should == tshirt_path(tshirt)
        page.should have_content(I18n.t(:tee_unavailable))
      end
    end
  end
end
