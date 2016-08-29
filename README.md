# Corona Backendless

My Corona SDK client for [Backendless](https://backendless.com/) . It is under development. It just covers my needs. Feel free to make it better.

I use [lua-promises](https://github.com/zserge/lua-promises) lib. 

Initialization:
```lua
local backendless = require( "backendless" )

backendless.init({
	applicationId="YOUR_APPLICATION_ID",
	secretKey="YOUR_SECRET_KEY",
})
```

User registration:
```lua
--register new user
local user = {email="email@yourdomain.com",password="password"}
backendless.UserServices.register(user):next(onUserRegisterSuccess, onUserRegisterError)
```

User login:
```lua
local function onUserLoginSuccess( event )
    backendless.USER_TOKEN = event["user-token"]
end

local function onUserLoginFailed( event )
    errorLabel:setText(event.message)
    if (event.code == backendless.Errors.INVALID_LOGIN_OR_PASSWORD) then
      
    end
end

local user = {email="email@yourdomain.com",password="password"}
backendless.UserServices.login(user):next(onUserLoginSuccess, onUserLoginFailed)
```


Data storage:
```lua
--find all posts
local postStorage = backendless.Persistence.of({name="Post"})
postStorage.find():next(onSuccess, onError)

--find last post 
postStorage.findLast():next(onSuccess, onError)
```


