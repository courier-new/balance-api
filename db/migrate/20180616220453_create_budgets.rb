# frozen_string_literal: true

class CreateBudgets < ActiveRecord::Migration[5.1]
  def change
    create_table :budgets do |t|
      t.string :name
      t.float :allotment
      t.date :start
      t.date :end

      t.timestamps
    end
  end
end
