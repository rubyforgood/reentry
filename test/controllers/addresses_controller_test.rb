require "test_helper"

describe AddressesController do
  let(:address) { addresses :one }

  it "gets index" do
    get addresses_url
    value(response).must_be :success?
  end

  it "gets new" do
    get new_address_url
    value(response).must_be :success?
  end

  it "creates address" do
    expect {
      post addresses_url, params: { address: { address_1: address.address_1, address_2: address.address_2, city: address.city, country: address.country, location_id: address.location_id, postal_code: address.postal_code, state_province: address.state_province } }
    }.must_change "Address.count"

    must_redirect_to address_path(Address.last)
  end

  it "shows address" do
    get address_url(address)
    value(response).must_be :success?
  end

  it "gets edit" do
    get edit_address_url(address)
    value(response).must_be :success?
  end

  it "updates address" do
    patch address_url(address), params: { address: { address_1: address.address_1, address_2: address.address_2, city: address.city, country: address.country, location_id: address.loction_id, postal_code: address.postal_code, state_province: address.state_province } }
    must_redirect_to address_path(address)
  end

  it "destroys address" do
    expect {
      delete address_url(address)
    }.must_change "Address.count", -1

    must_redirect_to addresses_path
  end
end
