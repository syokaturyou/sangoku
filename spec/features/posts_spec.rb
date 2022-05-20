require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  describe 'display post#show' do
    given(:genre) { create(:genre) }
    given(:member) { create(:member) }
    given(:post) { create(:post, member: member, genre: genre) }
    given(:answer) { create(:answer, post: post) }

    background do
      visit public_post_path(post.id)
    end

    scenario '投稿の詳細情報が適切なタグ内に存在すること' do
      expect(page).to have_selector 'td', text: post.posttitle
      expect(page).to have_selector 'td', text: post.postsyutten
      expect(page).to have_selector 'td', text: post.postbody
      expect(page).to have_selector 'td', text: answer.answerbody
      expect(page).to have_selector 'td', text: answer.answersyutten
    end
  end

  describe 'display post#index' do
    given(:genre) { create(:genre) }
    given(:member) { create(:member) }
    given!(:posts) { create_list(:post, 5, genre: genre, member: member) }

    background do
      visit public_posts_path
    end

    scenario '投稿の詳細情報が適切なタグ内に存在すること' do
      within '.informtable' do
        posts.all? do |post|
          expect(page).to have_selector 'th', text: '質問タイトル'
          expect(page).to have_selector 'td', text: post.posttitle
          expect(page).to have_selector 'td', text: post.postbody
        end
      end
    end

    it '詳細画面に遷移できるかどうか' do
      within '.informtable' do
        posts.all? do |post|
          # expect(page).to have_link post.posttitle
          # click_on post.posttitle, match: :first
          # click_link(post.posttitle)
          # find(post.posttitle).click
          # expect(page).to eq public_post_path(post.id)
          # find(post.posttitle).click
          # click_link post.posttitle, match: :first
          # click_on post.posttitle
          # click_link post.posttitle
        end
      end
    end
  end
end
