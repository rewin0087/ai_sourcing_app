class EmbeddingService
  def initialize
    @ai = FuelixService.new
  end

  def generate_for_candidate(candidate)
    candidate.reload

    # Generate overall profile embedding
    profile_text = candidate.embedding_text
    profile_vec = @ai.embed(profile_text)
    candidate.update_column(:profile_embedding, profile_vec)

    # Generate per-experience embeddings
    candidate.work_experiences.each do |exp|
      vec = @ai.embed(exp.embedding_text)
      exp.update_column(:embedding, vec)
    end

    # Generate per-skill embeddings
    candidate.candidate_skills.each do |skill|
      vec = @ai.embed(skill.embedding_text)
      skill.update_column(:embedding, vec)
    end
  end

  def generate_for_job(job_description)
    vec = @ai.embed(job_description.embedding_text)
    job_description.update_column(:embedding, vec)
  end
end
