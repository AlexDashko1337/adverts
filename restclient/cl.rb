require 'rest-client'
require 'json'
require 'jwt'
SERVER = 'http://127.0.0.1:3000'

#def get_token
#  response = RestClient::Request.execute(method: :get, url: SERVER + '/users/get_token')
#  puts response
#end

$token = nil

#USERS
def new_user (username, email, password)
  response = RestClient::Request.execute(method: :post, url: SERVER + '/users', payload: { "user": {
																						  "username": username,
																						  "email": email,
																						  "password": password
																									}
		 																			     })
  puts response
end

def login (email, password)
  response = RestClient::Request.execute(method: :post, url: SERVER + '/users/sign_in', payload:{ "user": {
       																						"email": email,
        																					"password": password
    																	  								}
																							  })
  puts response	
  parsed = JSON.parse(response)
  $token = parsed.values
end

def logout
  response = RestClient::Request.execute(method: :delete, url: SERVER + "/users/sign_out",
                                         headers: {:authorization => "Bearer #{$token}"}
  										)
  puts response
end

def show_user id
  response = RestClient::Request.execute(method: :get, url: SERVER + "/users/#{id}",
                                         headers: {:authorization => "Bearer #{@token}"}
  										)
  puts response
end

def update_user (id, email, password)
  response = RestClient::Request.execute(method: :patch, url: SERVER + "/users/#{id}", payload: { "user": {
																						  "username": username,
																						  "email": email,
																						  "password": password
																										  }
		 																			     		},
                                         headers: {:authorization => "Bearer #{@token}"},

  )
  puts response
end

def delete_user id
  response = RestClient::Request.execute(method: :delete,
                                         url: SERVER + "/users/#{id}",
                                         headers: {:authorization => "Bearer #{@token}"}
  )
  puts response
end

#ADVERTS
