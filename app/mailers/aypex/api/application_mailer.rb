module Aypex
  module Api
    class ApplicationMailer < ActionMailer::Base
      default from: "from@example.com"
      layout "mailer"
    end
  end
end
