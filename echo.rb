require 'webrick'
require 'yaml'

port = ENV.fetch("ECHO_SERVER_PORT", "8000")

class Server < WEBrick::HTTPServlet::AbstractServlet

  def echo_request (request, response)

    response.status = 200
    response['Content-Type'] = 'text/plain'

    result = Hash.new("")
    result['accept'] = request.accept
    result['addr'] = request.addr
    result['attributes'] = request.attributes
    result['cookies'] = request.cookies

    result['form_data'] = if request.respond_to? :form_data= then request.form_data end
    result['forwarded_for'] = if request.respond_to? :forwarded_for= then request.forwarded_for end
    result['forwarded_host'] = if request.respond_to? :forwarded_host= then request.forwarded_host end
    result['forwarded_port'] = if request.respond_to? :forwarded_port= then request.forwarded_port end
    result['forwarded_proto'] = if request.respond_to? :forwarded_proto= then request.forwarded_proto end
    result['forwarded_server'] = if request.respond_to? :forwarded_server= then request.forwarded_server end
    result['forwarded_server'] = if request.respond_to? :http_version= then request.http_version end
    result['forwarded_server'] = if request.respond_to? :keep_alive= then request.keep_alive end


    result['header'] = request.header
    result['host'] = request.host

    result['keep_alive'] = if request.respond_to? :keep_alive= then request.keep_alive end

    result['path'] = request.path
    result['path_info'] = request.path_info
    result['port'] = request.port

    result['query'] = if request.respond_to? :query= then request.query end
    result['query_string'] = if request.respond_to? :query_string= then request.query_string end

    result['raw_header'] = request.raw_header
    result['request_line'] = request.request_line
    result['request_method'] = request.request_method

    result['user'] = request.user

    result['body'] = request.body

    response.body = result.to_yaml
    puts response.body
  end

  def do_GET (request, response)
    echo_request(request, response)
  end

  def do_POST (request, response)
    echo_request(request, response)
  end

  def do_PUT (request, response)
    echo_request(request, response)
  end

  def do_DELETE (request, response)
    echo_request(request, response)
  end

  def do_OPTIONS (request, response)
    echo_request(request, response)
  end

  def do_HEAD (request, response)
    echo_request(request, response)
  end

end

server = WEBrick::HTTPServer.new(:Port => port)

server.mount "/", Server

trap("INT") {
    server.shutdown
}

server.start

