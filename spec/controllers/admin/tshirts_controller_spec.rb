require 'spec_helper'

describe Admin::TshirtsController do

  it "should only allow users with admin role"
  it "users without admin role should be redirected to home page with message"
end
