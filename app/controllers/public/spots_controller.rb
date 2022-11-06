class Public::SpotsController < ApplicationController
  
  def new
    @spot = Spot.new
  end
  
  def create
    @spot =Spot.new(spot_params)
    if @spot.save
      redirect_to root_path, notice: "スポットを追加しました"
    end
  end
  
  private
  def spot_params
    params.require(:spot).permit(:spot_name, :spot_address)
  end
  
end
