module VectorSimilarity
  # Returns cosine similarity in [0, 1] where 1 = identical direction.
  # Accepts Ruby arrays of Numeric (Integer or Float).
  def cosine_similarity(vec_a, vec_b)
    return 0.0 unless vec_a.is_a?(Array) && vec_b.is_a?(Array)
    return 0.0 if vec_a.empty? || vec_b.empty?

    dot     = vec_a.zip(vec_b).sum { |a, b| a.to_f * b.to_f }
    mag_a   = Math.sqrt(vec_a.sum  { |a| a.to_f**2 })
    mag_b   = Math.sqrt(vec_b.sum  { |b| b.to_f**2 })
    return 0.0 if mag_a.zero? || mag_b.zero?

    (dot / (mag_a * mag_b)).clamp(0.0, 1.0)
  end

  # Scores a collection of ActiveRecord objects by cosine similarity against
  # a query_vector. Returns records sorted descending by similarity, limited
  # to `limit`. Records without a valid embedding are silently skipped.
  #
  #   scored = vector_search(Candidate.all, :profile_embedding, query_vec, limit: 10)
  #   # => [{ record: <Candidate>, similarity: 0.93 }, ...]
  def vector_search(scope, embedding_column, query_vector, limit: 10)
    return [] unless query_vector.is_a?(Array) && query_vector.any?

    records = scope.where.not(embedding_column => nil)

    scored = records.filter_map do |record|
      vec = record.public_send(embedding_column)
      next unless vec.is_a?(Array) && vec.length == query_vector.length

      { record: record, similarity: cosine_similarity(query_vector, vec) }
    end

    scored.sort_by { |s| -s[:similarity] }.first(limit)
  end
end
