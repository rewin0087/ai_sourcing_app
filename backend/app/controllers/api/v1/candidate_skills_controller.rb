module Api
  module V1
    class CandidateSkillsController < ApplicationController
      before_action :require_candidate!
      before_action :set_skill, only: [:update, :destroy]

      def index
        skills = current_candidate.candidate_skills.order(:skill_type, :name)
        render_success(skills.map { |s| skill_data(s) })
      end

      def create
        skill = current_candidate.candidate_skills.new(skill_params)
        if skill.save
          render_success(skill_data(skill), status: :created)
        else
          render_error("Failed to create skill", errors: skill.errors.full_messages)
        end
      end

      def update
        if @skill.update(skill_params)
          render_success(skill_data(@skill))
        else
          render_error("Failed to update skill", errors: @skill.errors.full_messages)
        end
      end

      def destroy
        @skill.destroy
        render_success({ message: "Skill removed." })
      end

      private

      def set_skill
        @skill = current_candidate.candidate_skills.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render_error("Skill not found", status: :not_found)
      end

      def skill_params
        params.require(:candidate_skill).permit(
          :name, :category, :proficiency, :years_of_exp,
          :years_of_exp_in_months, :skill_type, :year_last_used,
          :certification, :delivered_projects
        )
      end

      def skill_data(s)
        { id: s.id, name: s.name, category: s.category, proficiency: s.proficiency,
          years_of_exp: s.years_of_exp, years_of_exp_in_months: s.years_of_exp_in_months,
          skill_type: s.skill_type, year_last_used: s.year_last_used,
          certification: s.certification, delivered_projects: s.delivered_projects }
      end
    end
  end
end
