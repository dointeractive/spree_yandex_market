# -*- coding: utf-8 -*-

module Export
  class GarpunExporter < YandexMarketExporter
    def initialize
      @utm_source = 'yandex.direct'
    end

    private

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
  end
end
