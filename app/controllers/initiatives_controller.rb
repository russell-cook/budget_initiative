class InitiativesController < ApplicationController
  require 'prawn'

  before_action :set_initiative, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound do
    flash[:notice] = 'The Initiative you are trying to view does not exist.'
    redirect_to :controller => "initiatives", :action => "index"
  end

  # GET /initiatives
  # GET /initiatives.json
  def index
    @initiatives = current_user.initiatives.all
    # @shared_initiatives = Initiative.share.where(email: current_user.email)
  end

  # GET /initiatives/1
  # GET /initiatives/1.json
  def show
    authorize_initiative
    respond_to do |format|
      format.html
      format.pdf do
        init = Initiative.find(params[:id])
        pdf = Prawn::Document.new
        pdf.font_size 18
        pdf.text "Nevada Budget Division", :align => :center
        pdf.text "Major Budget Initiative Template", :align => :center
        pdf.move_down 18
        pdf.font_size 24
        pdf.text "Initiative Title: " + init.title, :align => :center
        pdf.move_down 18
        pdf.font_size 18
        pdf.text "Lead Agency: " + init.lead_agency
        pdf.move_down 8
        pdf.font_size 12
        pdf.text "Secondary Agency 1: " + init.sec_agency_1
        pdf.move_down 8
        pdf.text "Secondary Agency 2: " + init.sec_agency_2
        pdf.move_down 18
        pdf.font_size 24
        pdf.text "Overview", :align => :center
        pdf.move_down 24
        pdf.font_size 18
        pdf.text "Description"
        pdf.move_down 12
        pdf.font_size 12
        pdf.text init.description, :indent_paragraphs => 30
        pdf.move_down 24
        pdf.font_size 18
        pdf.text "Justification"
        pdf.move_down 12
        pdf.font_size 12
        pdf.text init.justification, :indent_paragraphs => 30
        pdf.move_down 24
        pdf.font_size 18
        pdf.text "Other Alternatives Considered"
        pdf.move_down 12
        pdf.font_size 12
        pdf.text init.alternatives, :indent_paragraphs => 30
        pdf.move_down 18
        pdf.font_size 24
        pdf.text "Funding Details", :align => :center
        pdf.move_down 24
        pdf.font_size 18
        pdf.text "Cost Anaylsis"
        pdf.move_down 12
        pdf.font_size 12
        pdf.text init.cost_analysis, :indent_paragraphs => 30
        pdf.move_down 18
        pdf.font_size 24
        pdf.text "Objectives/Benchmarks Advanced", :align => :center
        pdf.move_down 18
        pdf.font_size 18
        pdf.text "Objective #1: " + init.objective_1
        pdf.move_down 8
        pdf.font_size 12
        pdf.text "Related Benchmark: " + init.benchmark_1a
        pdf.move_down 8
        pdf.text "Related Benchmark: " + init.benchmark_1b
        pdf.move_down 18
        pdf.font_size 18
        pdf.text "Objective #2: " + init.objective_2
        pdf.move_down 8
        pdf.font_size 12
        pdf.text "Related Benchmark: " + init.benchmark_2a
        pdf.move_down 8
        pdf.text "Related Benchmark: " + init.benchmark_2b
        pdf.move_down 18
        pdf.font_size 24
        pdf.text "Initiative-Level Performance Measures (Proposed)", :align => :center
        pdf.move_down 18
        pdf.font_size 18
        pdf.text "Initiative-Level Performance Measure #1: " + init.init_pm_1
        pdf.move_down 8
        pdf.font_size 12
        pdf.text init.init_pm_1_cost, :indent_paragraphs => 30
        pdf.move_down 18
        pdf.font_size 18
        pdf.text "Initiative-Level Performance Measure #2: " + init.init_pm_2
        pdf.move_down 8
        pdf.font_size 12
        pdf.text init.init_pm_2_cost, :indent_paragraphs => 30
        pdf.move_down 18
        pdf.font_size 24
        pdf.text "Activity-Level Performance Measures (Existing)", :align => :center
        pdf.move_down 18
        pdf.font_size 18
        pdf.text "Activity-Level Performance Measure #1: " + init.agency_pm_1
        pdf.move_down 18
        pdf.font_size 18
        pdf.text "Activity-Level Performance Measure #2: " + init.agency_pm_2
        pdf.move_down 18
        pdf.font_size 24
        pdf.text "Population/Caseload", :align => :center
        pdf.move_down 24
        pdf.font_size 18
        pdf.text "Population"
        pdf.move_down 12
        pdf.font_size 12
        pdf.text init.population, :indent_paragraphs => 30
        pdf.move_down 24
        pdf.font_size 18
        pdf.text "Caseload"
        pdf.move_down 12
        pdf.font_size 12
        pdf.text init.caseload, :indent_paragraphs => 30
        send_data pdf.render, filename: "Major Budget Initiative_#{init.title}.pdf", type: "application/pdf"
      end
    end
    # pdf = Prawn::Document.new
    # pdf.text init.title
    # send_data pdf.render, filename: "test.pdf", type: "application/pdf"
  end

  # GET /initiatives/new
  def new
    @initiative = current_user.initiatives.new
  end

  # GET /initiatives/1/edit
  def edit
    authorize_initiative
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
    authorize_initiative
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
    authorize_initiative
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

    def authorize_initiative
      init = Initiative.find(params[:id])
      if init.user_id != current_user.id
        flash[:notice] = 'You are not authorized to view the requested Initiative.'
        redirect_to initiatives_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def initiative_params
      params.require(:initiative).permit(:title, :description, :justification, :alternatives, :lead_agency, :sec_agency_1, :sec_agency_2, :cost_analysis, :objective_1, :benchmark_1a, :benchmark_1b, :objective_2, :benchmark_2a, :benchmark_2b, :init_pm_1, :init_pm_1_cost, :init_pm_2, :init_pm_2_cost, :agency_pm_1, :agency_pm_2, :population, :caseload, :who_impacted)
    end
end
