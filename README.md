# TalentHub – AI-Powered Professional Sourcing Platform

## Architecture

```
souring_app/
├── backend/    # Ruby on Rails 7.2 API-only
└── frontend/   # Next.js 16 + Shadcn UI + Tailwind
```

## Tech Stack

| Layer | Tech |
|-------|------|
| Backend API | Ruby on Rails 7.2 (API mode) |
| Frontend | Next.js 16, TypeScript, Tailwind CSS, Shadcn UI |
| Database | PostgreSQL + pgvector (vector similarity search) |
| AI | FuelIX API (OpenAI-compatible chat completions) |
| Auth | Devise + devise-jwt (Bearer token) |
| PDF Parsing | pdf-reader gem |

## Setup

### Prerequisites
- Ruby 3.3+, Rails 7.2
- Node.js 22+
- PostgreSQL with pgvector extension

### Backend

```bash
cd backend
bundle install
cp .env.template .env   # fill in FUELIX_API_KEY and DB credentials
rails db:create db:migrate
rails server -p 3001
```

### Frontend

```bash
cd frontend
npm install
echo 'NEXT_PUBLIC_API_URL=http://localhost:3001' > .env.local
npm run dev
```

## API Routes

### Auth
- `POST /api/v1/auth/login` — Login (returns JWT in Authorization header)
- `POST /api/v1/auth/register` — Register (role: candidate|sourcer)
- `DELETE /api/v1/auth/logout`

### Candidate Portal
- `GET/PATCH /api/v1/candidate_profile` — Personal profile
- `POST /api/v1/resume/upload` — Upload PDF/TXT resume → AI extraction
- `GET/POST/PATCH/DELETE /api/v1/candidate_skills`
- `GET/POST/PATCH/DELETE /api/v1/work_experiences`
- `GET/POST/PATCH/DELETE /api/v1/work_experiences/:id/work_projects`
- `GET/POST/PATCH/DELETE /api/v1/educations`
- `GET/POST/PATCH/DELETE /api/v1/certifications`

### Sourcing (Recruiter)
- `POST /api/v1/sourcing/parse-job` — Upload JD (file or text) → AI parsing
- `POST /api/v1/sourcing/search` — Match candidates to a parsed JD
- `GET /api/v1/sourcing/candidates` — Browse all candidates
- `GET /api/v1/sourcing/candidates/:id` — Full candidate profile
- `GET /api/v1/sourcing/jobs` — List parsed job descriptions
- `POST /api/v1/sourcing/refine-job` — Expand a short narrative into a structured JD
- `POST /api/v1/sourcing/cv-match` — Compare one CV against one JD → AI match score, insights and interview prep (see below)

## AI & Vector Search Flow

### Resume Parsing
1. Upload PDF → extract text with `pdf-reader`
2. Send to FuelIX `/v1/chat/completions` with structured extraction prompt
3. Store parsed data (personal info, skills, experience, education, certifications)
4. Generate 1536-dim embeddings for profile, each work experience, each skill
5. Store embeddings in pgvector columns

### Candidate Matching
Hybrid retrieval combined with **Reciprocal Rank Fusion (RRF)** (`CandidateMatchingService`):

1. Upload JD (PDF or text) → FuelIX extracts structured requirements and a JD embedding is generated
2. **Retrieve** — three independent retrievers each produce a ranked list (top 50):
   - **Semantic** — cosine similarity between the JD and candidate profile embeddings
   - **Keyword** — Postgres full-text search over candidate skills (highest weight), job titles, experience/project descriptions and bio, using the JD's skills and title
   - **Skill coverage** — share of required (80%) and preferred (20%) skills the candidate has, with normalised names (`Node.js` = `NodeJS`)
3. **Fuse** — RRF score = Σ 1 / (60 + rank) across the lists; the top 20 are kept. Ranks are combined instead of raw scores, so retrievers on different scales contribute fairly, and search still works when embeddings are missing
4. **RAG** — the top 5 fused candidates go to FuelIX for reasoning and a fit score; the AI's ordering is fused in as a fourth ranked list
5. **Rank** — results are sorted by the final RRF score. Each result includes `rrf_score` and `retrieval_ranks` (its position in each list), shown on the search page as "Ranked by"

The displayed overall % is the AI fit score for AI-reviewed candidates, and an estimate from skill, experience and similarity scores for the rest.

### CV ↔ Job Match
A recruiter page at `/sourcer/match` (**CV Match** in the sidebar) that compares a single CV against a single job description.

**Input** — `POST /api/v1/sourcing/cv-match` (multipart). For each side, send either text or a file:

| Field | Type | Notes |
|-------|------|-------|
| `jd_text` / `jd_file` | text / PDF, TXT, MD | Job description |
| `cv_text` / `cv_file` | text / PDF, TXT, MD | Candidate CV |

Files are limited to 10MB, and scanned (image-only) PDFs are rejected because they contain no extractable text. Nothing is saved to the database.

**How it works** (`CvMatchService`)
1. Extract text from uploads with `pdf-reader`
2. Run two FuelIX calls **in parallel** (one combined response is too long to finish within the 240s timeout for real CVs):
   - **Match analysis** — per-category scores with rationale, skill-by-skill evidence (matched / partial / missing), strengths, gaps, improvements, and screening questions
   - **Interview prep** — focus areas, coding challenges with progressive hints, algorithms to revise, theory questions, and applied/system-design scenarios, weighted towards the CV's gaps. Coding and algorithms are omitted for non-technical roles
3. Compute the overall score in Ruby as a weighted average: skills 40%, experience 30%, responsibilities 20%, education 10%
4. Map the score to a level: excellent (85+), strong (70–84), moderate (50–69), weak (<50)

If the interview prep call fails, the match result is still returned with an `interview_prep_error` message. A full analysis typically takes 1–2 minutes.

## Database Schema (key tables)

- `users` — auth (email, password, role: candidate|sourcer|admin, jti for JWT revocation)
- `candidates` — personal info + `profile_embedding vector(1536)`
- `candidate_skills` — skill details + `embedding vector(1536)`
- `work_experiences` — employment history + `embedding vector(1536)`
- `work_projects` — projects within each work experience
- `educations` — academic history
- `certifications` — professional certifications
- `job_descriptions` — parsed JDs + `embedding vector(1536)`, required_skills (jsonb)
- `candidate_job_matches` — match results with scores and AI reasoning

## Environment Variables

### Backend (.env)
```
FUELIX_API_KEY=your_key_here
FUELIX_API_URL=https://api.fuelix.ai
JWT_SECRET_KEY=your_secret_here
DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=
DB_PASSWORD=
FRONTEND_URL=http://localhost:3000
```

### Frontend (.env.local)
```
NEXT_PUBLIC_API_URL=http://localhost:3001
```
