module Api
  module V1
    class WorkExperiencesController < ApplicationController
      before_action :require_candidate!
      before_action :set_experience, only: [:update, :destroy]

      def index
        exps = current_candidate.work_experiences
                                .includes(:work_projects)
                                .order(start_date: :desc)
        render_success(exps.map { |w| exp_data(w) })
      end

      def create
        exp = current_candidate.work_experiences.new(exp_params)
        if exp.save
          render_success(exp_data(exp), status: :created)
        else
          render_error("Failed to create experience", errors: exp.errors.full_messages)
        end
      end

      def update
        if @exp.update(exp_params)
          render_success(exp_data(@exp))
        else
          render_error("Failed to update experience", errors: @exp.errors.full_messages)
        end
      end

      def destroy
        @exp.destroy
        render_success({ message: "Work experience removed." })
      end

      private

      def set_experience
        @exp = current_candidate.work_experiences.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render_error("Work experience not found", status: :not_found)
      end

      def exp_params
        params.require(:work_experience).permit(
          :company_name, :job_title, :work_status, :employment_type,
          :location, :location_type, :description, :start_date, :end_date
        )
      end

      def exp_data(w)
        { id: w.id, company_name: w.company_name, job_title: w.job_title,
          work_status: w.work_status, employment_type: w.employment_type,
          location: w.location, location_type: w.location_type,
          description: w.description, start_date: w.start_date, end_date: w.end_date,
          projects: w.work_projects.map { |p|
            { id: p.id, project_name: p.project_name, project_status: p.project_status,
              description: p.description, skills_used: p.skills_used,
              start_date: p.start_date, end_date: p.end_date }
          } }
      end
    end
  end
end
