#  Call Recording top level retrieval service

# Dependencies on the other methods in this folder. 
require '/home/ubuntu/Ruby/incontactapi/contactscompleted.rb'
require '/home/ubuntu/Ruby/incontactapi/getfiles.rb'

require 'base64'
download_array = []

# This creates the two variables used to pass in yesterday and todays date. This kinda feels like a hack, particularly yesterday.
today = Time.now.strftime('%Y-%m-%d')
yesterday = Time.now - 86400
yesterday = yesterday.strftime('%Y-%m-%d')


#Get the list of contacts for yesterday and today
contacts_hash = getCompletedContacts(yesterday, today)

#This parses through each contact to see if it was logged or not. If it's logged, add it to the list to be downloaded.
contacts_hash["completedContacts"].each do |i|
    if i["isLogged"] == true
      download_array << i["contactId"]
    end
   
  end
  
  #Get the first file from the array. Currently this value is hardcoded. TO DO: Change this to a loop that pulls all the data for the entire array
 # encoded_data_hash = getFile(download_array[0])
 # encoded_data = encoded_data_hash["files"]["file"]
  
  #Write the file to the server
 # File.open("calltest.wav", "w+") {|f| f.write(Base64.decode64(encoded_data)) }
  
  #This is just for testing in IRB to confirm that the services have run correctly and gathered the necessary information into my download list
  puts download_array
 
