class SharesController < ApplicationController

  before_filter :authenticate_user!

	def create
		@initiative = current_user.initiatives.find(params[:id])
		@share = @initiative.shares.create(share_params)
	end

private
    # Never trust parameters from the scary internet, only allow the white list through.
    def share_params
      params.require(:share).permit(:user, :initiative, :edit)
    end
end

end
