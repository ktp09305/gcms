FactoryGirl.define do
  factory :invalid_snippet, class: Gcms::Snippet do
    content "MyText"
    factory :snippet, class: Gcms::Snippet do
      name "Snippet"
      slug "my-snippet"
    end
  end

end
