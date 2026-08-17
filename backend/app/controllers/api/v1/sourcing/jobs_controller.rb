module Api
  module V1
    module Sourcing
      class JobsController < ApplicationController
        before_action :require_sourcer!
        before_action :set_job, only: [:show, :destroy]

        def index
          jobs = current_user.job_descriptions.order(created_at: :desc)
          render_success(jobs.map { |j| job_summary(j) })
        end

        def show
          render_success(job_detail(@job))
        end

        def parse
          text = extract_text_from_request
          return render_error("No job description text provided", status: :bad_request) if text.blank?

          job = current_user.job_descriptions.create!(
            raw_text: text,
            status: "pending"
          )

          result = JobDescriptionParserService.new.parse(job)

          if result[:success]
            render_success(job_detail(job.reload), status: :created)
          else
            render_error(result[:error])
          end
        end

        def refine
          narrative = params[:narrative] || params[:text]
          if narrative.blank?
            begin
              body = JSON.parse(request.body.read)
              narrative = body["narrative"] || body["text"]
            rescue StandardError
              nil
            end
          end

          return render_error("No narrative provided", status: :bad_request) if narrative.blank?

          result = JobDescriptionRefinerService.new.refine(narrative)

          if result[:success]
            render_success(result.except(:success))
          else
            render_error(result[:error])
          end
        end

        def destroy
          @job.destroy
          render_success({ message: "Job description deleted." })
        end

        private

        def set_job
          @job = current_user.job_descriptions.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render_error("Job not found", status: :not_found)
        end

        def extract_text_from_request
          if params[:file].present?
            file = params[:file]
            tmp_path = Rails.root.join("tmp", "uploads", "#{SecureRandom.hex(8)}_#{file.original_filename}")
            FileUtils.mkdir_p(File.dirname(tmp_path))
            File.binwrite(tmp_path, file.read)
            text = JobDescriptionParserService.extract_text_from_file(tmp_path.to_s)
            File.delete(tmp_path)
            text
          elsif params[:text].present?
            params[:text]
          elsif request.body.read.present?
            request.body.rewind
            body = JSON.parse(request.body.read) rescue {}
            body["text"]
          end
        rescue StandardError => e
          nil
        end

        def job_summary(j)
          { id: j.id, title: j.title, company_name: j.company_name,
            location: j.location, employment_type: j.employment_type,
            experience_level: j.experience_level, status: j.status,
            required_skills_count: Array(j.required_skills).size,
            created_at: j.created_at }
        end

        def job_detail(j)
          { id: j.id, title: j.title, company_name: j.company_name,
            location: j.location, employment_type: j.employment_type,
            experience_level: j.experience_level, salary_range: j.salary_range,
            summary: j.summary, responsibilities: j.responsibilities,
            qualifications: j.qualifications, about_company: j.about_company,
            required_skills: j.required_skills, preferred_skills: j.preferred_skills,
            status: j.status, raw_text: j.raw_text, created_at: j.created_at }
        end
      end
    end
  end
end
