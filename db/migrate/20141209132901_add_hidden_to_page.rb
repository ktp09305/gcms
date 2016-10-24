class AddHiddenToPage < ActiveRecord::Migration
  def change
    add_column :gcms_pages, :hidden, :boolean, default: false
  end
end
