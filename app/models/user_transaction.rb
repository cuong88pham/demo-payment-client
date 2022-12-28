class UserTransaction < ApplicationRecord
  belongs_to :user
  
  enum status: {
    failed: 0,
    pending: 1,
    paid: 2
  }
end
