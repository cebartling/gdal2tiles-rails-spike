require 'test_helper'

class MosaicTileControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get mosaic_tile_create_url
    assert_response :success
  end

end
