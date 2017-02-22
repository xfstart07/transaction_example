class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title, comment: '标题', null: false
      t.text :description, comment: '描述'
      t.boolean :on_demand, comment: '需求'

      t.timestamps
    end
  end
end
