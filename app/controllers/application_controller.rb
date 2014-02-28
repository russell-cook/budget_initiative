class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
  	case resource
  	when User then initiatives_path
  	when Admin then admin_initiatives_path
  	end
  end

  def after_sign_out_path_for(resource)
      initiatives_path
  end

  # def after_sign_in_path_for(admin)
  #   admins_path
  # end

  # def after_sign_out_path_for(users)
  #   initiatives_path
  # end

  # def after_sign_out_path_for(admin)
  #   admin_initiatives_path
  # end


end
