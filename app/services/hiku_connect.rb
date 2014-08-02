require 'pry'

class HikuConnect
  attr_reader :uri, :app_id, :time, :sig,
                     :local_params, :http

  def initialize(args={})
    endpoint = args[:endpoint]
    secret = ENV['SECRET']
    @uri = URI.parse(endpoint)
    @app_id = ENV['APP_ID']
    @time = Time.now.getutc.strftime("%F %T.%6N")
    @sig = Digest::SHA256.hexdigest(app_id+secret+time)
    @local_params = args.reject { |k, _| k == :endpoint }
    @http = setup_http
  end

  def params
    {
      app_id: app_id,
      time: time,
      sig: sig
    }.merge(local_params)
  end

  def setup_http
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.ssl_version = :SSLv3
    return http
  end
end

class Get < HikuConnect
  attr_reader :response

  def initialize(args={})
    super
    req = Net::HTTP::Get.new(uri.path)
    req.body = URI.encode_www_form(params)
    req["Content-Type"] = "application/x-www-form-urlencoded"

    @response = http.start {|htt| htt.request(req) }
  end
end

class Post < HikuConnect
  attr_reader :response

  def initialize(args={})
    super
    req = Net::HTTP::Post.new(uri.path)
    req.body = URI.encode_www_form(params)
    req["Content-Type"] = "application/x-www-form-urlencoded"

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
