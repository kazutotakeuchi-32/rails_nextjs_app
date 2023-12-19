# frozen_string_literal: true

require "rails_helper"

RSpec.describe Article, type: :model do
  context "factoryのデフォルト設定に従った時" do
    subject { create(:article) }

    it "正常にレコードが作成される" do
      expect { subject }.to change { Article.count }.by(1)
    end
  end

  describe "バリデーション" do
    subject { article.valid? }

    let(:article) { build(:article, title:, body:, status:, user:) }
    let(:title) { Faker::Lorem.sentence }
    let(:body) { Faker::Lorem.paragraph }
    let(:status) { :published }
    let(:user) { create(:user) }

    context "全ての値が正常な場合" do
      it "正常にレコードが作成される" do
        expect(subject).to eq true
      end
    end

    context "ステータスが公開ずみ且つ、タイトルが空の場合" do
      let(:title) { "" }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(article.errors.full_messages).to eq ["タイトルを入力してください"]
      end
    end

    context "ステータスが公開ずみ且つ、本文が空の場合" do
      let(:body) { "" }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(article.errors.full_messages).to eq ["本文を入力してください"]
      end
    end

    context "ステータスが未保存且つ未保存ステータスのレコードがすでに存在する場合" do
      subject { article.save }

      let(:status) { :unsaved }
      before { create(:article, status: :unsaved, user:) }

      it "例外が発生する" do
        expect { subject }.to raise_error(StandardError)
      end
    end
  end
end
