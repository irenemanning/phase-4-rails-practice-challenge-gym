class Membership < ApplicationRecord
    belongs_to :gym 
    belongs_to :client

    validate :one_membership

    #custom Validation
    def one_membership 
        if client.memberships.length > 0
          errors.add(:client_id, "Sorry, only one membership per client.")  
        end
    end 

end
