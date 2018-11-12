class Member < ApplicationRecord
  belongs_to :family

  def santa
    Member.find(santa_id) if santa_id
  end

  def self.draw_santas
    member_to_santa_mapping = {}

    Member.all.each do |member|
      # archiving before a new santa is assigned
      member.archive_santa
      member_to_santa_mapping[member.id] = random_santa_for(member.id)
    end

    member_to_santa_mapping.each do |member_id, santa_id|
      # additional guard to make sure everybody gets a santa
      santa_id = Member.where.not(id: member_id).sample.id if santa_id.nil?
      Member.find(member_id).update(santa_id: santa_id)
    end
  end

  def self.random_santa_for(member_id)
    # finding the last three santas' names and excluding them from the randomization
    member = Member.find(member_id)
    if member.previous_santas != {}
      # the narrowing down will more precise and accurate once switched to just years
      names = member.previous_santas.to_a.last(3).flatten.compact.sort.last(3)
    end
    Member.where.not(id: member_id, family_id: member.family_id, name: names).sample.id
  end

  def archive_santa
    # because we cannot wait for 1 year for testing purposes, the timestamp is
    # being used instead of a year
    previous_santas[updated_at] = santa.try(:name)
    save
  end
end
