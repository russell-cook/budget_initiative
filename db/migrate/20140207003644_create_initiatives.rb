class CreateInitiatives < ActiveRecord::Migration
  def change
    create_table :initiatives do |t|
      t.text :title
      t.text :description
      t.text :justification
      t.text :alternatives
      t.text :lead_agency
      t.text :sec_agency_1
      t.text :sec_agency_2
      t.text :cost_analysis

      t.timestamps
    end
  end
end
