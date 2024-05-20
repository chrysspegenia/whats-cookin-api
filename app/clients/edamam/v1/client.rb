class Edamam::V1::Client

  BASE_URL = 'https://api.edamam.com'
  APP_ID = "d67966a5"
  APP_KEY = "cb2f903846b30a6bd706dda9c82efca1"
  TYPE = "public"

  def recipes(**params)
    request(
        method: :get,
        endpoint: "api/recipes/v2",
        params: params
    )
  end

  def recipe(**params)
    request(
        method: :get,
        endpoint: "api/recipes/v2/#{id}",
        params: params
    )
  end

  private

  def request(method:, endpoint:, params: {}, headers: {}, body: {})
    response = connection.public_send(method, "#{endpoint}") do |request|
      request.params = { app_id: APP_ID, app_key: APP_KEY , type: TYPE}.merge(params)
      request.headers = headers   if headers.present?
      request.body = body.to_json if body.present?
    end

    return response.body if response.success?
    # return JSON.parse(response.body).with_indifferent_access if response.success?
    # raise ERROR_CODES[response.status]
    raise "#{response.status}: #{response.body}" 
  end

  def connection
    @connection ||= Faraday.new(url: BASE_URL)
  end
end