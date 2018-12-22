# Echo Server

This is a simple echo server meant for proxy debugging.
It echos all headers, path params, and query params as yaml.


# Docker Usage

    # build the docker image
    docker build . -t echo-server:latest

    # run the container
    docker run -it -p 8000:8000 echo-server:latest

    # make a test request
    curl -H 'any: header' 'http://localhost:8000/any/path?any=query' 

# Kubernetes Setup

    # start a temporary local docker registry
    docker run -d -p 5000:5000 --name registry registry:2

    # tag and push the image
    docker tag echo-server:latest localhost:5000/echo-server:latest
    docker push localhost:5000/echo-server:latest

    # create the deployment
    kubectl create deployment echo-server --image=localhost:5000/echo-server:latest

    # expose the service
    kubectl expose deployment echo-server --type=LoadBalancer --port 8000 --target-port 8000

    # make a test request
    curl -H 'any: header' 'http://localhost:8000/any/path?any=query'

# Kubernetes Cleanup  

    # delete the service
    kubectl delete service echo-server

    # delete the deployment
    kubectl delete deployment echo-server

    # stop and delete the docker registry
    docker container stop registry && docker container rm -v registry


# Example output

    $ curl -H 'any: header' 'http://localhost:8000/any/path?any=query'
    ---
    accept:
    - "*/*"
    addr:
    - AF_INET
    - 8000
    - 172.17.0.2
    - 172.17.0.2
    attributes: {}
    cookies: []
    form_data:
    forwarded_for:
    forwarded_host:
    forwarded_port:
    forwarded_proto:
    forwarded_server:
    header:
    host:
    - localhost:8000
    user-agent:
    - curl/7.62.0
    accept:
    - "*/*"
    any:
    - header
    host: localhost
    keep_alive:
    path: "/any/path"
    path_info: "/any/path"
    port: 8000
    query:
    query_string: any=query
    raw_header:
    - "Host: localhost:8000\r\n"
    - "User-Agent: curl/7.62.0\r\n"
    - "Accept: */*\r\n"
    - "any: header\r\n"
    request_line: "GET /any/path?any=query HTTP/1.1\r\n"
    request_method: GET
    user:
    body:

