require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  describe 'display post details' do
    given(:post) { create(:post) }
    # let(:posts) { create_list(:post, 4) }
    # given(:genre) { create(:genre, name: 'genre') }
    # given(:member) { create(:member) }
    # given(:post) { create(:post, genres: [genre], members: [member]) }
    # given(:posts) { create_list(:post, 5, genres: [genre], members: [member]) }
    # given(:image) { create(:image) }

    background do
      visit public_post_path(post.id)
    end

    scenario '投稿の詳細情報が適切なタグ内に存在すること' do
      expect(page).to have_selector 'td', text: post.posttitle
      expect(page).to have_selector 'td', text: post.name
      expect(page).to have_selector '.page-title', text: post.name
    end

    # scenario '詳細ページに遷移できること' do
    #   click_link "#{post.posttitle}"
    #   expect(current_path).to eq public_post_path(post)
    # end
  end
end
