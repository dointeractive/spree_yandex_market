module Export
  class GarpunExporter < YandexMarketExporter
    def initialize
      @utm_source = 'yandex.direct'
    end
  end
end
