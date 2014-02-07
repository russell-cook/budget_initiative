json.array!(@initiatives) do |initiative|
  json.extract! initiative, :title, :description, :justification, :alternatives, :lead_agency, :sec_agency_1, :sec_agency_2, :cost_analysis
  json.url initiative_url(initiative, format: :json)
end