module Api
  module V1
    module Sourcing
      class CandidatesController < ApplicationController
        before_action :require_sourcer!

        def index
          candidates = Candidate.includes(:candidate_skills, :work_experiences, :educations, :certifications)
                                .order(created_at: :desc)
                                .page(params[:page] || 1)
                                .per(params[:per_page] || 20)

          render_success({
            candidates: candidates.map { |c| candidate_summary(c) },
            total: candidates.total_count,
            page: candidates.current_page,
            per_page: candidates.limit_value
          })
        end

        def show
          candidate = Candidate.includes(:candidate_skills, { work_experiences: :work_projects }, :educations, :certifications)
                               .find(params[:id])
          render_success(candidate_detail(candidate))
        rescue ActiveRecord::RecordNotFound
          render_error("Candidate not found", status: :not_found)
        end

        def search
          job_id = params[:job_description_id]
          limit = (params[:limit] || 10).to_i

          if job_id.present?
            job = current_user.job_descriptions.find(job_id)
          elsif params[:text].present?
            job = current_user.job_descriptions.create!(
              raw_text: params[:text],
              status: "pending"
            )
            JobDescriptionParserService.new.parse(job)
            job.reload
          else
            return render_error("Provide either job_description_id or text", status: :bad_request)
          end

          return render_error("Job description not ready", status: :unprocessable_entity) unless job.status == "completed"

          matcher = CandidateMatchingService.new
          results = matcher.search(job, limit: limit)

          render_success({
            job_description: {
              id: job.id,
              title: job.title,
              company_name: job.company_name,
              required_skills: job.required_skills
            },
            total_found: results.size,
            candidates: results.map { |r| match_result(r) }
          })
        rescue ActiveRecord::RecordNotFound
          render_error("Job description not found", status: :not_found)
        end

        private

        def candidate_summary(c)
          primary_skills = c.candidate_skills.select { |s| s.skill_type == "Primary" }.map(&:name)
          {
            id: c.id,
            full_name: c.full_name,
            current_title: c.current_title,
            location: [c.city, c.country].compact.join(", "),
            primary_skills: primary_skills.first(5),
            total_skills: c.candidate_skills.size,
            years_experience: calculate_total_years(c),
            has_embedding: c.profile_embedding.present?
          }
        end

        def candidate_detail(c)
          {
            id: c.id,
            full_name: c.full_name,
            first_name: c.first_name,
            last_name: c.last_name,
            email: c.email,
            phone: c.phone,
            address: c.address,
            city: c.city,
            state: c.state,
            country: c.country,
            current_title: c.current_title,
            about_me: c.about_me,
            linkedin_url: c.linkedin_url,
            github_url: c.github_url,
            portfolio_url: c.portfolio_url,
            skills: c.candidate_skills.map { |s|
              { name: s.name, category: s.category, proficiency: s.proficiency,
                years_of_exp: s.years_of_exp, skill_type: s.skill_type,
                year_last_used: s.year_last_used }
            },
            work_experiences: c.work_experiences.order(start_date: :desc).map { |w|
              { company_name: w.company_name, job_title: w.job_title,
                work_status: w.work_status, employment_type: w.employment_type,
                location: w.location, description: w.description,
                start_date: w.start_date, end_date: w.end_date,
                projects: w.work_projects.map { |p|
                  { project_name: p.project_name, description: p.description,
                    skills_used: p.skills_used, start_date: p.start_date, end_date: p.end_date }
                } }
            },
            educations: c.educations.order(start_date: :desc).map { |e|
              { school_name: e.school_name, degree_obtained: e.degree_obtained,
                field_of_study: e.field_of_study, start_date: e.start_date, end_date: e.end_date }
            },
            certifications: c.certifications.map { |cert|
              { certificate_name: cert.certificate_name, issuing_org: cert.issuing_org,
                issue_date: cert.issue_date, expiry_date: cert.expiry_date }
            }
          }
        end

        def match_result(r)
          c = r[:candidate]
          {
            candidate: candidate_summary(c),
            scores: {
              overall: (r[:overall_score] * 100).round(1),
              similarity: (r[:similarity_score] * 100).round(1),
              skill_match: (r[:skill_match_score] * 100).round(1),
              experience_match: (r[:experience_match_score] * 100).round(1)
            },
            rank: r[:rank],
            matched_skills: r[:matched_skills],
            missing_skills: r[:missing_skills],
            ai_reasoning: r[:ai_reasoning]
          }
        end

        def calculate_total_years(c)
          total_months = c.work_experiences.sum { |w|
            start_m = w.start_date ? (w.start_date.year * 12 + w.start_date.month) : 0
            end_m = w.end_date ? (w.end_date.year * 12 + w.end_date.month) : (Date.today.year * 12 + Date.today.month)
            [end_m - start_m, 0].max
          }
          (total_months / 12.0).round(1)
        end
      end
    end
  end
end
