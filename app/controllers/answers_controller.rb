class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user_admin

  def create
    @auction_lot = AuctionLot.find_by(id: params[:auction_lot_id])
    @answer = Answer.new(message: params[:message], question_id: params[:question_id], user_id: current_user.id)

    if @answer.save
      redirect_to @auction_lot, notice: t("status_msg.answer.answer_added")
    else
      redirect_to @auction_lot, notice: t("status_msg.answer.answer_not_added")
    end
  end
end
