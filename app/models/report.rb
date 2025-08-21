# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def referenced_report_ids
    url_pattern = /\/reports\/(\d+)/
    matches = content.scan(url_pattern)
    matches.flatten.map(&:to_i).uniq
  end

  def referenced_by_reports
    Report.where(id: referenced_by_report_ids)
  end

  private

  def referenced_by_report_ids
    Report.where("content LIKE ?", "%/reports/#{id}%").pluck(:id)
  end
end
