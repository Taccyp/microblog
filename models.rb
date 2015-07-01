class User  < ActiveRecord::Base
  has_one :profile
  has_many :blogs
end

class Profile < ActiveRecord::Base
  belongs_to :User
end

class Blog < ActiveRecord::Base
  belongs_to :User
end



  

end 
