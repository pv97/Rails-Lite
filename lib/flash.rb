require 'json'

class Flash
  attr_reader :now

  def initialize(req)
    old = req.cookies["_rails_lite_app_flash"]
    @now = old.nil? ? {} : JSON.parse(old)
    @flash = {}
  end

  def [](value)
    @now[value.to_s] || @flash[value.to_s]
  end

  def []=(key,value)
    @flash[key.to_s] = value
    @now[key.to_s] = value
  end

  def store_flash(res)
    flash = {path:'/', value: @flash.to_json}
    res.set_cookie("_rails_lite_app_flash",flash)
  end
end
