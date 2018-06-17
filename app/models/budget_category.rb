# frozen_string_literal: true

class BudgetCategory < ApplicationRecord
  belongs_to :budget
  belongs_to :category
end
