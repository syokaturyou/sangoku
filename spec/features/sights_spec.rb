require 'rails_helper'

RSpec.feature 'Sights', type: :feature do
  describe 'display sight details' do
    given(:sight) { create(:sight) }

    background do
      visit sight_path(sight.id)
    end

    scenario '投稿の詳細情報が適切なタグ内に存在すること' do
      expect(page).to have_selector 'td', text: post.posttitle
      expect(page).to have_selector 'td', text: post.postsyutten
      expect(page).to have_selector 'td', text: post.postbody
      expect(page).to have_selector 'td', text: answer.answerbody
      expect(page).to have_selector 'td', text: answer.answersyutten
    end
  end

  describe 'display sight details' do
    given(:sights) { create_list(:sight, 5) }

    background do
      visit sights_path
    end

  end
end