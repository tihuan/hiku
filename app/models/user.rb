class User < ActiveRecord::Base
  def self.authenticate(login_params)
    endpoint = 'https://hiku-staging.herokuapp.com/api/v1/login'
    login_params = login_params.reject { |k, _| k == "action" || k == "session" }
    delete_params = { endpoint: endpoint }.merge(login_params).symbolize_keys
    puts response = HikuConnect::Post.new(delete_params).response.body
    p response_json = JSON.parse(response, symbolize_names: true)[:response][:data]
  end
end
