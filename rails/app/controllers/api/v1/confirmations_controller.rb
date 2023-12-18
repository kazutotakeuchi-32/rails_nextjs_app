class Api::V1::ConfirmationsController < Api::V1::BaseController
  def update
    user = User.find_by(confirmation_token: params[:confirmation_token])

    raise StandardError if user.nil?
    raise StandardError if user.confirmed?

    user.confirm!
    render json: { message: '認証完了しました。', status: 200 }
  rescue StandardError => e
    render json: { errors: e.message }, status: :unprocessable_entity
  end
end
