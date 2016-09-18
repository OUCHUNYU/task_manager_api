class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text   :description
      t.string :open_task_order
      t.string :in_progress_task_order
      t.string :done_task_order
      t.integer :user_id
      t.boolean :archive, default: false

      t.timestamps
    end
  end
end
