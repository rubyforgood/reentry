class BaltimoreProcessor
  def perform(domain_id)
    loader = Loader
    domain = Domain.find(domain_id)
    fetcher = BaltimoreFetcher.new(domain)
    fetcher.fetch
    loader.load! fetcher.records, domain: domain
  end
end
