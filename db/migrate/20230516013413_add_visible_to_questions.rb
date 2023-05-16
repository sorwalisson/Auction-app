class AddVisibleToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :visible, :boolean, default: true
  end
end
