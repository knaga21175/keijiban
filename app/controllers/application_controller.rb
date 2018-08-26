class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    #############################################
    ### digest 認証  STORE_ZONNE
    #############################################
    def store_logged_in
        if Rails.env == 'production'
            authenticate_or_request_with_http_digest("STORE_ZONE") do |name|
                Digest::MD5::hexdigest([ ENV['STORE_ID'], "STORE_ZONE", ENV['STORE_PASS'] ].join(":"))
            end
        end
    end
end
