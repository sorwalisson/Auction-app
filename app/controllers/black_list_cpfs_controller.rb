class BlackListCpfsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user_admin

  def create
    @blockcpf = BlackListCpf.new(cpf: params[:blockcpf])
    @blockcpf.save
    redirect_to root_path, notice: t('status_msg.block_cpf.cpf_blocked')
  end
end