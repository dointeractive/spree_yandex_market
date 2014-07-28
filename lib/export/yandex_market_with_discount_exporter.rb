module Export
  class YandexMarketWithDiscountExporter < YandexMarketExporter
    def shared_xml(xml, product, cat)
      xml.url product_url(product, :host => @host)
      xml.price product.price_with_discount
      xml.currencyId @currencies.first.first
      xml.categoryId cat.id
      xml.picture path_to_url(CGI.escape(product.images.first.attachment.url(:product, false))) unless product.images.empty?
    end
  end
end