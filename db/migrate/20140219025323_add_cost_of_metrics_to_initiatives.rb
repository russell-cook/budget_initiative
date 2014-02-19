class AddCostOfMetricsToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :init_pm_1_cost, :string
    add_column :initiatives, :init_pm_2_cost, :string
    add_column :initiatives, :init_pm_3_cost, :string
  end
end
