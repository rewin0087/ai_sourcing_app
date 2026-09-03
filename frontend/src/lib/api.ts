import axios from "axios";

const API_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:3001";

export const api = axios.create({
  baseURL: `${API_URL}/api/v1`,
  headers: { "Content-Type": "application/json" },
});

api.interceptors.request.use((config) => {
  if (typeof window !== "undefined") {
    const token = localStorage.getItem("auth_token");
    if (token) config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

api.interceptors.response.use(
  (res) => res,
  (err) => {
    if (err.response?.status === 401 && typeof window !== "undefined") {
      localStorage.removeItem("auth_token");
      localStorage.removeItem("auth_user");
      window.location.href = "/login";
    }
    return Promise.reject(err);
  }
);

export type User = {
  id: number;
  email: string;
  full_name: string;
  role: "candidate" | "sourcer" | "admin";
};

export type Candidate = {
  id: number;
  first_name: string;
  last_name: string;
  middle_name?: string;
  full_name: string;
  email: string;
  phone?: string;
  address?: string;
  city?: string;
  state?: string;
  country?: string;
  current_title?: string;
  about_me?: string;
  linkedin_url?: string;
  github_url?: string;
  portfolio_url?: string;
  resume_url?: string;
  skills: CandidateSkill[];
  work_experiences: WorkExperience[];
  educations: Education[];
  certifications: Certification[];
};

export type CandidateSkill = {
  id: number;
  name: string;
  category: string;
  proficiency: "Beginner" | "Intermediate" | "Advanced";
  years_of_exp: string;
  years_of_exp_in_months: number;
  skill_type: "Primary" | "Secondary" | "Tertiary";
  year_last_used?: number;
  certification: "Yes" | "No";
  delivered_projects: string;
};

export type WorkExperience = {
  id: number;
  company_name: string;
  job_title: string;
  work_status: 0 | 1;
  employment_type: 1 | 2 | 3;
  location?: string;
  location_type: 1 | 2 | 3;
  description?: string;
  start_date: string;
  end_date?: string;
  projects: WorkProject[];
};

export type WorkProject = {
  id: number;
  project_name: string;
  project_status: 0 | 1;
  description?: string;
  skills_used?: string;
  start_date?: string;
  end_date?: string;
};

export type Education = {
  id: number;
  school_name: string;
  degree_obtained?: string;
  field_of_study?: string;
  start_date?: string;
  end_date?: string;
  still_studying: boolean;
  description?: string;
};

export type Certification = {
  id: number;
  certificate_name: string;
  issuing_org?: string;
  issue_date?: string;
  expiry_date?: string;
  skills_covered?: string;
};

export type JobDescription = {
  id: number;
  title?: string;
  company_name?: string;
  location?: string;
  employment_type?: string;
  experience_level?: string;
  salary_range?: string;
  summary?: string;
  responsibilities?: string;
  qualifications?: string;
  about_company?: string;
  required_skills: RequiredSkill[];
  preferred_skills: RequiredSkill[];
  status: "pending" | "processing" | "completed" | "failed";
  raw_text: string;
  created_at: string;
};

export type RequiredSkill = {
  name: string;
  proficiency?: string;
  years_required?: number;
  required: boolean;
};

export type MatchResult = {
  candidate: {
    id: number;
    full_name: string;
    current_title?: string;
    location?: string;
    primary_skills: string[];
    total_skills: number;
    years_experience: number;
  };
  scores: {
    overall: number;
    similarity: number;
    skill_match: number;
    experience_match: number;
  };
  rank: number;
  matched_skills: string[];
  missing_skills: string[];
  ai_reasoning?: string;
};

// Auth endpoints
export const authApi = {
  login: (email: string, password: string) =>
    api.post("/auth/login", { user: { email, password } }),
  register: (email: string, password: string, full_name: string, role: string) =>
    api.post("/auth/register", { user: { email, password, password_confirmation: password, full_name, role } }),
  logout: () => api.delete("/auth/logout"),
};

// Candidate endpoints
export const candidateApi = {
  getProfile: () => api.get<{ data: Candidate }>("/candidate_profile"),
  updateProfile: (data: Partial<Candidate>) =>
    api.patch("/candidate_profile", { candidate: data }),
  uploadResume: (file: File) => {
    const form = new FormData();
    form.append("file", file);
    return api.post("/resume/upload", form, {
      headers: { "Content-Type": "multipart/form-data" },
    });
  },
  getSkills: () => api.get("/candidate_skills"),
  createSkill: (data: Partial<CandidateSkill>) =>
    api.post("/candidate_skills", { candidate_skill: data }),
  updateSkill: (id: number, data: Partial<CandidateSkill>) =>
    api.patch(`/candidate_skills/${id}`, { candidate_skill: data }),
  deleteSkill: (id: number) => api.delete(`/candidate_skills/${id}`),
  getWorkExperiences: () => api.get("/work_experiences"),
  createWorkExperience: (data: Partial<WorkExperience>) =>
    api.post("/work_experiences", { work_experience: data }),
  updateWorkExperience: (id: number, data: Partial<WorkExperience>) =>
    api.patch(`/work_experiences/${id}`, { work_experience: data }),
  deleteWorkExperience: (id: number) => api.delete(`/work_experiences/${id}`),
  getEducations: () => api.get("/educations"),
  createEducation: (data: Partial<Education>) =>
    api.post("/educations", { education: data }),
  updateEducation: (id: number, data: Partial<Education>) =>
    api.patch(`/educations/${id}`, { education: data }),
  deleteEducation: (id: number) => api.delete(`/educations/${id}`),
  getCertifications: () => api.get("/certifications"),
  createCertification: (data: Partial<Certification>) =>
    api.post("/certifications", { certification: data }),
  updateCertification: (id: number, data: Partial<Certification>) =>
    api.patch(`/certifications/${id}`, { certification: data }),
  deleteCertification: (id: number) => api.delete(`/certifications/${id}`),
};

// ── Chat types ──────────────────────────────────────────────────────────────

export type ChatCandidateSummary = {
  id: number;
  full_name: string;
  current_title?: string;
  location?: string;
  total_experience_years: number;
  skills: { name: string; proficiency?: string }[];
};

export type ChatStats = {
  type:
    | "database_summary"
    | "experience_report"
    | "role_distribution"
    | "skill_report"
    | "top_skills_by_category";
  data: Record<string, unknown>;
};

export type ChatCsvExport = {
  token: string;
  filename: string;
  download_url: string;
  record_count?: number;
  expires_in: string;
};

export type ChatMessage = {
  id: string;
  role: "user" | "assistant";
  content: string;
  candidates?: ChatCandidateSummary[];
  stats?: ChatStats;
  exports?: ChatCsvExport[];
  timestamp: string;
};

export type ChatSession = {
  id: number;
  title: string;
  message_count: number;
  last_message?: string;
  updated_at: string;
  created_at: string;
};

export type RefinedJobDescription = {
  title: string;
  experience_level: string;
  employment_type: string;
  summary: string;
  responsibilities: string;
  qualifications: string;
  about_company?: string;
  required_skills: RequiredSkill[];
  preferred_skills: RequiredSkill[];
  formatted_text: string;
};

// Sourcing endpoints
export const sourcingApi = {
  refineJob: (narrative: string) =>
    api.post<{ data: RefinedJobDescription }>("/sourcing/refine-job", { narrative }),

  // Chat
  getChatSessions: () =>
    api.get<{ data: ChatSession[] }>("/sourcing/chat/sessions"),
  getChatSession: (id: number) =>
    api.get<{ data: { id: number; title: string; messages: ChatMessage[]; created_at: string } }>(`/sourcing/chat/sessions/${id}`),
  sendChatMessage: (message: string, sessionId?: number) =>
    api.post<{ data: { session_id: number; message: ChatMessage } }>("/sourcing/chat/message", {
      message,
      session_id: sessionId,
    }),
  deleteChatSession: (id: number) => api.delete(`/sourcing/chat/sessions/${id}`),

  parseJob: (text?: string, file?: File) => {
    if (file) {
      const form = new FormData();
      form.append("file", file);
      return api.post("/sourcing/parse-job", form, {
        headers: { "Content-Type": "multipart/form-data" },
      });
    }
    return api.post("/sourcing/parse-job", { text });
  },
  searchCandidates: (params: { job_description_id?: number; text?: string; limit?: number }) =>
    api.post("/sourcing/search", params),
  getJobs: () => api.get("/sourcing/jobs"),
  getJob: (id: number) => api.get(`/sourcing/jobs/${id}`),
  deleteJob: (id: number) => api.delete(`/sourcing/jobs/${id}`),
  getCandidates: (page?: number) =>
    api.get("/sourcing/candidates", { params: { page } }),
  getCandidate: (id: number) => api.get(`/sourcing/candidates/${id}`),
};
