require_relative 'headers_set'
require 'minitest/autorun'

class TestHeadersSet < Minitest::Test

  def test_headings
    test_set1 = [
      { id: 1, title: 'heading1', heading_level: 0 },
      { id: 2, title: 'heading2', heading_level: 2 },
      { id: 3, title: 'heading3', heading_level: 1 },
      { id: 4, title: 'heading4', heading_level: 1 }
    ]

    test_set2 = [
      { id: 1, title: 'heading1', heading_level: 0 },
      { id: 2, title: 'heading2', heading_level: 3 },
      { id: 3, title: 'heading3', heading_level: 4 },
      { id: 4, title: 'heading4', heading_level: 1 },
      { id: 5, title: 'heading5', heading_level: 0 }
    ]

    expected_set_2 = [
      { id: 1, title: 'heading1', heading_level: 0, numeration: '1.' },
      { id: 2, title: 'heading2', heading_level: 3, numeration: '1.1.1.1' },
      { id: 3, title: 'heading3', heading_level: 4, numeration: '1.1.1.1.1' },
      { id: 4, title: 'heading4', heading_level: 1, numeration: '1.2' },
      { id: 5, title: 'heading5', heading_level: 0, numeration: '2.' }
    ]

    set1 = HeadersSet.new(test_set1)
    set2 = HeadersSet.new(test_set2)

    assert set1.numerated.dig(0, :numeration) == '1.'
    assert set1.numerated.dig(1, :numeration) == '1.1.1'
    assert set1.numerated.dig(2, :numeration) == '1.2'
    assert set1.numerated.dig(3, :numeration) == '1.3'

    assert set2.numerated == expected_set_2
  end
end
