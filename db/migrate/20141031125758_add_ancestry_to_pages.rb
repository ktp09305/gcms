class AddAncestryToPages < ActiveRecord::Migration
  def change
    add_column :gcms_pages, :ancestry, :string
    add_index :gcms_pages, :ancestry
  end
end
