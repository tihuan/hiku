class Item < ActiveRecord::Base

  def self.all_items
    endpoint = 'https://hiku-staging.herokuapp.com/api/v1/list'
    puts response = post_to_endpoint(endpoint).body
    response_json = JSON.parse(response, symbolize_names: true)[:response][:data]
    puts "\n\n Product Order"
    product_order = response_json[:list].to_json
  end

  private


  def self.post_to_endpoint(endpoint)
    uri = URI.parse(endpoint)

    app_id = 'e2a01662323845bf5b289b90f4c67dbae982d65247f235'
    secret = '18f9d67455211c636e'
    time = Time.now.getutc.strftime("%F %T.%6N")

    post_params = {
        app_id: 'e2a01662323845bf5b289b90f4c67dbae982d65247f235',
        time: time,
        sig: Digest::SHA256.hexdigest(app_id+secret+time),
        token: "d029e237120cc7ac205dc457e6f4f689"
        # email: 'alex@hiku.us',
        # password: 'codehiku'
    }

    req = Net::HTTP::Get.new(uri.path)
    # req = Net::HTTP::Post.new(uri.path)
    req.body = URI.encode_www_form(post_params)
    req["Content-Type"] = "application/x-www-form-urlencoded"
    p req.body

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.ssl_version = :SSLv3
    response = http.start {|htt| htt.request(req) }
  end
end
