local json = require( "json" )
local deffered = require( "deferred" )


local SERVER_URL = "https://api.backendless.com/v1/"
local APPLICATION_ID = ""
local SECRET_KEY = ""

local Backendless = {}

Backendless.Errors = {
	USER_ALREADY_EXISTS 		= 3033,
	INVALID_LOGIN_OR_PASSWORD 	= 3003,
}




local function doRequest( url, method, params )
	local d = deffered.new()
	local headers = {}
	headers["application-id"] = APPLICATION_ID
	headers["secret-key"] = SECRET_KEY
	headers["Content-Type"] = "application/json"
	headers["application-type"] = "REST"

	if (Backendless.USER_TOKEN) then
		headers["user-token"] = Backendless.USER_TOKEN		
	end

	local body = ""
	if (params) then
		body = json.encode( params )
	end

	local requestParams = {}
	requestParams.headers = headers
	requestParams.body = body 

	local function listener( event )
		if (event.isError) then
			d:reject(event)
		else
			local data = json.decode( event.response )
			if (tonumber(event.status) > 300) then
				d:reject(data)
			else
				d:resolve(data)
			end
		end
	end

	network.request( SERVER_URL .. url, method, listener, requestParams )
	return d
end

function Backendless.init( params )

	APPLICATION_ID	= params.applicationId
	SECRET_KEY 		= params.secretKey

end

--------------------------------------------
--
---- Backendless Data Query
--
--------------------------------------------
Backendless.DataQuery = function( ... )
	local query = {
		properties = {},
		condition = "",
		options = ""
	}

	return query
end

--------------------------------------------
--
---- Backendless Persistence
--
--------------------------------------------
Backendless.Persistence = {}

local function createInstance( class )
	local instance = {}

	function instance.find( dataQuery )
		return doRequest("data/"..class.name, "GET", dataQuery)
	end

	function instance.findFirst( ... )
		return doRequest("data/"..class.name .. "/first", "GET")
	end

	function instance.findLast( ... )
		return doRequest("data/"..class.name .. "/last", "GET")
	end

	function instance.findById( objectId )
		return doRequest("data/"..class.name .. "/" .. (objectId or ""), "GET")
	end

	function instance.save( object )
		return doRequest("data/"..class.name, "POST", object)
	end

	return instance
end


Backendless.Persistence.of = function( class )
	local instance = createInstance( class )

	return instance
end


--------------------------------------------
--
---- Backendless UserServices
--
--------------------------------------------
Backendless.UserServices = {}

Backendless.UserServices.register = function( user )
	return doRequest("users/register", "POST", user)
end

Backendless.UserServices.login = function( user )
	return doRequest("users/login", "POST", user)
end

Backendless.UserServices.logout = function( )
	return doRequest("users/logout", "GET")
end

Backendless.UserServices.loginWithFacebookSDK = function( data )
	return doRequest("users/social/facebook/sdk/login", "POST", data)
end

Backendless.UserServices.update = function( user )
	return doRequest("users/" .. user.id, "PUT", user)
end

return Backendless