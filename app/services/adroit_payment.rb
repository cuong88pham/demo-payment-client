
class AdroitPayment < ServiceBase
  attr_reader :currency, :tracking_id,:amount, :sender_address

  def initialize(currency, tracking_id, amount)
    @tracking_id = tracking_id
    @currency = currency
    @amount = amount
  end

  def call
    begin
      data = {
        currency: currency,
        tracking_id: tracking_id,
        amount: amount
      }
      res = token.post("/api/v2/transactions", body: data, headers: {
        "client-id": "waotech19"
      })
      Success(JSON.parse(res.body))
    rescue Exception => e
      msg = "[Generate Address Failed] #{@coin_id} with error(s): #{e}"
      Failure(e)
    end
  end

  private

  def client
    @client ||= OAuth2::Client.new(ENV['API_KEY'], ENV['SECRET_KEY'], site: ENV['PAYMENT_GATEWAY_URL'])
  end

  def token
    @token ||= client.password.get_token(ENV['USERNAME'], ENV['PASSWORD'])
  end
end
