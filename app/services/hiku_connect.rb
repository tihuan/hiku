require 'pry'

class HikuConnect
  attr_reader :endpoint, :uri, :app_id, :secret, :time, :sig

  def initialize(args={})
    @endpoint = args[:endpoint]
    @uri = URI.parse(endpoint)
    @app_id = ENV['APP_ID']
    @secret = ENV['SECRET']
    @time = Time.now.getutc.strftime("%F %T.%6N")
    @sig = Digest::SHA256.hexdigest(app_id+secret+time)
  end
end

class Get < HikuConnect
  attr_reader :response, :token

  def initialize(args={})
    super
    @token = args[:token]
    params = {
        app_id: app_id,
        time: time,
        sig: sig,
        token: token
        # email: 'alex@hiku.us',
        # password: 'codehiku'
    }

    req = Net::HTTP::Get.new(uri.path)
    # req = Net::HTTP::Post.new(uri.path)
    req.body = URI.encode_www_form(params)
    req["Content-Type"] = "application/x-www-form-urlencoded"
    # p req.body

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.ssl_version = :SSLv3
    @response = http.start {|htt| htt.request(req) }
  end
end

class Post < HikuConnect
  attr_reader :response

  def initialize(endpoint)
    super
    post_params = {
        app_id: app_id,
        time: time,
        sig: sig,
        token: "9604d9a375315cb55d471cf11ff31584",
        email: 'alex@hiku.us',
        password: 'codehiku'
    }

    req = Net::HTTP::Post.new(uri.path)
    req.body = URI.encode_www_form(post_params)
    req["Content-Type"] = "application/x-www-form-urlencoded"

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.ssl_version = :SSLv3
    @response = http.start {|htt| htt.request(req) }
  end
end

# class HikuPatch < Hiku
# end

# class HikuDelete < Hiku
# end

# pry.binding


# class Hiku

#   def initialize
#     @app_id = ENV['APP_ID']
#     @secret = ENV['SECRET']
#     @time = Time.now.getutc.strftime("%F %T.%6N")
#   end

#   app_id = ENV['APP_ID']
#   secret = ENV['SECRET']
#   time = Time.now.getutc.strftime("%F %T.%6N")

#   post_params = {
#       app_id: 'e2a01662323845bf5b289b90f4c67dbae982d65247f235',
#       time: time,
#       sig: Digest::SHA256.hexdigest(app_id+secret+time),
#       token: "d029e237120cc7ac205dc457e6f4f689"
#       # email: 'alex@hiku.us',
#       # password: 'codehiku'
#   }

#   req = Net::HTTP::Get.new(uri.path)
#   # req = Net::HTTP::Post.new(uri.path)
#   req.body = URI.encode_www_form(post_params)
#   req["Content-Type"] = "application/x-www-form-urlencoded"
#   p req.body

#   http = Net::HTTP.new(uri.host, uri.port)
#   http.use_ssl = true
#   http.ssl_version = :SSLv3
#   response = http.start {|htt| htt.request(req) }
# end
