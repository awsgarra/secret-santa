class Member < ApplicationRecord
  has_one :santa, class_name: 'Member', foreign_key: :member_id
end
