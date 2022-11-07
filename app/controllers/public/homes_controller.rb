class Public::HomesController < ApplicationController
  # 地図
  def create
    @spot =Spot.new(spot_params)
    if @spot.save
      redirect_to root_path, notice: "スポットを追加しました"
    end
  end
end
