require 'rails_helper'

describe Organization do
  subject { Organization.new(domain: "revollet.io", schema: "revollet2") }
  it { should validate_presence_of(:domain) }
  it { should validate_presence_of(:schema) }
  it { should validate_uniqueness_of(:schema)}
end
