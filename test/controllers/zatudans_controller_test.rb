require 'test_helper'

class ZatudansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @zatudan = zatudans(:one)
  end

  test 'should get index' do
    get zatudans_url
    assert_response :success
  end

  test 'should get new' do
    get new_zatudan_url
    assert_response :success
  end

  test 'should create zatudan' do
    assert_difference('Zatudan.count') do
      post zatudans_url, params: {zatudan: {message: @zatudan.message}}
    end

    assert_redirected_to zatudan_url(Zatudan.last)
  end

  test 'should show zatudan' do
    get zatudan_url(@zatudan)
    assert_response :success
  end

  test 'should get edit' do
    get edit_zatudan_url(@zatudan)
    assert_response :success
  end

  test 'should update zatudan' do
    patch zatudan_url(@zatudan), params: {zatudan: {message: @zatudan.message}}
    assert_redirected_to zatudan_url(@zatudan)
  end

  test 'should destroy zatudan' do
    assert_difference('Zatudan.count', -1) do
      delete zatudan_url(@zatudan)
    end

    assert_redirected_to zatudans_url
  end
end
