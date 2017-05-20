class DOJProcessor
  def perform(id)
    domain = Domain.find(id)

    fetcher = DOJFetcher
    parser = CSVParser
    normalizer = Normalizer
    loader = Loader

    data = normalizer.normalize parser.parse fetcher.fetch domain
    loader.load! data, domain: domain
  end
end
