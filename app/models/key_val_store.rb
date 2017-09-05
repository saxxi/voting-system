# Usage example:
#   KeyValStore.save :campaigns, 'mycampaign', '3321'
#   KeyValStore.get :campaigns, 'mycampaign'
class KeyValStore

  def self.save(key, code, id)
    $redis.hset key, code, id
  end

  def self.get(key, code)
    $redis.hget key, code
  end

end
