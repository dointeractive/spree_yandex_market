module Export
  class YandexMarketIdAllExporter < YandexMarketExporter

    def get_products
      products = Spree::Product
        .joins(:taxons).merge(Spree::Taxon.published)
        .where(export_to_yandex_market: true)
        .group_by_products_id

      products = products.on_hand if @config.preferred_wares == "on_hand"
      products.joins(:taxons).where(spree_taxons: { export_to_yandex_market: true })
    end
  end
end
