module Export
  class MixuniExporter < YandexMarketExporter
    def initialize
      @utm_source = 'mixuni'
      @utm_campaign = 'tovar'
    end
  end
end
