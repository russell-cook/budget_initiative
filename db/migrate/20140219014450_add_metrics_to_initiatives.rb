class AddMetricsToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :objective_1, :string
    add_column :initiatives, :benchmark_1a, :string
    add_column :initiatives, :benchmark_1b, :string
    add_column :initiatives, :objective_2, :string
    add_column :initiatives, :benchmark_2a, :string
    add_column :initiatives, :benchmark_2b, :string
    add_column :initiatives, :objective_3, :string
    add_column :initiatives, :benchmark_3a, :string
    add_column :initiatives, :benchmark_3b, :string
    add_column :initiatives, :init_pm_1, :string
    add_column :initiatives, :init_pm_1_prop, :boolean
    add_column :initiatives, :init_pm_2, :string
    add_column :initiatives, :init_pm_2_prop, :boolean
    add_column :initiatives, :init_pm_3, :string
    add_column :initiatives, :init_pm_3_prop, :boolean
    add_column :initiatives, :agency_pm_1, :string
    add_column :initiatives, :agency_pm_1_prop, :boolean
    add_column :initiatives, :agency_pm_2, :string
    add_column :initiatives, :agency_pm_2_prop, :boolean
    add_column :initiatives, :agency_pm_3, :string
    add_column :initiatives, :agency_pm_3_prop, :boolean
  end
end
