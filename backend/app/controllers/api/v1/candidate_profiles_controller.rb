module Api
  module V1
    class CandidateProfilesController < ApplicationController
      before_action :require_candidate!

      def show
        candidate = current_candidate
        render_success(candidate_data(candidate))
      end

      def update
        candidate = current_candidate
        if candidate.update(candidate_params)
          render_success(candidate_data(candidate))
        else
          render_error("Update failed", errors: candidate.errors.full_messages)
        end
      end

      private

      def candidate_params
        params.require(:candidate).permit(
          :first_name, :last_name, :middle_name, :email, :phone,
          :address, :city, :state, :country, :postal_code,
          :current_title, :about_me, :linkedin_url, :github_url, :portfolio_url
        )
      end

      def candidate_data(c)
        {
          id: c.id,
          first_name: c.first_name,
          last_name: c.last_name,
          middle_name: c.middle_name,
          full_name: c.full_name,
          email: c.email,
          phone: c.phone,
          address: c.address,
          city: c.city,
          state: c.state,
          country: c.country,
          postal_code: c.postal_code,
          current_title: c.current_title,
          about_me: c.about_me,
          linkedin_url: c.linkedin_url,
          github_url: c.github_url,
          portfolio_url: c.portfolio_url,
          resume_url: c.resume_url,
          skills: c.candidate_skills.map { |s| skill_data(s) },
          work_experiences: c.work_experiences.order(start_date: :desc).map { |w| work_exp_data(w) },
          educations: c.educations.order(start_date: :desc).map { |e| education_data(e) },
          certifications: c.certifications.map { |cert| cert_data(cert) }
        }
      end

      def skill_data(s)
        { id: s.id, name: s.name, category: s.category, proficiency: s.proficiency,
          years_of_exp: s.years_of_exp, years_of_exp_in_months: s.years_of_exp_in_months,
          skill_type: s.skill_type, year_last_used: s.year_last_used,
          certification: s.certification, delivered_projects: s.delivered_projects }
      end

      def work_exp_data(w)
        { id: w.id, company_name: w.company_name, job_title: w.job_title,
          work_status: w.work_status, employment_type: w.employment_type,
          location: w.location, location_type: w.location_type,
          description: w.description, start_date: w.start_date, end_date: w.end_date,
          projects: w.work_projects.map { |p| project_data(p) } }
      end

      def project_data(p)
        { id: p.id, project_name: p.project_name, project_status: p.project_status,
          description: p.description, skills_used: p.skills_used,
          start_date: p.start_date, end_date: p.end_date }
      end

      def education_data(e)
        { id: e.id, school_name: e.school_name, degree_obtained: e.degree_obtained,
          field_of_study: e.field_of_study, start_date: e.start_date, end_date: e.end_date,
          still_studying: e.still_studying, description: e.description }
      end

      def cert_data(c)
        { id: c.id, certificate_name: c.certificate_name, issuing_org: c.issuing_org,
          issue_date: c.issue_date, expiry_date: c.expiry_date, skills_covered: c.skills_covered }
      end
    end
  end
end
