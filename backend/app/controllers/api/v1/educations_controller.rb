module Api
  module V1
    class EducationsController < ApplicationController
      before_action :require_candidate!
      before_action :set_education, only: [:update, :destroy]

      def index
        edus = current_candidate.educations.order(start_date: :desc)
        render_success(edus.map { |e| edu_data(e) })
      end

      def create
        edu = current_candidate.educations.new(edu_params)
        if edu.save
          render_success(edu_data(edu), status: :created)
        else
          render_error("Failed to create education", errors: edu.errors.full_messages)
        end
      end

      def update
        if @edu.update(edu_params)
          render_success(edu_data(@edu))
        else
          render_error("Failed to update education", errors: @edu.errors.full_messages)
        end
      end

      def destroy
        @edu.destroy
        render_success({ message: "Education removed." })
      end

      private

      def set_education
        @edu = current_candidate.educations.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render_error("Education not found", status: :not_found)
      end

      def edu_params
        params.require(:education).permit(
          :school_name, :degree_obtained, :field_of_study,
          :start_date, :end_date, :still_studying, :description
        )
      end

      def edu_data(e)
        { id: e.id, school_name: e.school_name, degree_obtained: e.degree_obtained,
          field_of_study: e.field_of_study, start_date: e.start_date, end_date: e.end_date,
          still_studying: e.still_studying, description: e.description }
      end
    end
  end
end
