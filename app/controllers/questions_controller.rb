class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user_admin, only: :visible_false

  def create
    @auction_lot = AuctionLot.find_by(id: params[:auction_lot_id])
    @question = Question.new(message: params[:message], auction_lot_id: @auction_lot.id, user_id: current_user.id)

    if @question.save
      redirect_to @auction_lot, notice: t("status_msg.question.question_added")
    else
      redirect_to @auction_lot, notice: t("status_msg.question.question_not_added")
    end
  end

  def visible_false
    @question = Question.find_by(id: params[:id])
    @question.update(visible: false)
    @question.save
    redirect_to auction_lot_path(id: params[:auction_lot_id]), notice: t('status_msg.question.set_invisible')
  end
end