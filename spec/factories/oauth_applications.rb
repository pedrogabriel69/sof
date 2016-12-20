FactoryGirl.define do
  factory :oauth_application, class: Doorkeeper::Application do
    name 'Test'
    redirect_uri 'urn:ietf:wg:oauth:2.0:oob'
    secret '123456789'
    uid '123456'
  end
end
