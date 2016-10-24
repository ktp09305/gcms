class AddTemplateIdToPages < ActiveRecord::Migration
  def change
    add_column :gcms_pages, :template_id, :integer
    add_foreign_key :gcms_pages, :gcms_templates if respond_to?(:add_foreign_key)
  end
end
