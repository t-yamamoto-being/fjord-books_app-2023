# frozen_string_literal: true

class Report < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  
  before_create :set_posted_date
  
  private
  
  def set_posted_date
    # posted_dateを現在の日付に設定
    self.posted_date = Date.current
  end
end 