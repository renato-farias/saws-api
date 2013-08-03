def aws_module(service,action,params)

  aws_user = $config['general']['aws_user']
  api_proto = $config[service]['api_proto']
  api_endpoint = $config[service]['api_endpoint']
  parameters = {
    'SignatureMethod' => 'HmacSHA256',
    'Action' => action,
    'AWSAccessKeyId' => $config['general']['aws_user'],
    'SignatureVersion' => 2,
    'Timestamp' => Time.now.gmtime.strftime("%Y-%m-%dT%H:%M:%S"),
    'Version' =>  $config[service]['api_version']
  }

  params.each do |key, value|
    parameters[key] = value
  end

  sorted_params = parameters.sort {|x,y| x[0] <=> y[0]}
  encoded_params = sorted_params.collect do |p|
    encoded = (CGI::escape(p[0].to_s) +
    "=" + CGI::escape(p[1].to_s))
    encoded.gsub('+', '%20')
  end
    
  params_string = encoded_params.join("&")

  req_desc =
    "GET" + "\n" +
    api_endpoint + "\n" +
    "/" + "\n" +
    params_string

  def generate_signature(request_query, digest='sha1')
    digest_generator = OpenSSL::Digest::Digest.new(digest)
    digest = OpenSSL::HMAC.digest(digest_generator, $config['general']['aws_pass'], request_query)
    b64_sig = CGI::escape(Base64.encode64(digest).chomp)
    return b64_sig
  end

  signature = generate_signature(req_desc, 'sha256')

  uri = URI("#{api_proto}://#{api_endpoint}/?#{params_string}&Signature=#{signature}")

  request = Net::HTTP.get_response(uri)

  return request.body
end