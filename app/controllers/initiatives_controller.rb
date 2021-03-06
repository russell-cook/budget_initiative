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
        t = Time.now.utc
        h1 = 18
        h2 = 14
        h3 = 12
        title = 20
        p = 10
        section_spacer = 24
        subsection_spacer = 18
        paragraph_spacer = 12
        small_spacer = 8
        indent_spacer = 20
        init = Initiative.find(params[:id])
        pdf = Prawn::Document.new
        pdf.image "public/img/nv_state_seal_bw.png", :at => [492, 720], :width => 48, :height => 48
        pdf.font_size h2
        pdf.text "Nevada Budget Division"
        pdf.text "Major Budget Initiative Template"
        pdf.move_down section_spacer
        pdf.font_size h3
        pdf.text "Initiative Title:", :align => :center, :inline_format => true
        pdf.font_size title
        pdf.text "<b>#{init.title}</b>", :align => :center, :inline_format => true
        pdf.move_down subsection_spacer
        pdf.font_size h2
        pdf.text "Lead Agency:"
        pdf.text_box "<b>#{init.lead_agency}</b>", :at => [130, (pdf.cursor + h2 + 1)], :height => h2, :inline_format => true
        pdf.move_down small_spacer
        pdf.font_size h3
        pdf.text "Secondary Agency 1:"
        pdf.text_box "#{init.sec_agency_1}", :at => [130, (pdf.cursor + h3 + 1)], :height => h3, :inline_format => true
        pdf.move_down small_spacer
        pdf.font_size h3
        pdf.text "Secondary Agency 2:"
        pdf.text_box "#{init.sec_agency_2}", :at => [130, (pdf.cursor + h3 + 1)], :height => h3, :inline_format => true
        pdf.move_down section_spacer
        pdf.font_size h1
        pdf.text "<b><u>Overview</u></b>", :align => :center, :inline_format => true
        pdf.move_down subsection_spacer
        pdf.group do
          pdf.font_size h2
          pdf.text "<b>Description</b>", :inline_format => true
          pdf.move_down paragraph_spacer
          pdf.font_size p
          pdf.text init.description, :indent_paragraphs => indent_spacer
          pdf.move_down subsection_spacer
        end
        pdf.group do
          pdf.font_size h2
          pdf.text "<b>Justification</b>", :inline_format => true
          pdf.move_down paragraph_spacer
          pdf.font_size p
          pdf.text init.justification, :indent_paragraphs => indent_spacer
          pdf.move_down subsection_spacer
        end
        pdf.group do
          pdf.font_size h2
          pdf.text "<b>Other Alternatives Considered</b>", :inline_format => true
          pdf.move_down paragraph_spacer
          pdf.font_size p
          pdf.text init.alternatives, :indent_paragraphs => indent_spacer
          pdf.move_down section_spacer
        end
        pdf.group do
          pdf.font_size h1
          pdf.text "<b><u>Funding Details</u></b>", :align => :center, :inline_format => true
          pdf.move_down subsection_spacer
          pdf.font_size h2
          pdf.text "<b>Cost Analysis</b>", :inline_format => true
          pdf.move_down paragraph_spacer
          pdf.font_size p
          pdf.text init.cost_analysis, :indent_paragraphs => indent_spacer
          pdf.move_down subsection_spacer
        end
        pdf.group do
          pdf.font_size h1
          pdf.text "<b><u>Objectives/Benchmarks Advanced</u></b>", :align => :center, :inline_format => true
          pdf.move_down subsection_spacer
          pdf.font_size h2
          pdf.text "Objective 1: <b>#{init.objective_1}</b>", :inline_format => true
          pdf.move_down small_spacer
          pdf.font_size h3
          pdf.text "Related Benchmark: " + init.benchmark_1a, :inline_format => true
          pdf.move_down small_spacer
          pdf.text "Related Benchmark: " + init.benchmark_1b, :inline_format => true
          pdf.move_down subsection_spacer
        end
        pdf.font_size h2
        pdf.text "Objective 2: <b>#{init.objective_2}</b>", :inline_format => true
        pdf.move_down small_spacer
        pdf.font_size h3
        pdf.text "Related Benchmark: " + init.benchmark_2a, :inline_format => true
        pdf.move_down small_spacer
        pdf.text "Related Benchmark: " + init.benchmark_2b, :inline_format => true
        pdf.move_down section_spacer
        pdf.group do
          pdf.font_size h1
          pdf.text "<b><u>Initiative-Level Performance Measures (Proposed)</u></b>", :align => :center, :inline_format => true
          pdf.move_down subsection_spacer
          pdf.font_size h3
          pdf.text "Initiative-Level Performance Measure 1:"
          pdf.font_size h2
          pdf.text "<b>#{init.init_pm_1}</b>", :inline_format => true
          pdf.move_down small_spacer
          pdf.font_size p
          pdf.text init.init_pm_1_cost, :indent_paragraphs => indent_spacer
          pdf.move_down subsection_spacer
        end
        pdf.font_size h3
        pdf.text "Initiative-Level Performance Measure 2:"
        pdf.font_size h2
        pdf.text "<b>#{init.init_pm_2}</b>", :inline_format => true
        pdf.move_down small_spacer
        pdf.font_size p
        pdf.text init.init_pm_2_cost, :indent_paragraphs => indent_spacer
        pdf.move_down section_spacer
        pdf.group do
          pdf.font_size h1
          pdf.text "<b><u>Activity-Level Performance Measures (Existing)</u></b>", :align => :center, :inline_format => true
          pdf.move_down subsection_spacer
          pdf.font_size h3
          pdf.text "Activity-Level Performance Measure 1:"
          pdf.font_size h2
          pdf.text "<b>#{init.agency_pm_1}</b>", :inline_format => true
          pdf.move_down subsection_spacer
        end
        pdf.font_size h3
        pdf.text "Activity-Level Performance Measure 2:"
        pdf.font_size h2
        pdf.text "<b>#{init.agency_pm_2}</b>", :inline_format => true
        pdf.move_down section_spacer
        pdf.group do
          pdf.font_size h1
          pdf.text "<b><u>Population/Caseload</u></b>", :align => :center, :inline_format => true
          pdf.move_down subsection_spacer
          pdf.font_size h2
          pdf.text "<b>Population</b>", :inline_format => true
          pdf.move_down paragraph_spacer
          pdf.font_size p
          pdf.text init.population, :indent_paragraphs => indent_spacer
          pdf.move_down subsection_spacer
        end
        pdf.group do
          pdf.font_size h2
          pdf.text "<b>Caseload</b>", :inline_format => true
          pdf.move_down paragraph_spacer
          pdf.font_size p
          pdf.text init.caseload, :indent_paragraphs => indent_spacer
        end
        pdf.canvas do
          pdf.font_size 8
          pdf.repeat(:all, :dynamic => true) do
            pdf.draw_text "Report Date: #{(t.localtime - 7.hours).strftime("%m-%e-%Y, %I:%M %p")}", :at => [0 , pdf.bounds.bottom - 18]
          end
          string = "Page <page> of <total>"
          # Green page numbers 1 to 7
          options = { :at => [pdf.bounds.right - 186, 24],
            :width => 150,
            :align => :right,
            :start_count_at => 1}
          pdf.number_pages string, options
        end
        send_data pdf.render, filename: "Major Budget Initiative_#{init.title}.pdf", type: "application/pdf"
      end
    end
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
