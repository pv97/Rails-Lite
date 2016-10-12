require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    old = req.cookies["_rails_lite_app"]
    @cookie = old.nil? ? {} : JSON.parse(old)
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
    @cookie[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    hash = {path:'/', value: @cookie.to_json}
    res.set_cookie("_rails_lite_app",hash)
  end
end
