Given(/^I am not a signed\-in user$/) do
  @signed_out_user = FactoryGirl.create(:signed_out_user)
end

When(/^I visit the new tshirt page$/) do
  visit new_tshirt_path
end

Then(/^I am redirected to the sign\-in page$/) do
  current_path.should eq(new_user_session_path)
end

Given(/^I am a signed\-in user$/) do
  create_visitor
  @confirmed_user = FactoryGirl.create(:confirmed_user, @visitor)
  sign_in
end

When(/^I enter a tshirt title of "(.*?)"$/) do |title|
  save_and_open_page
  fill_in :tshirt_title, with: title
end

When(/^I enter a tshirt description of "(.*?)"$/) do |description|
  fill_in :tshirt_description, with: description
end

When(/^I click "(.*?)"$/) do |button|
  click_button button
end

Then(/^I should be on the preview page for the "(.*?)" tshirt$/) do |title|
  tshirt = Tshirt.find_by_title title
  current_path.should eq(tshirt_preview_path(tshirt))
end
