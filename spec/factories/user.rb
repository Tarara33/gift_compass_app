FactoryBot.define do
  factory :user do
    sequence (:name) {|n| "名前#{n}"}
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { 'password' }
  end
end