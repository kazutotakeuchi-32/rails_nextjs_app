# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::Current::Articles", type: :request do
  describe "POST api/v1/current/articles" do
    subject { post(api_v1_current_articles_path, headers:) }

    let(:headers) { current_user.create_new_auth_token }
    let(:current_user) { create(:user) }

    context "ログインしている場合" do
      context "下書き記事が存在しない場合" do
        it "下書き記事が新規作成される" do
          expect { subject }.to change { current_user.articles.count }.by(1)
          expect(current_user.articles.last).to be_status_unsaved
          res = JSON.parse(response.body)
          expect(res.keys).to eq %w[id title body status created_at from_today user]
          expect(res["user"].keys).to eq ["name"]
          expect(response).to have_http_status(:created)
        end
      end

      context "下書き記事が存在する場合" do
        it "下書き記事が新規作成されない" do
          current_user.articles.create!(status: :unsaved)
          expect { subject }.to change { current_user.articles.status_unsaved.count }.by(0)
          res = JSON.parse(response.body)
          expect(res["id"]).to eq current_user.articles.status_unsaved.first.id
          expect(response).to have_http_status(:created)
        end
      end
    end

    context "ログインしていない場合" do
      let(:headers) { nil }

      it "unauthorizedエラーが返ってくる" do
        subject
        res = JSON.parse(response.body)
        expect(res["errors"]).to eq ["ログインもしくはアカウント登録してください。"]
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "PUT api/v1/current/articles/:id" do
    subject { patch(api_v1_current_article_path(id), headers:, params:) }

    let(:headers) { current_user.create_new_auth_token }
    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:article) { current_user.articles.create(status: :unsaved) }
    let(:params) { { "article": { "title": "change title", "body": "change body", "status": "saved" } } }
    let(:current_user_article) { create(:article, user: current_user, title: "title", status: :unsaved, body: "body") }
    let(:id) { current_user_article.id }

    context "ログインしている場合" do
      context "ログインユーザーに紐づく下書き記事の場合" do
        it "下書き記事が更新される" do
          expect { subject }.to change { current_user_article.reload.title }.from("title").to("change title") and
            change { current_user_article.reload.body }.from("body").to("change body") and
            change { current_user_article.reload.status }.from("unsaved").to("saved")
          res = JSON.parse(response.body)
          expect(res.keys).to eq %w[id title body status created_at from_today user]
          expect(response).to have_http_status(:ok)
        end
      end

      context "ログインユーザーに紐づかない下書き記事の場合" do
        let(:other_user_article) { create(:article, user: other_user) }
        let(:id) { other_user_article.id }

        it "not_foundエラーが返ってくる" do
          expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "未ログインの場合" do
      let(:headers) { nil }

      it "unauthorizedエラーが返ってくる" do
        subject
        res = JSON.parse(response.body)
        expect(res["errors"]).to eq ["ログインもしくはアカウント登録してください。"]
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
