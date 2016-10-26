module Export
  class YandexMarketAllExporter < YandexMarketExporter

    def get_products
      Spree::Product.not_gifts.joins(:taxons).group_by_products_id
    end
  end
end
