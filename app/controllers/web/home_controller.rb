module Web
  class HomeController < WebController
    before_action :authenticate_user!, except: [:index, :webhook]
    def index 
      if current_user
        @transactions = current_user.user_transactions
        @balance = @transactions.paid.sum(&:amount)
      end
    end
    
    def deposit 
      @transactions = current_user.user_transactions
      @balance = @transactions.paid.sum(&:amount)
    end

    def webhook 
      data = params["data"]
      tx = UserTransaction.find_by(tracking_id: data["tracking_id"])
      tx.paid! if tx && tx.amount.to_f == data["amount"].to_f 
      render json: {}, status: 200
    end

    def create 
      pending_txs = current_user.user_transactions.pending
      if pending_txs.present?
        @tx = pending_txs.last 
        puts "----PENDING----"
        puts @tx
      else 
        @tx = current_user.user_transactions.new({
          amount: params[:amount],
          status: 'pending',
          tracking_id: "#{SecureRandom.hex}_#{current_user.username}",
          payload: {}
        })
        
        data = AdroitPayment.call('usdt',@tx.tracking_id ,@tx.amount)
        puts data 
        puts @tx
        if data.success? 
          @tx.payload = data.success
          @tx.save
        end
      end
      respond_to do |format|
        format.js
      end
    end
  end
end