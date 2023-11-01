class ChangeCloumsNotnullAddLabels < ActiveRecord::Migration[6.1]
  def change
    change_column_null :labels, :label_title, false
  end
end
