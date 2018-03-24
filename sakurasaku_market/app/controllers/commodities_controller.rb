class CommoditiesController < ApplicationController
  authorize_resource only: %i(show new edit create update destroy)
  before_action :set_commodity, only: [:show, :edit, :update, :destroy]

  def index
    @commodities = Commodity.page(params[:page]).order("display_index")
  end

  def show
  end

  def new
    @commodity = Commodity.new
  end

  def edit
  end

  def create
    @commodity = Commodity.new(commodity_params)

    respond_to do |format|
      if @commodity.save
        format.html { redirect_to @commodity, notice: 'Commodity was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @commodity.update(commodity_params)
        format.html { redirect_to @commodity, notice: 'Commodity was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @commodity.destroy
    respond_to do |format|
      format.html { redirect_to commodities_url, notice: 'Commodity was successfully destroyed.' }
    end
  end

  private
    def set_commodity
      @commodity = Commodity.find(params[:id])
    end

    def commodity_params
      params.require(:commodity).permit(:name, :file, :price, :caption, :display_flag, :display_index)
    end
end
