class InitiativesController < ApplicationController
  before_action :set_initiative, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  # GET /initiatives
  # GET /initiatives.json
  def index
    @initiatives = current_user.initiatives.all
  end

  # GET /initiatives/1
  # GET /initiatives/1.json
  def show
  end

  # GET /initiatives/new
  def new
    @initiative = current_user.initiatives.new
  end

  # GET /initiatives/1/edit
  def edit
  end

  # POST /initiatives
  # POST /initiatives.json
  def create
    @initiative = current_user.initiatives.build(initiative_params)

    respond_to do |format|
      if @initiative.save
        format.html { redirect_to @initiative, notice: 'Initiative was successfully created.' }
        format.json { render action: 'show', status: :created, location: @initiative }
      else
        format.html { render action: 'new' }
        format.json { render json: @initiative.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /initiatives/1
  # PATCH/PUT /initiatives/1.json
  def update
    respond_to do |format|
      if @initiative.update(initiative_params)
        format.html { redirect_to @initiative, notice: 'Initiative was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @initiative.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /initiatives/1
  # DELETE /initiatives/1.json
  def destroy
    @initiative.destroy
    respond_to do |format|
      format.html { redirect_to initiatives_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_initiative
      @initiative = Initiative.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def initiative_params
      params.require(:initiative).permit(:title, :description, :justification, :alternatives, :lead_agency, :sec_agency_1, :sec_agency_2, :cost_analysis)
    end
end
