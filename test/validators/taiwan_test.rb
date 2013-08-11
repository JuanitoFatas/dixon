require_relative '../test_helper'

class TaiwanTest < Minitest::Unit::TestCase

  def setup
    @taiwan = Dixon::Validators::Taiwan.new
  end

  def test_checks_for_empty_id
    empty_id = ''
    assert_equal 'Empty ID.', @taiwan.checks(empty_id)
  end

  def test_checks_for_bad_format_id
    bad_format_id = "A12345678"
    assert_equal 'Invalid ID number.', @taiwan.checks(bad_format_id)
  end

  def test_checks_for_gender_out_of_range_id
    gender_out_of_range_id = "A324567945"
    assert_equal 'Invalid ID number.', @taiwan.checks(gender_out_of_range_id)
  end

  def test_checks_for_invalid_id
    invalid_id = "A123456788"
    assert_equal false, @taiwan.checks(invalid_id)
  end

  def test_checks_for_valid_id
    valid_id = 'A123456789'
    assert_equal true, @taiwan.checks(valid_id)
  end

end