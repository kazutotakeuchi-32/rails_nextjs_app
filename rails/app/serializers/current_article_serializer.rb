# frozen_string_literal: true

class CurrentArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :status, :created_at
  belongs_to :user, serializer: CurrentUserSerializer

  def created_at
    object.created_at.strftime("%Y/%m/%d")
  end

  def status
    object.status_i18n
  end
end
