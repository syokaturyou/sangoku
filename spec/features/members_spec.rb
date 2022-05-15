require 'rails_helper'

RSpec.feature 'Members', type: :feature do
  describe 'display member details' do
    given(:member) { create(:member) }

    background do
      visit public_member_path(member.id)
    end

    scenario '会員の詳細情報が適切なタグ内に存在すること' do
      expect(page).to have_selector 'td', text: member.name
      expect(page).to have_selector 'td', text: member.profile
    end
  end

  describe 'display member details' do
    given(:member) { create(:member) }

    background do
      visit public_members_path
    end

    scenario '会員の詳細情報が適切なタグ内に存在すること' do
      within '.membertable' do
        expect(page).to have_selector 'th', text: 'ステータス'
        # expect(page).to have_selector 'td', text: member.id
        # expect(page).to have_selector 'td', text: member.name
      end
    end
  end
end
