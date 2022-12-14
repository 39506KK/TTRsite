# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    @customer = Customer.new(sign_up_params)
    if params[:back]
      render :new
      return
    end
    super
  end
  
  def confirm
    @customer = Customer.new(sign_up_params)
    if @customer.invalid?
      flash.now[:denger] = '入力内容にエラーがあります。'
      render :new
      return
    end
    @password = "*" * @customer.password.length
  end
  
  def complete
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end
  
  def after_sign_up_path_for(resource)
    customers_sign_up_complete_path(resource)
  end
  
  def after_sign_in_path_for(resource)
    public_customer_path(current_customer.id)
  end

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_kana, :first_kana, :email, :tell, :password])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  end
end
