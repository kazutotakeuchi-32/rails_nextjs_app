# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Articles', type: :request do
  describe 'GET  /api/v1/articles' do
    subject { get(api_v1_articles_path(params)) }

    before do
      create_list(:article, 25, status: :published)
      create_list(:article, 10, status: :unsaved)
      create_list(:article, 5, status: :saved)
    end

    context 'パラメータが指定されていない場合' do
      let(:params) { {} }

      it '公開済みの記事一覧が10件取得できる' do
        subject

        res = JSON.parse(response.body)

        expect(res['articles'].length).to eq 10
        expect(res['articles'][0].keys).to eq %w[id title body status created_at from_today user]
        expect(res['meta'].keys).to eq %w[current_page total_pages next_page prev_page]
        expect(res['meta']['current_page']).to eq 1
        expect(res['meta']['total_pages']).to eq 3

        expect(response).to have_http_status(:success)
      end
    end

    context 'pageパラメータが指定されている場合' do
      let(:params) { { page: 2 } }

      it '公開済みの該当ページの記事を10件を取得できる事' do
        subject

        res = JSON.parse(response.body)

        expect(res['articles'].length).to eq 10
        expect(res['articles'][0].keys).to eq  %w[id title body status created_at from_today user]
        expect(res['meta']['current_page']).to eq 2
        expect(res['meta']['total_pages']).to eq 3
        expect(res['meta'].keys).to eq %w[current_page total_pages next_page prev_page]
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET  /api/v1/articles/:id' do
    subject { get(api_v1_article_path(article.id)) }

    let(:article) { create(:article, status:) }

    context 'レコードが存在する場合' do
      let(:article_id) { article.id }

      context 'ステータスが公開済みの場合' do
        let(:status) { :published }

        it '公開済みの記事情報を取得できる' do
          subject
          res = JSON.parse(response.body)

          expect(res.keys).to eq %w[id title body status created_at from_today user]
          expect(res['user'].keys).to eq ['name']
          expect(response).to have_http_status(:success)
        end
      end

      context 'ステータスが未保存の場合' do
        let(:status) { :unsaved }
        it 'AciteveRecord::RecordNotFoundが発生する' do
          expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'ステータスが保存済みの場合' do
        let(:status) { :saved }

        it 'AciteveRecord::RecordNotFoundが発生する' do
          expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context 'レコードが存在しない場合' do
      let(:article_id) { 100_000 }
      it 'AciteveRecord::RecordNotFoundが発生する' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
