module Api
  module V1
    class ResumesController < ApplicationController
      before_action :require_candidate!

      def upload
        unless params[:file].present?
          return render_error("No file provided", status: :bad_request)
        end

        file = params[:file]
        allowed_types = %w[application/pdf text/plain]
        unless allowed_types.include?(file.content_type) || file.original_filename.match?(/\.(pdf|txt|md)$/i)
          return render_error("Unsupported file type. Please upload a PDF or text file.", status: :unprocessable_entity)
        end

        if file.size > 10.megabytes
          return render_error("File too large. Maximum size is 10MB.", status: :unprocessable_entity)
        end

        candidate = current_candidate

        # Save file temporarily
        tmp_path = Rails.root.join("tmp", "uploads", "#{SecureRandom.hex(8)}_#{file.original_filename}")
        FileUtils.mkdir_p(File.dirname(tmp_path))
        File.binwrite(tmp_path, file.read)

        begin
          result = ResumeParserService.new.parse(candidate, file_path: tmp_path.to_s)

          if result[:success]
            render_success({
              message: "Resume parsed and profile updated successfully.",
              candidate: {
                id: candidate.id,
                full_name: candidate.full_name,
                current_title: candidate.current_title,
                skills_count: candidate.candidate_skills.count,
                experiences_count: candidate.work_experiences.count
              }
            })
          else
            render_error(result[:error])
          end
        ensure
          File.delete(tmp_path) if File.exist?(tmp_path)
        end
      end

      def status
        candidate = current_candidate
        render_success({
          has_resume: candidate.resume_url.present?,
          skills_count: candidate.candidate_skills.count,
          experiences_count: candidate.work_experiences.count,
          educations_count: candidate.educations.count,
          certifications_count: candidate.certifications.count,
          has_embedding: candidate.profile_embedding.present?
        })
      end
    end
  end
end
