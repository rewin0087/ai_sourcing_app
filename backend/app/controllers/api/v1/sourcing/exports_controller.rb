module Api
  module V1
    module Sourcing
      class ExportsController < ApplicationController
        # No JWT auth — download links are opened directly by the browser.
        # Security is provided by the cryptographically signed, short-lived token.
        skip_before_action :authenticate_user!, raise: false

        def csv
          token = params[:token].to_s.strip
          return render_error("Missing token.", :bad_request) if token.blank?

          result = CandidateAnalyticsService.generate_csv_from_token(token)
          return render_error("Export link has expired or is invalid.", :not_found) if result.nil?

          send_data result[:csv],
            type:        "text/csv; charset=utf-8",
            disposition: "attachment",
            filename:    result[:filename]
        rescue StandardError => e
          Rails.logger.error("[ExportsController] CSV generation failed: #{e.message}")
          render_error("Failed to generate export: #{e.message}", :internal_server_error)
        end

        private

        def render_error(message, status)
          render json: { error: message }, status: status
        end
      end
    end
  end
end
