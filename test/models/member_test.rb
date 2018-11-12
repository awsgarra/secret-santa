require 'test_helper'
require 'pry'

class MemberTest < ActiveSupport::TestCase

  def setup
    family_1 = Family.create!(name: 'Davis')
    family_2 = Family.create!(name: 'Adams')

    Member.create!(name: 'John', family_id: family_1.id)
    Member.create!(name: 'Kate', family_id: family_1.id)
    Member.create!(name: 'Michael', family_id: family_2.id)
    Member.create!(name: 'Jessica', family_id: family_2.id)
  end

  test 'created members do not have santas' do
    Member.all.each do |member|
      assert_not member.santa_id
    end
  end

  test 'drawing santas will assign santas for each member' do
    Member.draw_santas

    Member.all.each do |member|
      refute_equal member.id, member.santa_id
      assert member.santa_id
    end
  end

  test 'santas are archived before new assignment' do
    Member.draw_santas
    Member.draw_santas

    Member.all.each do |member|
      refute_equal member.previous_santas, {}
    end
  end

  test 'santas are unique for three years' do
    Member.draw_santas
    year_1_data = { Member.first.id => Member.first.santa_id }

    Member.draw_santas
    year_2_data = { Member.first.id => Member.first.santa_id }

    Member.draw_santas
    year_3_data = { Member.first.id => Member.first.santa_id }

    refute_equal year_1_data, year_2_data
    refute_equal year_2_data, year_3_data
  end

  test 'santas cannot be a family member' do
    Member.draw_santas

    Member.all.each do |member|
      refute_equal member.family_id, member.santa.family_id
    end
  end
end
