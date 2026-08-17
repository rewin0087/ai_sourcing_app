# TalentHub – AI-Powered Professional Sourcing Platform

## Architecture

```
souring_app/
├── backend/    # Ruby on Rails 7.2 API-only
└── frontend/   # Next.js 15 + Shadcn UI + Tailwind
```

## Tech Stack

| Layer | Tech |
|-------|------|
| Backend API | Ruby on Rails 7.2 (API mode) |
| Frontend | Next.js 15, TypeScript, Tailwind CSS, Shadcn UI |
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
cp .env.example .env   # fill in FUELIX_API_KEY and DB credentials
rails db:create db:migrate
rails server -p 3001
```

### Frontend

```bash
cd frontend
npm install
cp .env.local.example .env.local   # set NEXT_PUBLIC_API_URL=http://localhost:3001
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

## AI & Vector Search Flow

### Resume Parsing
1. Upload PDF → extract text with `pdf-reader`
2. Send to FuelIX `/v1/chat/completions` with structured extraction prompt
3. Store parsed data (personal info, skills, experience, education, certifications)
4. Generate 1536-dim embeddings for profile, each work experience, each skill
5. Store embeddings in pgvector columns

### Candidate Matching
1. Upload JD (PDF or text) → FuelIX extracts structured requirements
2. Generate JD embedding
3. **Step 1 – Vector search**: cosine similarity against candidate profile embeddings (top 20)
4. **Step 2 – Skill scoring**: overlap between required skills and candidate skills
5. **Step 3 – RAG**: feed top 5 candidates to FuelIX for deep reasoning and scores
6. **Step 4 – Merge & rank**: combine vector + skill + AI scores → final ranked list

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
