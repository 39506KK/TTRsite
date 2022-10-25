class Public::SessionsController < Devise::SessionsController
  
  before_action :customer_state, only: [:create]

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected
  
  # 退会しているかを判断するメソッド
  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email].downcase)
    if @customer
      if (@customer.valid_password?(params[:customer][:password]) && (@customer.active_for_authentication? == false))
        flash[:notice] = "退会済みの為、再登録が必要です。"
        redirect_to new_customer_registration_path
      end
    else
      flash[:notice] = "必須項目を入力して下さい。"
    end
  end
  
end
