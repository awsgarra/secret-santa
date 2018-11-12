class SecretSanta < ApplicationRecord
  belongs_to :member
  belongs_to :chosen_member, class_name: 'member'
end
