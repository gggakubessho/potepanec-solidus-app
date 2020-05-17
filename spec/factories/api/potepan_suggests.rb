FactoryBot.define do
  factory :potepan_suggest, class: 'Potepan::PotepanSuggest' do
    sequence(:keyword) { |n| "ruby_#{n}" }
  end
end
