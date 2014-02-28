class AdminInitiativesController < ApplicationController

  before_action :set_initiative, only: [:show]
  before_filter :authenticate_admin!

  def index
    @initiatives = Initiative.all
    # @shared_initiatives = Initiative.share.where(email: current_user.email)
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_initiative
      @initiative = Initiative.find(params[:id])
    end


end
