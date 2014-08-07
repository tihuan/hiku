class HikuConnect
  attr_reader :uri, :app_id, :time, :sig,
                     :local_params, :http, :response

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

  def get
    req = Net::HTTP::Get.new(uri.path)
    req["Content-Type"] = "application/x-www-form-urlencoded"
    req.body = URI.encode_www_form(params)

    @response = http.start { |htt| htt.request(req) }
  end
end

# class Get < HikuConnect
#   attr_reader :response

#   def initialize(args={})
#     super
#     req = Net::HTTP::Get.new(uri.path)
#     req["Content-Type"] = "application/x-www-form-urlencoded"
#     req.body = URI.encode_www_form(params)

#     @response = http.start {|htt| htt.request(req) }
#   end
# end

class Post < HikuConnect
  attr_reader :response

  def initialize(args={})
    super
    req = Net::HTTP::Post.new(uri.path)
    req["Content-Type"] = "application/x-www-form-urlencoded"
    puts "\n\n\nPOST REQUEST"
    p req.body = URI.encode_www_form(params)
    puts "AFTER POST REQUEST\n\n\n"
    @response = http.start {|htt| htt.request(req) }
  end
end

# class HikuPatch < Hiku
# end

class Delete < HikuConnect
  attr_reader :response

  def initialize(args={})
    super
    req = Net::HTTP::Delete.new(uri.path)
    req["Content-Type"] = "application/x-www-form-urlencoded"
    delete_params = params.merge({ action: 'clear' })
    # delete_params = params.merge({ action: 'crossOff' })
    req.body = URI.encode_www_form(delete_params)

    @response = http.start {|htt| htt.request(req) }
  end
end
