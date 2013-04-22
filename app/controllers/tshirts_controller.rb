class TshirtsController < ApplicationController

  respond_to :html
  
  before_filter :authenticate_user!, :except => [:show]

  def new
    @tshirt = Tshirt.new
  end

  def create
    params[:tshirt].merge! user_id: current_user.id
    @tshirt = Tshirt.create params[:tshirt]
    respond_with @tshirt, location: tshirt_preview_path(@tshirt)
  end

  def preview
  end
end
