# frozen_string_literal: true

module Api
  module V1
    class HealthCheckController < ApplicationController
      def index
        render json: { message: 'Success Health Check' }, status: 200
      end
    end
  end
end
