require 'application_system_test_case'

class ZatudansTest < ApplicationSystemTestCase
  setup do
    @zatudan = zatudans(:one)
  end

  test 'visiting the index' do
    visit zatudans_url
    assert_selector 'h1', text: 'Zatudans'
  end

  test 'creating a Zatudan' do
    visit zatudans_url
    click_on 'New Zatudan'

    fill_in 'Message', with: @zatudan.message
    click_on 'Create Zatudan'

    assert_text 'Zatudan was successfully created'
    click_on 'Back'
  end

  test 'updating a Zatudan' do
    visit zatudans_url
    click_on 'Edit', match: :first

    fill_in 'Message', with: @zatudan.message
    click_on 'Update Zatudan'

    assert_text 'Zatudan was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Zatudan' do
    visit zatudans_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Zatudan was successfully destroyed'
  end
end
