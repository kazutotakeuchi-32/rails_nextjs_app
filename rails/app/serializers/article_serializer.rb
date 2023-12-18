# frozen_string_literal: true

class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :status, :created_at, :from_today
  belongs_to :user, serializer: UserSerializer

  def created_at
    object.created_at.strftime('%Y/%m/%d日')
  end

  def from_today
    now = Time.zone.now
    created_at = object.created_at

    months = (now.year - created_at.year) * 12 + now.month - created_at.month - (now.day >= created_at.day ? 0 : 1)
    year = months.div(12)

    return "#{year}年前" if year.positive?
    return "#{months}ヶ月前" if months.positive?

    seconds = (Time.zone.now - object.created_at).round

    days = seconds.div(60 * 60 * 24)
    return "#{days}日前" if days.positive?

    hours = seconds.div(60 * 60)

    return "#{hours}時間前" if hours.positive?

    minutes = seconds.div(60)

    return "#{minutes}分前" if minutes.positive?

    "#{seconds}秒前"
  end

  def status
    object.status_i18n
  end
end
