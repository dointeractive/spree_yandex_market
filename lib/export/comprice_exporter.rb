module Export
  class CompriceExporter < YandexMarketExporter
    def initialize
      @utm_source = 'comprice'
      @utm_campaign = 'tovar'
    end
  end
end
