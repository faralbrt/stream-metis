class MwsClient
  def initialize
    @client = MWS::Products::Client.new
  end

  def search(query_string)
    results = @client.list_matching_products(query_string).parse
    products = results["Products"]["Product"] if results["Products"]
    return unless products
    products.map {|product| parse_product(product)}
  end

  private
    def parse_product(product)
      output = {}
      output[:asin] = product["Identifiers"]["MarketplaceASIN"]["ASIN"]
      output[:title] = product["AttributeSets"]["ItemAttributes"]["Title"]
      output[:image] = product["AttributeSets"]["ItemAttributes"]["SmallImage"]["URL"]
      return output unless product["SalesRankings"]
      rankings = product["SalesRankings"]["SalesRank"]
      if rankings.class == Hash
        output[:rankings] = rankings["Rank"]
      else
        output[:rankings] = rankings.first["Rank"]
      end
      return output
    end
end
