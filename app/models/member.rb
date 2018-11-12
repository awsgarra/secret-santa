class Member < ApplicationRecord
  def santa
    Member.find(santa_id) if santa_id
  end

  def self.draw_santas
    member_to_santa_mapping = {}

    Member.all.each do |member|
      member_to_santa_mapping[member.id] = Member.where.not(id: member.id).sample.id
    end

    member_to_santa_mapping.each do |k, v|
      v = Member.where.not(id: k).sample.id if v.nil?
      Member.find(k).update(santa_id: v)
    end
  end
end
