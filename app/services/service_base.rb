require 'dry/monads/do'

class ServiceBase
  include Dry::Monads[:maybe, :result, :try, :do]
  # include NotifyHelper

  def self.call(*args)
    service = new(*args)
    service.call
  end

  private

  def transaction
    begin
      ActiveRecord::Base.transaction do
        yield
      end
    rescue Dry::Monads::Do::Halt => e
      e.result
    rescue => e
      Raven.capture_exception(e)
      Failure(error: :error_process, message: 'Unexpected error', stack: e)
    end
  end
end
