# frozen_string_literal: true

class UserBudget < ApplicationRecord
  belongs_to :user
  belongs_to :budget
end
