require 'test_helper'

class LocationLoaderTest < ActiveSupport::TestCase
  let(:domain) { Domain.create }
  let(:loader) { LocationLoader }

  before(:each) do
    Location.destroy_all
    PhoneNumber.destroy_all
  end

  describe '.load!' do
    describe 'successfully' do
      it 'creates DB objects with correct associations from the supplied array of data' do
        loader.load!(parsed_array, domain: domain)
        allegany = Location.find_by_county('Allegany')

        assert_equal 2, Location.count
        assert_equal 3, PhoneNumber.count
        assert_equal 2, allegany.phone_numbers.count
      end

      it 'returns a successful Result object with no errors' do
        result = loader.load!(parsed_array, domain: domain)

        assert_instance_of LocationLoader::Result, result
        assert_equal true, result.success?
        assert_nil result.error
      end
    end

    describe 'unsuccessfully' do
      it 'does not create ActiveRecord objects from the supplied array of data' do
        loader.load!([], domain: domain)

        assert_equal 0, Location.count
      end
    end
  end

  private

  def parsed_array
    [
      {
        :county           => 'Allegany',
        :organization     => 'Alcoholics Anonymous',
        :address          => 'Various locations',
        :phone            => ['222-333-4444', '1-888-234-1122'],
        :website          => 'www.westernmarylandaa.org',
        :services         => 'Support services',
        :type_of_services => 'Substance Abuse',
      },
      {
        :county           => 'Anne Arundel',
        :organization     => 'The Light House Shelter',
        :address          => '10 Hudson Street Annapolis, MD 21401',
        :phone            => ['(410) 349-5056'],
        :website          => 'www.annapolislighthouse.org',
        :services         => 'Emergency shelter',
        :type_of_services => 'Shelter',
      }
    ]
  end
end
