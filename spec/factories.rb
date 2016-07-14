FactoryGirl.define do 
  factory :contactmessage do
    name 'Test User'
    email 'testuser@gmail.com'
    message 'test message'
  end

  factory :admin do
    email 'admin@gmail.com'
    password 'secretPassword'
  end

  factory :blogpost do 
    title 'Awesome Post'
    content 'Somestuff'
    category 'Others'
  end
end