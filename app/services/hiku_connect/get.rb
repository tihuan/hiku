class HikuConnect::Get
  attr_reader :response

  def initialize(args={})
    super
    req = Net::HTTP::Get.new(uri.path)
    req["Content-Type"] = "application/x-www-form-urlencoded"
    req.body = URI.encode_www_form(params)

    @response = http.start {|htt| htt.request(req) }
  end
end
