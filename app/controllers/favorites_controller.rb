class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.add_favorite(params[:auction_lot_id])
    redirect_to auction_lot_path(id: params[:auction_lot_id]), notice: t('status_msg.favorites.added_favorite')
  end

  def destroy
    current_user.remove_favorite(params[:auction_lot_id])
    redirect_to auction_lot_path(id: params[:auction_lot_id]), notice: t('status_msg.favorites.removed_favorite')
  end
end