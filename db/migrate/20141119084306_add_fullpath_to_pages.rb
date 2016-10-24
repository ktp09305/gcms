class AddFullpathToPages < ActiveRecord::Migration
  def change
    add_column :gcms_pages, :fullpath, :string
  end
end
