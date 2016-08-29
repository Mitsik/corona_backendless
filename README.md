# Corona Backendless

My Corona SDK client for [Backendless](https://backendless.com/) . It is under development. It just covers my needs. Feel free to make it better.

I use [lua-promises](https://github.com/zserge/lua-promises) lib. 

User registration:
```lua
--register new user
local user = {email="email@yourdomain.com",password="password"}
backendless.UserServices.register(user):next(onUserRegisterSuccess, onUserRegisterError)
```

Data storage:
```lua
--find all posts
local postStorage = backendless.Persistence.of({name="Post"})
postStorage.find():next(onSuccess, onError)

--find last post 
postStorage.findLast():next(onSuccess, onError)
```


