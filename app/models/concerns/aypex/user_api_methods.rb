module Aypex
  module UserApiMethods
    extend ActiveSupport::Concern

    include Aypex::UserApiAuthentication
  end
end
