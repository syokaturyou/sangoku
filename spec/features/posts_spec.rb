require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  describe 'display post details' do
    given(:genre) { create(:genre) }
    given(:member) { create(:member) }
    given(:post) { create(:post, member:member, genre:genre) }

    background do
      visit public_post_path(post.id)
    end

    scenario '投稿の詳細情報が適切なタグ内に存在すること' do
      expect(page).to have_selector 'td', text: post.posttitle
      expect(page).to have_selector 'td', text: post.postsyutten
      expect(page).to have_selector 'td', text: post.postbody
    end

    # scenario '詳細ページに遷移できること' do
    #   click_link "#{post.posttitle}"
    #   expect(current_path).to eq public_post_path(post)
    # end
  end
end
