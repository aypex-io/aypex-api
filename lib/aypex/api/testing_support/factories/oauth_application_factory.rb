FactoryBot.define do
  factory :oauth_application, class: Aypex::OauthApplication do
    name { "Admin Panel" }
    scopes { "admin" }
  end
end
