module Api
  module V1
    class CertificationsController < ApplicationController
      before_action :require_candidate!
      before_action :set_certification, only: [:update, :destroy]

      def index
        certs = current_candidate.certifications.order(issue_date: :desc)
        render_success(certs.map { |c| cert_data(c) })
      end

      def create
        cert = current_candidate.certifications.new(cert_params)
        if cert.save
          render_success(cert_data(cert), status: :created)
        else
          render_error("Failed to create certification", errors: cert.errors.full_messages)
        end
      end

      def update
        if @cert.update(cert_params)
          render_success(cert_data(@cert))
        else
          render_error("Failed to update certification", errors: @cert.errors.full_messages)
        end
      end

      def destroy
        @cert.destroy
        render_success({ message: "Certification removed." })
      end

      private

      def set_certification
        @cert = current_candidate.certifications.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render_error("Certification not found", status: :not_found)
      end

      def cert_params
        params.require(:certification).permit(
          :certificate_name, :issuing_org, :issue_date, :expiry_date, :skills_covered
        )
      end

      def cert_data(c)
        { id: c.id, certificate_name: c.certificate_name, issuing_org: c.issuing_org,
          issue_date: c.issue_date, expiry_date: c.expiry_date, skills_covered: c.skills_covered }
      end
    end
  end
end
