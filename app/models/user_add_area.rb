class UserAddArea < ActiveRecord::Base
    belongs_to :user
    validate_presence_of :when
    validate_presence_of :uid
end
