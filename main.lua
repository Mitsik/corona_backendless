local backendless = require( "libs.backendless" )

backendless.init({
	applicationId="YOUR_APPLICATION_ID",
	secretKey="YOUR_SECRET_KEY",
})


---- CALLBACKS
local function onUserRegisterSuccess( event )
	print("user registered")
end

local function onUserRegisterError( event )
	if (event.code == backendless.Errors.USER_ALREADY_EXISTS )then
		print("user already exists")
	end
end

--register new user
local user = {email="email@yourdomain.com",password="password"}
backendless.UserServices.register(user):next(onUserRegisterSuccess, onUserRegisterError)