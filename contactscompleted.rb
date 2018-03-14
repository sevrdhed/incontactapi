# This method returns a list of contacts in between the dates supplied.

# This dependancy is the service that creates the token 
require '/mnt/c/Users/stephen.heath/Ruby/incontactapi/rubyincontacttoken.rb'


def getCompletedContacts(startDate, endDate)
  # Check that the token is a valid token.
  token = getToken()
  unless !(token["access_token"] == nil && 
           token["resource_server_base_uri"] == nil)
    raise ArgumentError, "the function didn't receive a token it could understand"
  end
  
  # Pull the access token and base URL from the response body.
  accessToken = token["access_token"]
  baseURL = token["resource_server_base_uri"]
  
  # Create the URL that accesses the API.

  apiURL = "services/V10.0/contacts/completed?startDate=#{startDate}"\
            "&endDate=#{endDate}"
  uri = URI.parse(baseURL + apiURL)
 
  # The accept encoding => identity is required in the headers to prevent a Zlibdata error. 
  headers = 
    { "accept-encoding" => "identity",
	  "Accept" => "application/json, text/javascript, */*; q=0.01",
      "Authorization" => "bearer #{accessToken}",
      "Content-Type" => "application/x-www-form-urlencoded",
      "Data-Type" => "json" }
 
  # Set up an HTTP object and convert it to HTTPS
  http = Net::HTTP.new uri.host, uri.port
  http.use_ssl = true
 
  response = http.request_get(uri.to_s, headers)
 
  data = if response.body != ""
      JSON.parse(response.body)
    else
       "The response was empty."
  end
  #Pass back the data. If you receive an error regarding being unable to convert type Nil to String that means the response body was empty
return data

end
