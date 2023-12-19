# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include Pagination
      alias_method :current_user, :current_api_v1_user
      alias_method :authenticate_user!, :authenticate_api_v1_user!
      alias_method :user_signed_in?, :api_v1_user_signed_in?
    end
  end
end
