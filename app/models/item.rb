class Item < ActiveRecord::Base

  def self.all_items(get_params)
    endpoint = 'https://hiku-staging.herokuapp.com/api/v1/list'
    get_params = get_params.merge({ endpoint: endpoint })
    puts response = HikuConnect::Get.new(get_params).response.body
    response_json = JSON.parse(response, symbolize_names: true)[:response][:data]
    puts "\n\n Product List"
    product_order = response_json[:list].to_json
  end

  def self.create_item(add_params)
    endpoint = 'https://hiku-staging.herokuapp.com/api/v1/list'
    add_params = add_params.reject { |k, _| k == "action" || k == "controller" || k == "item" }
    post_params = { endpoint: endpoint }.merge(add_params).symbolize_keys
    puts response = HikuConnect::Post.new(post_params).response.body
    response_json = JSON.parse(response, symbolize_names: true)[:response]
  end

  def self.destroy_items(destroy_params)
    endpoint = 'https://hiku-staging.herokuapp.com/api/v1/list'
    destroy_params = destroy_params.reject { |k, _| k == "action" || k == "controller" }
    delete_params = { endpoint: endpoint }.merge(destroy_params).symbolize_keys
    puts response = HikuConnect::Delete.new(delete_params).response.body
    response_json = JSON.parse(response, symbolize_names: true)[:response]
  end
end
