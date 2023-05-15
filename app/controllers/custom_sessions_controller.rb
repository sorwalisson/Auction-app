class CustomSessionsController < Devise::SessionsController
  after_action :after_sign_in, only: :create

  def after_sign_in
    if user_signed_in?
      if current_user.cpf_checker == true then flash[:notice] = t("suspension_msg") end
    end
  end
end