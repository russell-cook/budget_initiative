class AddPopulationDataToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :population, :string
    add_column :initiatives, :caseload, :string
    add_column :initiatives, :who_impacted, :string
  end
end
