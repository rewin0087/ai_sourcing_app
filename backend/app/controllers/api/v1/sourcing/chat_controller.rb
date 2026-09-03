module Api
  module V1
    module Sourcing
      class ChatController < ApplicationController
        before_action :require_sourcer!

        # GET /api/v1/sourcing/chat/sessions
        def sessions
          sessions = ChatSession.where(user: current_user).order(updated_at: :desc).limit(50)
          render_success(sessions.map { |s| session_summary(s) })
        end

        # POST /api/v1/sourcing/chat/message
        def message
          user_text = params[:message].to_s.strip
          return render_error("Message cannot be empty", status: :bad_request) if user_text.blank?

          session = find_or_create_session

          # Extract LLM-safe history (role + content only, last 20 turns)
          history = session.messages.last(20).map do |m|
            { "role" => m["role"], "content" => m["content"] }
          end

          # Run the agent
          result = ChatAgentService.new.process(user_text, history)

          # Build message records
          user_msg = build_msg("user", user_text)
          assistant_msg = build_msg("assistant", result[:content],
                                    candidates: result[:candidates],
                                    stats: result[:stats],
                                    exports: result[:exports])

          session.messages = (session.messages + [user_msg, assistant_msg]).last(200)
          session.title = user_text.truncate(60) if session.title.blank?
          session.save!

          render_success({ session_id: session.id, message: assistant_msg })
        rescue ActiveRecord::RecordNotFound
          render_error("Session not found", status: :not_found)
        end

        # GET /api/v1/sourcing/chat/sessions/:id
        def show
          session = ChatSession.find_by!(id: params[:id], user: current_user)
          render_success({
            id: session.id,
            title: session.display_title,
            messages: session.messages,
            created_at: session.created_at
          })
        rescue ActiveRecord::RecordNotFound
          render_error("Session not found", status: :not_found)
        end

        # DELETE /api/v1/sourcing/chat/sessions/:id
        def destroy
          session = ChatSession.find_by(id: params[:id], user: current_user)
          session&.destroy
          render_success({ message: "Conversation deleted." })
        end

        private

        def find_or_create_session
          if params[:session_id].present?
            ChatSession.find_by!(id: params[:session_id], user: current_user)
          else
            ChatSession.create!(user: current_user, messages: [], title: "")
          end
        end

        def build_msg(role, content, candidates: nil, stats: nil, exports: nil)
          {
            "id"         => SecureRandom.uuid,
            "role"       => role,
            "content"    => content,
            "candidates" => candidates,
            "stats"      => stats,
            "exports"    => exports,
            "timestamp"  => Time.current.iso8601
          }.compact
        end

        def session_summary(s)
          last_msg = s.messages.last
          {
            id: s.id,
            title: s.display_title,
            message_count: s.messages.length,
            last_message: last_msg&.dig("content")&.truncate(80),
            updated_at: s.updated_at,
            created_at: s.created_at
          }
        end
      end
    end
  end
end
