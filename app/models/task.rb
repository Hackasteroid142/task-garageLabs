class Task < ApplicationRecord

    def completed?
       completed.blank? 
    end

end
