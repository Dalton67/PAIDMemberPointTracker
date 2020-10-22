# frozen_string_literal: true

require 'test_helper'

class GeneralmemberControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get generalmember_index_url
    assert_response :success
  end
end
