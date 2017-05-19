require 'test_helper'

class ComposerTest < ActiveSupport::TestCase
  let(:composer)  { Composer }
  let(:file_path) { Rails.root + 'spec/fixtures/data.csv' }

  before(:each) do
    Location.destroy_all
  end

  describe '.build' do
    it 'builds a Composer with sensible defaults for Location CSV processing' do
      default_composer = composer.build

      assert_equal CSVParser,  default_composer.send(:parser)
      assert_equal Normalizer, default_composer.send(:normalizer)
      assert_equal Loader,     default_composer.send(:loader)
    end
  end

  describe '#initialize' do
    it 'requires a parser, normalizer, and loader' do
      parser     = mock('parser')
      normalizer = mock('normalizer')
      loader     = mock('loader')

      result = composer.new(
        parser:     parser,
        normalizer: normalizer,
        loader:     loader
      )

      assert_instance_of Composer, result
    end
  end

  describe '#call!' do
    it 'it returns a Result object' do
      default_composer = composer.build
      result_object    = mock('Result Object')

      expect_composed_dependencies_and_return(result_object)

      default_composer.call!(file_path)
    end
  end

  def expect_composed_dependencies_and_return(result)
    parsed     = mock('parsed')
    normalized = mock('normalized')

    CSVParser
      .expects(:parse)
      .with(file_path)
      .returns(parsed)

    Normalizer
      .expects(:normalize)
      .with(parsed)
      .returns(normalized)

    Loader
      .expects(:load!)
      .with(normalized)
      .returns(result)
  end
end
