class CreateLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :labels do |t|
      t.string :label_title
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
