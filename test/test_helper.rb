require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def assert_statement_invalid(&block)
    assert_raise(ActiveRecord::StatementInvalid, &block)
  end

  def assert_record_not_unique(&block)
    assert_raise(ActiveRecord::RecordNotUnique, &block)
  end

  def assert_invalid_foreign_key(&block)
    assert_raise(ActiveRecord::InvalidForeignKey, &block)
  end
end
