require 'test_helper'

class OhanaRecordsetTest < ActiveSupport::TestCase
  let(:attributes) do
    {
      name: "test org",
      services: "they do stuff",
      address: "1212 Mockingbird Ln., Baltimore, MD 21212"
    }
  end

  let(:loc)  { Location.create(**attributes) }
  let(:recordset) { OhanaRecordset.new(loc) }

  it "populates required organization fields" do
    assert_equal attributes[:name], recordset.organization[:name]
    assert_equal attributes[:services], recordset.organization[:description]
    assert_kind_of Numeric, recordset.organization[:id]
  end

  it 'populates require location fields' do
    assert_equal attributes[:name], recordset.location[:name]
    assert_equal attributes[:services], recordset.location[:description]
  end

  it 'is super lazy about assigning ids' do
    # this is more of a requirement
    assert_equal recordset.organization[:id], recordset.location[:organization_id]
    assert_equal recordset.location[:id], recordset.address[:location_id]
    # this is me being lazy
    assert_equal recordset.location[:id], recordset.organization[:id]
    assert_equal recordset.location[:id], recordset.address[:id]
  end

  it 'populates required address fields' do
    assert_equal "1212 Mockingbird Ln.",  recordset.address[:address_1]
    assert_equal "Baltimore", recordset.address[:city]
    assert_equal "MD", recordset.address[:state_province]
    assert_equal "21212", recordset.address[:postal_code]
    assert_equal "US", recordset.address[:country]
  end
end
