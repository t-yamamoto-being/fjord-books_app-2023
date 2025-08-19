# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  before_create :set_posted_date

  def author?(current_user)
    user == current_user
  end

  private

  def set_posted_date
    self.posted_date = Date.current
  end
end
