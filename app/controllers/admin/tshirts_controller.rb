module Admin

  class TshirtsController < ApplicationController

    load_and_authorize_resource

    def index
      @tshirts = Tshirt.all
    end
  end

end
