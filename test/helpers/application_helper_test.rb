require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'full title helper' do
    assert_equal 'Sample App', full_page_title
    assert_equal 'Help | Sample App', full_page_title('Help')
  end
end
