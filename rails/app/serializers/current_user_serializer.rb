# frozen_string_literal: true

class CurrentUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
end
