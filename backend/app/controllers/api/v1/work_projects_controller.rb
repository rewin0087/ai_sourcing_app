module Api
  module V1
    class WorkProjectsController < ApplicationController
      before_action :require_candidate!
      before_action :set_experience
      before_action :set_project, only: [:update, :destroy]

      def index
        render_success(@exp.work_projects.map { |p| project_data(p) })
      end

      def create
        proj = @exp.work_projects.new(project_params)
        if proj.save
          render_success(project_data(proj), status: :created)
        else
          render_error("Failed to create project", errors: proj.errors.full_messages)
        end
      end

      def update
        if @proj.update(project_params)
          render_success(project_data(@proj))
        else
          render_error("Failed to update project", errors: @proj.errors.full_messages)
        end
      end

      def destroy
        @proj.destroy
        render_success({ message: "Project removed." })
      end

      private

      def set_experience
        @exp = current_candidate.work_experiences.find(params[:work_experience_id])
      rescue ActiveRecord::RecordNotFound
        render_error("Work experience not found", status: :not_found)
      end

      def set_project
        @proj = @exp.work_projects.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render_error("Project not found", status: :not_found)
      end

      def project_params
        params.require(:work_project).permit(
          :project_name, :project_status, :description, :skills_used, :start_date, :end_date
        )
      end

      def project_data(p)
        { id: p.id, project_name: p.project_name, project_status: p.project_status,
          description: p.description, skills_used: p.skills_used,
          start_date: p.start_date, end_date: p.end_date }
      end
    end
  end
end
