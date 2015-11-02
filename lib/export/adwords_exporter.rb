module Export
  class AdwordsExporter < YandexMarketExporter
    def initialize
      @utm_source = 'google.adwords'
    end
  end
end
