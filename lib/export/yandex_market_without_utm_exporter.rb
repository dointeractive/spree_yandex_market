module Export
  class YandexMarketWithoutUtmExporter < YandexMarketExporter
    private

    def get_product_url(product)
      product_url(product, host: @host)
    end
  end
end
