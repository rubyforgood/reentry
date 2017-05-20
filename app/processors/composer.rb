class Composer
  def self.build
    new(
      parser:     CSVParser,
      normalizer: Normalizer,
      loader:     LocationLoader
    )
  end

  def initialize(parser:, normalizer:, loader:)
    @parser     = parser
    @normalizer = normalizer
    @loader     = loader
  end

  def call!(file_path)
    compose(
      file_path,
      :parse,
      :normalize,
      :load!
    )
  end

  private

  attr_reader :parser, :normalizer, :loader

  def compose(file_path, *methods)
    methods.inject(file_path) do |result, method|
      self.send(method, result)
    end
  end

  def parse(file_path)
    parser.parse(file_path)
  end

  def normalize(data)
    normalizer.normalize(data)
  end

  def load!(data)
    loader.load!(data)
  end
end
