
require '/mnt/c/Users/stephen.heath/Ruby/incontactapi/rubyincontacttoken.rb'


def getFile(contactid)

	token = getToken()
  # Check that the token is a valid token.
  unless !(token["access_token"] == nil && 
           token["resource_server_base_uri"] == nil)
    raise ArgumentError, "the function didn't receive a token it could understand"
  end
  
  # Pull the access token and base URL from the response body.
  accessToken = token["access_token"]
  baseURL = token["resource_server_base_uri"]
  
  
	filepath = contactid/10000
	filepath = filepath*10000
	fileName = "CallLog/#{filepath}/#{contactid}.wav"
 
 
  apiURL = "/services/V10.0/files?fileName=#{fileName}"
  uri = URI.parse(baseURL + apiURL)
 
  # Create the GET request headers.
  headers = 
    { "accept-encoding" => "identity",
	  "Accept" => "application/json, text/javascript, */*; q=0.01",
      "Authorization" => "bearer #{accessToken}",
      "Content-Type" => "application/x-www-form-urlencoded",
      "Data-Type" => "json" }
 
  # Set up an HTTP object.
  http = Net::HTTP.new uri.host, uri.port
 
  # Make the GET request an HTTPS GET request.
  http.use_ssl = true
 
 
  # Make the request and store the response.
  response = http.request_get(uri.to_s, headers)
 
  # The data the API returns is in JSON, so parse it if it's valid.
  data = if response.body != ""
      JSON.parse(response.body)
    else
      "The response was empty."
  end
  puts response.body
 puts apiURL
  # Now you can do something with the data the API returned.
end
