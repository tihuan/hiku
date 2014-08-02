class Item < ActiveRecord::Base

  def self.all_items
    endpoint = 'https://hiku-staging.herokuapp.com/api/v1/list'
    post_to_endpoint(endpoint)
    puts response = post_to_endpoint(endpoint).body
    response_json = JSON.parse(response, symbolize_names: true)[:response][:data]
    puts "\n\n Product Order"
    product_order = response_json[:list].to_json
  end

  private
  def self.post_to_endpoint(endpoint)
    HikuConnect::Get.new({endpoint: endpoint, token: '9604d9a375315cb55d471cf11ff31584'}).response
  end
end
