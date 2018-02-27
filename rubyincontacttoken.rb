
require 'net/https'
require 'uri'
require 'json'
require 'yaml'

def getToken()
user = YAML.load_file('/mnt/c/Users/stephen.heath/Ruby/user.yml')
auth_key = "Q2xheXRvbkFQUEBDbGF5dG9uVmVuZG9yOjUy"

uri = URI("https://api.incontact.com/InContactAuthorizationServer/Token")

	#In the headers, accept-encoding must be set or else you will receive a Zlib Data Error
	#Contact type must be set or else you will get back an empty response body
  headers = 
    { 
	  "accept-encoding" => "identity",
	  "Authorization"=> "basic #{auth_key}",
	  "Content-Type" => "application/json"
	 	}

   # This is the request body that defines the request type and passes in my credentials. 
   json_body = {

			grant_type: 'password',
			username: user["user_name"],
			password: user["user_pass"],
			scope: ''
		}.to_json
	
			
  # Set up an HTTP object.
  http = Net::HTTP.new(uri.host, uri.port)
  # The token service requires a POST and net/https requires that you make that into its own object
  request = Net::HTTP::Post.new(uri.path, headers)
  request.body = json_body
 
  # The service requires that you use SSL and gives you a redirect if you do not
  http.use_ssl = true


  response = http.request(request)
  puts response.body
  token = JSON.parse(response.body)

 end
 
 getToken()
 

 