# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Current::Users', type: :request do
  describe 'GET api/v1/current/user  api/v1/current/user#show' do
    subject { get(api_v1_current_user_path(current_user), headers:) }

    let(:current_user) { create(:user) }
    let(:headers) { current_user.create_new_auth_token }

    context 'ヘッダー情報が正常に送られた場合' do
      it '正常にレコードを取得できる' do
        subject
        res = JSON.parse(response.body)
        expect(res.keys).to eq %w[id name email]
        expect(response).to have_http_status(:success)
      end
    end

    context 'ヘッダー情報が送られなかった場合' do
      let(:headers) { nil }
      it 'unauthorizedエラーが返ってくる' do
        subject
        res = JSON.parse(response.body)
        expect(res['errors']).to eq ['ログインもしくはアカウント登録してください。']
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
