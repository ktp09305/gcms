FactoryGirl.define do
  factory :user, class: Gcms::User do
    email "admin@example.com"
    password "password"
    password_confirmation "password"
  end
end
