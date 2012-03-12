class UserAddArea < ActiveRecord::Base
    belongs_to :User
    validate_presence_of :when
    validate_presence_of :uid
end
