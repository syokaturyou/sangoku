require 'rails_helper'

RSpec.feature 'Sights', type: :feature do
  describe 'display sight details' do
    given(:member) { create(:member) }
    given(:sight) { create(:sight, member: member) }

    background do
      visit sight_path(sight.id)
    end

    scenario 'おすすめ地域の詳細情報が適切なタグ内に存在すること' do
      expect(page).to have_selector 'td', text: sight.address
      expect(page).to have_selector 'td', text: sight.latitude
      expect(page).to have_selector 'td', text: sight.longitude
    end
  end

  describe 'display sight details' do
    given(:member) { create(:member) }
    given(:sights) { create_list(:sight, 5, member: member) }

    background do
      visit sights_path
    end

  end
end