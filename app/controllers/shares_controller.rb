class SharesController < ApplicationController


  before_filter :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound do
    flash[:notice] = 'The requested Initiative is unavailable.'
    redirect_to :controller => "initiatives", :action => "index"
  end


	def index
		@initiative = current_user.initiatives.find(params[:initiative_id])
		@users = User.all
		# @users = User.where(id: 1)
	end


	def create

		target_user = User.where(email: params[:share][:user_email]).first
		@initiative = current_user.initiatives.find(params[:initiative_id])

		if target_user.nil?
			redirect_to initiative_shares_path(@initiative), alert: 'Email address not found. Please check spelling and confirm that the user has created an account with this application.'
		else
			@share = @initiative.shares.create(share_params)
			if @share.save
				redirect_to initiative_shares_path(@initiative), notice: 'Initiative was successfully shared with ' + target_user.email
			else
				format.html { render action: 'new' }
				format.json { render json: @initiative.errors, status: :unprocessable_entity }
			end
		end

    end

	private
	    # Never trust parameters from the scary internet, only allow the white list through.
	    def share_params
	      params.require(:share).permit(:user_email, :edit, :comments)
	    end

end
