class TshirtsController < ApplicationController

  respond_to :html, :json
  
  before_filter :authenticate_user!, :except => [:show]

  load_and_authorize_resource except: :show

  def new
    respond_with @tshirt
  end

  def create
    update_art_file_properties
    @tshirt.user_id = current_user.id
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

  def show
    @tshirt = Tshirt.find params[:id]
  end

  def edit
  end

  def update
    update_art_file_properties
    if @tshirt.update_attributes params[:tshirt]
      if params[:tshirt][:state_requested]
        transition = @tshirt.state_transitions.
          detect{|s|s.to == params[:tshirt][:state_requested].downcase}
        transition.perform(current_user) if transition.present?
      end
      flash[:notice] = "Tee updated successfully" 
      respond_with @tshirt, location: edit_tshirt_path(@tshirt)
    else
      respond_with @tshirt, location: edit_tshirt_path(@tshirt)
    end
  end

  def destroy
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
