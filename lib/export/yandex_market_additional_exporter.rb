# -*- coding: utf-8 -*-
module Export
  class YandexMarketAdditionalExporter < YandexMarketExporter
    def individual_xml(xml, product, cat, product_properties)
      I18n.with_locale(:ru) do
        xml.delivery            true
        xml.local_delivery_cost @config.preferred_local_delivery_cost unless @config.preferred_local_delivery_cost.blank?
        xml.name                product.name
        xml.vendor              product.manufacturer.try(:name)
        xml.vendorCode          product_properties[@config.preferred_vendor_code] if product_properties[@config.preferred_country_of_manufacturer].present?
        xml.description         product.description if product.description.present?
        xml.sales_notes "#{Spree.t(:min_order_amount)} #{MinOrderHelper.min_order_from_config} руб."
        xml.country_of_origin   product_properties[@config.preferred_country_of_manufacturer] if product_properties[@config.preferred_country_of_manufacturer].present?
        xml.downloadable        false
      end
    end

    def shared_xml(xml, product, cat)
      I18n.with_locale(:ru) do
        xml.url product_url(product, taxon_path: product.main_taxon, :host => @host)
        xml.price product.items_per_pack.present? && product.items_per_pack > 1 ? product.price * product.items_per_pack : product.price
        xml.currencyId @currencies.first.first
        xml.categoryId cat.id
        xml.picture path_to_url(CGI.escape(product.images.first.attachment.url(:product, false))) unless product.images.empty?
      end
    end
  end
end