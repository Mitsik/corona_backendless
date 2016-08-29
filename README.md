# Corona Backendless

My Corona SDK client for [Backendless](https://backendless.com/) . It is under development. It just covers my needs. Feel free to make it better.

I use [lua-promises](https://github.com/zserge/lua-promises) lib. 

Example:
```lua
--register new user
local user = {email="email@yourdomain.com",password="password"}
backendless.UserServices.register(user):next(onUserRegisterSuccess, onUserRegisterError)
```
