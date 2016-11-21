module Export
  class TorgMailRuExporter < YandexMarketExporter
    # http://torg.mail.ru/info/122/
    # cbid - ставка для управления позицией товара в карточке модели. Задается в российских рублях.
    CBID = '10'

    def export
      @config = Spree::YandexMarket::Config.instance
      @host = @config.preferred_url.sub(%r[^http://],'').sub(%r[/$], '')
      ActionController::Base.asset_host = @config.preferred_url

      @currencies = @config.preferred_currency.split(';').map{|x| x.split(':')}
      @currencies.first[1] = 1

      Nokogiri::XML::Builder.new(encoding: 'utf-8') do |xml|
        xml.torg_price(date: Time.now.to_s(:ym)) do

          xml.shop do
            xml.name    @config.preferred_short_name
            xml.company @config.preferred_full_name
            xml.url     path_to_url('')

            xml.currencies do
              xml.currency id: 'RUR', rate: '1'
            end

            xml.categories do
              (Spree::Taxon.published.where(export_to_yandex_market: true) - [Spree::Taxon.root])
                .each do |taxon|
                  xml.category id: taxon.id, parentId: taxon.parent_id do
                    xml.text taxon.name
                  end
                end
            end

            xml.offers do
              get_products.find_each do |product|
                offer(xml, product, product.taxons.first)
              end
            end
          end
        end
      end.to_xml

    end

    private

    def offer_simple(xml, product, cat)
      product_properties = {}
      product.product_properties.map {|x| product_properties[x.property_name] = x.value }
      opt = { id: product.sku,  available: product.available?, cbid: CBID }
      xml.offer(opt) do
        shared_xml(xml, product, cat)
        individual_xml(xml, product, cat, product_properties)
      end
    end

    def individual_xml(xml, product, cat, product_properties)
      I18n.with_locale(:ru) do
        xml.delivery            true
        xml.name                "#{product.name}, #{product.displayed_volume}"
        xml.vendor              product.manufacturer.try(:name)
        xml.vendorCode          product_properties[@config.preferred_vendor_code] if product_properties[@config.preferred_country_of_manufacturer].present?
        xml.description         product.description if product.description.present?
      end
    end

    def get_product_url(product)
      product_url(product, host: @host)
    end
  end
end
