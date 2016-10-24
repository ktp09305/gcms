class CreateGcmsSettings < ActiveRecord::Migration
  def change
    create_table :gcms_settings do |t|
      t.json :values

      t.timestamps null: false
    end
  end
end
