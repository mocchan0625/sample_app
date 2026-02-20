require 'net/http'
require 'json'

class SlackService
  def post(webhook_url, message)
    payload = {
      text: "*[カンファレンスお知らせ]* #{message.subject}\n\n#{message.body}"
    }

    uri  = URI.parse(webhook_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')

    request = Net::HTTP::Post.new(uri.request_uri)
    request['Content-Type'] = 'application/json'
    request.body = JSON.generate(payload)

    response = http.request(request)

    unless response.is_a?(Net::HTTPSuccess)
      Rails.logger.error "[SlackService] POST failed: #{webhook_url} -> #{response.code} #{response.body}"
    end

    response
  rescue => e
    Rails.logger.error "[SlackService] Error posting to #{webhook_url}: #{e.message}"
    nil
  end
end
