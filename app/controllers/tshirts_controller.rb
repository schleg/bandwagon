class TshirtsController < ApplicationController

  respond_to :html, :json
  
  before_filter :authenticate_user!, :except => [:show]

  def new
    @tshirt = Tshirt.new
  end

  def create
    params[:tshirt].merge! user_id: current_user.id
    @tshirt = Tshirt.new params[:tshirt]
    update_art_file_properties
    if @tshirt.save
      flash[:notice] = "Tee created successfully"
      respond_with @tshirt, location: tshirt_preview_path(@tshirt)
    else
      respond_with @tshirt
    end
  end

  def preview
    @tshirt = Tshirt.find params[:tshirt_id]
  end

  def edit
    @tshirt = Tshirt.find params[:id]
  end

  def update
    @tshirt = Tshirt.find params[:id]
    update_art_file_properties
    if @tshirt.update_attributes params[:tshirt]
      transition = @tshirt.state_transitions.select{|s|s.to == @tshirt.state_requested.downcase}
      transition.first.perform if transition.any?
      flash[:notice] = "Tee updated successfully" 
      respond_with @tshirt, location: edit_tshirt_path(@tshirt)
    else
      respond_with @tshirt
    end
  end

  def destroy
    @tshirt = Tshirt.find params[:id]
    @tshirt.destroy
    if @tshirt.destroyed?
      flash[:notice] = "Tee deleted successfully"
      respond_with @tshirt, location: root_path 
    else
      respond_with @tshirt
    end
  end

  private

  def update_art_file_properties
    artwork_params = params[:tshirt][:artwork]
    if artwork_params.present?
      @tshirt.art_file_name = artwork_params.original_filename 
      @tshirt.art_content_type = artwork_params.content_type
      @tshirt.art_file_size = artwork_params.size
      @tshirt.art_updated_at = Time.now
    end
  end
end
