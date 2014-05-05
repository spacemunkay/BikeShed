module ApiTestHelpers
  def api_submit_json(user, json_hash)
    json_hash.merge({username: user.username, password: user.password})
  end
end
