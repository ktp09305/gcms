class AddPositionToGcmsPages < ActiveRecord::Migration
  def change
    add_column :gcms_pages, :position, :integer, default: 0, null: false
  end
end
