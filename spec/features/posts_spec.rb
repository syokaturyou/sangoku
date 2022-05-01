require 'rails_helper'

RSpec.feature 'Poss', type: :feature do
  describe 'display post details' do
    # let(:post) { create(:post) }
    # let(:posts) { create_list(:post, 4) }
    given(:posts) { create_list(:product, 4) }
    given(:image) { create(:image) }

    background do
      post.images << image
      posts.each { |post| post.images << create(:image) }
      visit public_posts_path
    end

    scenario '投稿の詳細情報が適切なタグ内に存在すること' do
      posts.all? do |post|
        expect(page).to have_selector 'td', text: post.posttitle
        expect(page).to have_selector 'td', text: post.name
        expect(page).to have_selector '.page-title', text: post.name
      end
    end

    scenario '詳細ページに遷移できること' do
      click_link "#{post.posttitle}"
      expect(current_path).to eq public_post_path(post)
    end

  end
end