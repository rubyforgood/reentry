class Domain < ApplicationRecord
  PROCESSORS = {
    'DOJProcessor' => DOJProcessor,
    'BaltimoreProcessor' => BaltimoreProcessor
  }

  def perform_processor
    processor.perform(id)
  end

  private

  def processor
    PROCESSORS.fetch(kind).new
  end
end
