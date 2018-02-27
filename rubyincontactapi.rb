# Calls the API to retrieve a list of skills assigned to all agents.
#
# * *Arguments* :
#  - +token+ -> a token hash    
#  - +fields+ -> List of elements to return in response
#  - +updatedSince+ -> Returns all Teams updated since ISO 8601 time
#
# * *Returns* :
#   - a list of skills assigned to all agents
#
# * *Raises* :
#   - +ArgumentError+ -> if the token object doesn't have expected fields
#

require 'net/http'
require 'uri'



def getAgentSkills()

#I've hardcoded in an access token as a hack to avoid having to create a token retrieval service, simply so I can get the request/response to work. 
#In order for this to work you need to retrieve a token in some other fashion first (I use postman) and then paste it in here. 
#Eventually this will be replaced with an actual token request process where we pass in a token to this method.
token ={ "access_token" => "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpY0JVSWQiOjUyLCJuYW1lIjoic3RlcGhlbi5oZWF0aEBjOC5jb20iLCJpc3MiOiJodHRwczovL2FwaS5pbmNvbnRhY3QuY29tIiwic3ViIjoidXNlcjo4MTEyNiIsImF1ZCI6IkNsYXl0b25BcHBAQ2xheXRvblZlbmRvciIsImV4cCI6MTUxNzMyOTE5OSwiaWF0IjoxNTE3MzI1NTk5LCJpY1Njb3BlIjoiMSwyLDQsNSw2LDcsOCIsImljQ2x1c3RlcklkIjoiQzgiLCJpY0FnZW50SWQiOjgxMTI2LCJpY1NQSWQiOjE1MjcsIm5iZiI6MTUxNzMyNTU5OX0.F3JD4rTEtQ4YNplYvUP1RCl8rijkv9hScPsUBC031tNUUijlVpLUE1t19TMbB400TMnzNoRPksgyqMv3y6hx8Bi6_tLMb34ymQG1gX7AdXeKrlopJfm_Iwf1zT_R_SyNJAyXrJVuzWqpstNnBWAFl7LgdPRRKwT-Kh-mnk84ls0QWM6Kmo6hcIOxNnyS-tPL1JC5d6BdD5evzz-tQgbrt4xN3szjbkDusmuylG02xYHIImnEkreeaaglXKOPiLA8kxGrOQP_mYxyqXDPO4jbWfzuspVUHjGPRHL7I4OFiMjAScn-_KCk36rzIFE1T_LEEksdby4XphLMk8JdGaRJ3g", "resource_server_base_uri" => "https://api-c8.incontact.com/inContactAPI/"}
  # Check that the token is a valid token.
  # This is only relevant when the token is passed in as an argument and not when it's hardcoded like it is today
  unless !(token["access_token"] == nil && 
           token["resource_server_base_uri"] == nil)
    raise ArgumentError, "the function didn't receive a token it could understand"
  end
  
  # Pull the access token and base URL from the response body.
  accessToken = token["access_token"]
  baseURL = token["resource_server_base_uri"]
  # Create the URL that accesses the API.
  # fields and updatedSince params only available in v5.0 or later
  uri = URI("https://api-c8.incontact.com/inContactAPI/services/v10.0/contacts/active")

  # Create the GET request headers.
  headers = 
    { "Accept" => "application/json, text/javascript, */*; q=0.01",
	  "accept-encoding" => "identity",
      "Authorization" => "bearer #{accessToken}",
      "Content-Type" => "application/json",
      "Data-Type" => "json" }
  # Set up an HTTP object.
  http = Net::HTTP.new uri.host, uri.port
  # Make the GET request an HTTPS GET request.
  http.use_ssl = true

  # Make the request and store the response.
  response = http.request_get(uri.path, headers)
    
  # The data the API returns is in JSON, so parse it if it's valid.

puts response.body
puts response.code
  data = if response.body != ""
      JSON.parse(response.body)
    else
      "The response was empty."
  end
  # Now you can do something with the data the API returned.
end
