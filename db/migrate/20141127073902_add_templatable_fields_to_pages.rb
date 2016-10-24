class AddTemplatableFieldsToPages < ActiveRecord::Migration
  def change
    add_column :gcms_pages, :templatable, :boolean, default: false
    add_column :gcms_pages, :templatable_type, :string
  end
end
