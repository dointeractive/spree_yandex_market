module Export
  class YandexMarketWithoutUtmExporter < YandexMarketExporter
    private

    def prepare_product_url(product)
      product_url(product, host: @host)
    end
  end
end
