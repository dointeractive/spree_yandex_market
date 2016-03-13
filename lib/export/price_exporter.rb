module Export
  class PriceExporter < YandexMarketExporter
    def initialize
      @utm_source = 'price'
      @utm_campaign = 'tovar'
    end
  end
end
