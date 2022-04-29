require 'rails_helper'

RSpec.feature 'Poss', type: :feature do
  describe 'display post details' do
    # let(:post) { create(:post) }
    # let(:posts) { create_list(:post, 4) }
    # let(:image) { create(:image) }

    background do
      post.images << image
      posts.each { |post| post.images << create(:image) }
      visit public_posts_path
    end

    scenario '商品の詳細情報が適切なタグ内に存在すること' do
      expect(page).to have_selector 'li', text: product.name
      expect(page).to have_selector 'h2', text: product.name
      expect(page).to have_selector '.page-title', text: product.name
    end

    scenario 'カテゴリーページに遷移できること' do
      click_link '一覧ページへ戻る'
      expect(current_path).to eq potepan_category_path(taxon.id)
    end

  end
end