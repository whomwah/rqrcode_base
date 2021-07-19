# frozen_string_literal: true

require "test_helper"

class RQRCodeCore::MultiTest < Minitest::Test
  PAYLOAD = [{data: "byteencoded", mode: :byte_8bit}, {data: "A1" * 107, mode: :alphanumeric}, {data: "1" * 498, mode: :number}]
  def test_multi_payloads
    RQRCodeCore::QRCode.new(PAYLOAD, mode: "multi", level: :l)
    RQRCodeCore::QRCode.new(PAYLOAD, mode: "multi", level: :m)
    RQRCodeCore::QRCode.new(PAYLOAD, mode: "multi", level: :q)
    RQRCodeCore::QRCode.new(PAYLOAD, mode: "multi")
    RQRCodeCore::QRCode.new(PAYLOAD, mode: "multi", level: :l, max_size: 22)
  rescue => e
    flunk(e)
  end

  def test_invalid_code_configs
    assert_raises(RQRCodeCore::QRCodeArgumentError) {
      RQRCodeCore::QRCode.new(PAYLOAD)
      RQRCodeCore::QRCode.new("duncan", mode: "multi")
      RQRCodeCore::QRCode.new(:not_a_string_or_array)
    }
  end
end
