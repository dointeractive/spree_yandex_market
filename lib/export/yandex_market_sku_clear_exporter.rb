module Export
  class YandexMarketSkuClearExporter < YandexMarketExporter

    def offer_simple(xml, product, cat)
      product_properties = {}
      product.product_properties.map {|x| product_properties[x.property_name] = x.value }
      opt = { id: product.sku,  available: product.available? }
      xml.offer(opt) {
        shared_xml(xml, product, cat)
        individual_xml(xml, product, cat, product_properties)
      }
    end

    private

    def get_product_url(product)
      product_url(product, host: @host)
    end
  end
end
