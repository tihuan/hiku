class Item < ActiveRecord::Base

  def self.all_items(get_params)
    endpoint = 'https://hiku-staging.herokuapp.com/api/v1/list'
    get_params = get_params.merge({ endpoint: endpoint })
    puts response = HikuConnect.new(get_params).get.response.body
    response_json = JSON.parse(response, symbolize_names: true)[:response][:data]
    puts "\n\n Product List"
    product_order = response_json[:list].to_json
  end

  def self.create_item(add_params)
    endpoint = 'https://hiku-staging.herokuapp.com/api/v1/list'
    add_params = add_params.reject { |k, _| k == "action" || k == "controller" || k == "item" }
    post_params = { endpoint: endpoint }.merge(add_params).symbolize_keys
    puts response = HikuConnect.new(post_params).post.response.body
    response_json = JSON.parse(response, symbolize_names: true)[:response]
  end

  def self.destroy_items(destroy_params)
    endpoint = 'https://hiku-staging.herokuapp.com/api/v1/list'
    destroy_params = destroy_params.reject { |k, _| k == "action" || k == "controller" }
    delete_params = { endpoint: endpoint }.merge(destroy_params).symbolize_keys
    puts response = HikuConnect.new(delete_params).delete.response.body
    response_json = JSON.parse(response, symbolize_names: true)[:response]
  end
end
