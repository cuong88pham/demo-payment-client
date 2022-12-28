module Web
  class HomeController < WebController
    before_action :authenticate_user!
    def index 
      @transactions = current_user.user_transactions
    end
    
    def create 
      @tx = current_user.user_transactions.create({
        amount: params[:amount],
        status: 'pending',
        sender_address: params[:sender_address].downcase,
        tracking_id: SecureRandom.hex,
        payload: {}
      })
      if @tx 
        data = AdroitPayment.call('usdt',@tx.tracking_id ,@tx.amount, @tx.sender_address)
        @tx.payload = JSON.parse(data.body)
        @tx.save
      end
      respond_to do |format|
        format.js
      end
    end
  end
end