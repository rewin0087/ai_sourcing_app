module Api
  module V1
    module Sourcing
      class CvMatchesController < ApplicationController
        before_action :require_sourcer!

        MAX_FILE_SIZE = 10.megabytes
        MIN_TEXT_LENGTH = 50

        def create
          jd_text = extract_text(file: params[:jd_file], text: params[:jd_text], label: "Job description")
          cv_text = extract_text(file: params[:cv_file], text: params[:cv_text], label: "CV")

          result = CvMatchService.new.match(jd_text: jd_text, cv_text: cv_text)

          if result[:success]
            render_success(result.except(:success))
          else
            render_error(result[:error])
          end
        rescue ArgumentError => e
          render_error(e.message, status: :unprocessable_entity)
        end

        private

        def extract_text(file:, text:, label:)
          content =
            if file.present?
              read_upload(file, label)
            else
              text.to_s
            end

          content = content.to_s.strip
          raise ArgumentError, "#{label} is required. Paste text or upload a PDF/TXT file." if content.blank?
          if content.length < MIN_TEXT_LENGTH
            raise ArgumentError, "#{label} is too short to analyse. Please provide more detail."
          end

          content
        end

        def read_upload(file, label)
          unless file.original_filename.to_s.match?(/\.(pdf|txt|md)$/i)
            raise ArgumentError, "#{label}: unsupported file type. Please upload a PDF or text file."
          end
          raise ArgumentError, "#{label}: file too large. Maximum size is 10MB." if file.size > MAX_FILE_SIZE

          tmp_path = Rails.root.join("tmp", "uploads", "#{SecureRandom.hex(8)}#{File.extname(file.original_filename).downcase}")
          FileUtils.mkdir_p(File.dirname(tmp_path))
          File.binwrite(tmp_path, file.read)

          begin
            text = JobDescriptionParserService.extract_text_from_file(tmp_path.to_s).to_s
            text = text.encode("UTF-8", invalid: :replace, undef: :replace, replace: " ")
            if text.strip.blank?
              raise ArgumentError, "#{label}: no readable text found in the file. Scanned PDFs are not supported — please paste the text instead."
            end
            text
          rescue PDF::Reader::MalformedPDFError, PDF::Reader::UnsupportedFeatureError
            raise ArgumentError, "#{label}: the PDF could not be read. Please paste the text instead."
          ensure
            File.delete(tmp_path) if File.exist?(tmp_path)
          end
        end
      end
    end
  end
end
