# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  PAGE_PER = 10

  enum status: { unsaved: 1, saved: 2, published: 3 }, _prefix: true

  validates :title, :body, presence: true, if: :is_published?
  validate :verify_only_one_unsaved_status_is_allowed

  scope :published, -> { where(status: statuses[:published]) }
  scope :status_unsaved, -> { where(status: statuses[:unsaved]) }
  scope :not_status_unsaved, -> { where.not(status: statuses[:unsaved]) }

  private

  def is_published?
    status_published?
  end

  def verify_only_one_unsaved_status_is_allowed
    return unless status_unsaved? && user.articles.status_unsaved.exists?

    raise StandardError, '未保存の記事は一つまでです。'
  end
end
