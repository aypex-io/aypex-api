# Ensure that Aypex::Config.user_class includes the UserApiMethods concern

Aypex::Core::Engine.config.to_prepare do
  if Aypex::Config.user_class && !Aypex::Config.user_class.included_modules.include?(Aypex::UserApiMethods)
    Aypex::Config.user_class.include Aypex::UserApiMethods
  end
end
