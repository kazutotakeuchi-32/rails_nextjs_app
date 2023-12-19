# frozen_string_literal: true

module Api
  module V1
    class ConfirmationsController < Api::V1::BaseController
      def update
        user = User.find_by(confirmation_token: params[:confirmation_token])

        raise StandardError if user.nil?
        raise StandardError if user.confirmed?

        user.confirm!
        render json: { message: "認証完了しました。", status: 200 }
      rescue => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end
    end
  end
end
