#  Call Recording top level retrieval service

# Dependencies on the other methods in this folder. Need to be changed when migrated to the EC2 instance to reflect the correct filepath
require '/mnt/c/Users/stephen.heath/Ruby/incontactapi/contactscompleted.rb'
require '/mnt/c/Users/stephen.heath/Ruby/incontactapi/getfiles.rb'

require 'base64'
download_array = []

#Currently this value is hardcoded. TO DO: Change this to pull calls for prior day.
contacts_hash = getCompletedContacts('2018-02-27', '2018-02-28')

#This parses through each contact to see if it was logged or not. If it's logged, add it to the list to be downloaded.
contacts_hash["completedContacts"].each do |i|
	if i["isLogged"] == true
	download_array << i["contactId"]
	end
  end

  #This is just for testing in IRB to confirm that the services have run correctly and gathered the necessary information into my download list
  puts download_array
 