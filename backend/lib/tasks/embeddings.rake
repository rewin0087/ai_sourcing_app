# frozen_string_literal: true

namespace :embeddings do
  desc "Generate vector embeddings for all candidates that are missing them"
  task generate_all: :environment do
    service = EmbeddingService.new
    candidates = Candidate.where(profile_embedding: nil)

    if candidates.none?
      puts "All candidates already have embeddings. Use embeddings:regenerate_all to force refresh."
      next
    end

    puts "Generating embeddings for #{candidates.count} candidate(s)...\n\n"

    candidates.each do |candidate|
      print "  [#{candidate.id}] #{candidate.full_name}... "
      service.generate_for_candidate(candidate)
      puts "done"
    rescue => e
      puts "ERROR: #{e.message}"
    end

    puts "\nFinished. #{Candidate.where.not(profile_embedding: nil).count}/#{Candidate.count} candidates now have embeddings."
  end

  desc "Regenerate vector embeddings for all candidates (including those already embedded)"
  task regenerate_all: :environment do
    service = EmbeddingService.new
    candidates = Candidate.all

    puts "Regenerating embeddings for #{candidates.count} candidate(s)...\n\n"

    candidates.each do |candidate|
      print "  [#{candidate.id}] #{candidate.full_name}... "
      service.generate_for_candidate(candidate)
      puts "done"
    rescue => e
      puts "ERROR: #{e.message}"
    end

    puts "\nFinished."
  end

  desc "Generate embeddings for a single candidate by ID (usage: rails 'embeddings:generate_for[42]')"
  task :generate_for, [:candidate_id] => :environment do |_, args|
    raise ArgumentError, "Usage: rails 'embeddings:generate_for[<candidate_id>]'" unless args[:candidate_id]

    candidate = Candidate.find(args[:candidate_id])
    service   = EmbeddingService.new

    puts "Generating embeddings for [#{candidate.id}] #{candidate.full_name}..."
    service.generate_for_candidate(candidate)
    puts "Done."
  end
end
