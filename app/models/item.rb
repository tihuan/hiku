class Item < ActiveRecord::Base

  def self.all_items
    endpoint = 'https://hiku-staging.herokuapp.com/api/v1/list'
    params = { endpoint: endpoint }
    puts response = get_to_endpoint(params).body
    response_json = JSON.parse(response, symbolize_names: true)[:response][:data]
    puts "\n\n Product List"
    product_order = response_json[:list].to_json
  end

  def self.destroy_items(delete_params)
    endpoint = 'https://hiku-staging.herokuapp.com/api/v1/list'
    delete_params = delete_params.reject { |k, _| k == "action" || k == "controller" }
    params = { endpoint: endpoint }.merge(delete_params).symbolize_keys
    puts response = delete_to_endpoint(params).body
    response_json = JSON.parse(response, symbolize_names: true)[:response][:reponse]
  end

  private
  def self.get_to_endpoint(params)
    HikuConnect::Get.new({
      endpoint: params[:endpoint],
      token: '9604d9a375315cb55d471cf11ff31584'
    }).response
  end

  def self.post_to_endpoint(params)
    HikuConnect::Post.new({
      endpoint: params[:endpoint],
      token: '9604d9a375315cb55d471cf11ff31584'
    }).response
  end

  def self.delete_to_endpoint(params)
    HikuConnect::Delete.new({
      endpoint: params[:endpoint],
      id: params[:id],
      action: 'crossOff',
      token: '9604d9a375315cb55d471cf11ff31584'
    }).response
  end
end
