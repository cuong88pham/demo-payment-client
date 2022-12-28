require 'rails_helper'

describe WaoRor::Application, 'configuration' do
  let(:config) { described_class.config }

  it "sets default timezone to UTC" do
    expect(config.time_zone).to eq("UTC")
    # expect(config.active_record.default_timezone).to eq(:local)
    # expect(Time.zone.parse("1991-05-23 05:23 PDT").to_s).to eq("1991-05-23 19:23:00 +0700")
  end
end
