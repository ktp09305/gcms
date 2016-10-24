class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :gcms_templates do |t|
      t.string :name
      t.text :content, default: ""

      t.timestamps null: false
    end
  end
end
