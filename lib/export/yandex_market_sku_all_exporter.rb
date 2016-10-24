module Export
  class YandexMarketSkuAllExporter < YandexMarketExporter

    def offer_simple(xml, product, cat)
      product_properties = {}
      product.product_properties.map {|x| product_properties[x.property_name] = x.value }
      opt = { id: product.sku,  available: product.available? }
      xml.offer(opt) {
        shared_xml(xml, product, cat)
        individual_xml(xml, product, cat, product_properties)
      }
    end

    def get_products
      Spree::Product.joins(:taxons)
        .where(
          export_to_yandex_market: true,
          spree_taxons: { export_to_yandex_market: true, published: true }
        ).group_by_products_id
    end

    private

    def get_product_url(product)
      category = product.main_taxon

      product_url(product,
        host: @host,
        utm_source: @utm_source,
        utm_campaign: @utm_campaign || "#{category.id}.#{category.name}",
        utm_medium: 'cpc',
        utm_content: product.sku)
    end
  end
end
