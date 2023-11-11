class RemoveTaskIdFromLabels < ActiveRecord::Migration[6.1]
  def change
    remove_column :labels, :task_id, :bigint
  end
end
