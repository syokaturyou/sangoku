require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET public/posts#show' do
    let(:genre) { create(:genre) }
    let(:member) { create(:member) }
    let(:post) { create(:post, genre: genre, member: member) }
    let(:answer) { create(:answer, post: post) }

    before do
      get public_post_path(post.id)
    end

    it 'httpリクエストが正常に返るかどうか' do
      expect(response).to have_http_status(:success)
    end

    it '質問タイトルが表示されているかどうか' do
      expect(response.body).to include post.posttitle
      # expect(response.body).to include "#{post.posttitle.to_s}"
    end

    it '質問文が表示されているかどうか' do
      expect(response.body).to include post.postbody
    end

    it '参考urlが表示されているかどうか' do
      expect(response.body).to include post.postsyutten
    end

    it '回答本文が表示されているかどうか' do
      expect(response.body).to include answer.answerbody
    end

    it '参考URLが表示されているかどうか' do
      expect(response.body).to include answer.answersyutten
    end
  end

  describe 'GET public/posts#index' do
    let(:genre) { create(:genre) }
    let(:member) { create(:member) }
    # let(:genres) { create_list(:genre, 2) }
    # let(:members) { create_list(:member, 2) }
    let!(:posts) { create_list(:post, 2, genre: genre, member: member) }
    # let(:post) { create(:post, genre: genre, member: member) }
    # let(:posts) { create_list(:post, 2) }

    before do
      # posts.images << image
      # posts.each { |post| post.images << create(:image) }
      get public_posts_path
      # sign_in :member
    end

    it 'httpリクエストが正常に返るかどうか' do
      expect(response).to have_http_status(:success)
    end

    it '質問タイトルが表示されているかどうか' do
      expect(response.body).to include '質問タイトル'
      # expect(response.body).to have_button '新規質問投稿する'
      posts.each do |post|
        expect(response.body).to include post.posttitle
        expect(response.body).to include member.name
      end
    end

    # it '遷移できるかどうか' do
    #   posts.all? do |post|
    #     click_on '新規質問投稿する'
    #     expect(current_path).to eq public_post_path(post.id)
    #     expect(current_path).to eq new_public_post_path
    #   end
    # end
  end
end
