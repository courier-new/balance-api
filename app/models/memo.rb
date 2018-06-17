# frozen_string_literal: true

class Memo < ApplicationRecord
  belongs_to :expense
  belongs_to :person
end
