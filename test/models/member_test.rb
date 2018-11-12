require 'test_helper'
require 'pry'

class MemberTest < ActiveSupport::TestCase

  def setup
    Member.create!(name: 'John')
    Member.create!(name: 'Kate')
    Member.create!(name: 'Michael')
    Member.create!(name: 'Jessica')
  end

  # test 'created members do not have santas' do
  #   Member.all.each do |member|
  #     assert_not member.santa_id
  #   end
  # end
  #
  # test 'drawing santas will assign santas for each member' do
  #   Member.draw_santas
  #
  #   Member.all.each do |member|
  #     refute_equal member.id, member.santa_id
  #     assert member.santa_id
  #   end
  # end
  #
  # test 'santas are archived before new assignment' do
  #   Member.draw_santas
  #   Member.draw_santas
  #
  #   Member.all.each do |member|
  #     refute_equal member.previous_santas, {}
  #   end
  # end

  test 'santas are for three years' do
    Member.draw_santas
    year_1_data = { Member.first.id => Member.first.santa_id }

    Member.draw_santas
    year_2_data = { Member.first.id => Member.first.santa_id }

    Member.draw_santas
    year_3_data = { Member.first.id => Member.first.santa_id }

    refute_equal year_1_data, year_2_data
    refute_equal year_2_data, year_3_data
  end
end
