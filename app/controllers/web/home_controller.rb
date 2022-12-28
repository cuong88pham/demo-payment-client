module Web
  class HomeController < WebController
    before_action :authenticate_user!
    def index 
      @transactions = current_user.user_transactions
    end
    
    def webhook 
      data = params["data"]
      tx = UserTransaction.find_by(tracking_id: data["tracking_id"])
      tx.paid! if tx && tx.amount.to_f == data["amount"].to_f 
      render json: {}, status: 200
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
        @tx.payload = data.success
        @tx.save
      end
      respond_to do |format|
        format.js
      end
    end
  end
end