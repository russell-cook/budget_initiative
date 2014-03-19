class RegistrationsController < Devise::RegistrationsController

  protected

    def after_update_path_for(resource)
      initiatives_path
    end
end