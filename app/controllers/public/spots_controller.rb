class Public::SpotsController < ApplicationController

  def index
    @spots = Spot.all
    @spot = Spot.new
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot =Spot.new(spot_params)
    if @spot.save
      redirect_to root_path, notice: "スポットを追加しました"
    end
  end

  def update
    spot = Spot.find(params[:id])
    spot.update(spot_params)
    redirect_to root_path,  notice: "スポットを編集しました"
  end


  private
  def spot_params
    params.require(:spot).permit(:spot_name, :spot_address)
  end

end
