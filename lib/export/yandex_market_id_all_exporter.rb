module Export
  class YandexMarketIdAllExporter < YandexMarketExporter

    def get_products
      Spree::Product.joins(:taxons)
        .where(
          export_to_yandex_market: true,
          spree_taxons: { export_to_yandex_market: true, published: true }
        ).group_by_products_id
    end
  end
end
