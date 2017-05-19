require 'test_helper'

class NormalizerTest < ActiveSupport::TestCase
  let(:normalizer) { Normalizer }

  describe '.normalize' do
    it 'normalizes data accordingly and returns an array of hashes' do
      normalized_array = normalizer.normalize(parsed_array)

      assert_instance_of Array, normalized_array
      assert_instance_of Hash, normalized_array.first
    end
  end

  private

  def parsed_array
    [
      {
        :county           => 'Allegany',
        :name             => 'Alcoholics Anonymous',
        :address          => 'Various locations',
        :phone            => '(301) 722-6110',
        :website          => 'www.westernmarylandaa.org',
        :services         => 'Support services',
        :type_of_services => 'Substance Abuse',
      },
      {
        :county           => 'Anne Arundel',
        :name             => 'The Light House Shelter',
        :address          => '10 Hudson Street Annapolis, MD 21401',
        :phone            => '(410) 349-5056',
        :website          => 'www.annapolislighthouse.org',
        :services         => 'Emergency shelter',
        :type_of_services => 'Shelter',
      }
    ]
  end
end
