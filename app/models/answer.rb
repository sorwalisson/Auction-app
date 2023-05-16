class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates :message, presence: true
end
