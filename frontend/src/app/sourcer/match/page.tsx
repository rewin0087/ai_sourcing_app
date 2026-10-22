"use client";

import { useRef, useState } from "react";
import { toast } from "sonner";
import {
  FileCheck2Icon,
  Loader2Icon,
  CloudUploadIcon,
  FileTextIcon,
  TypeIcon,
  XIcon,
  SparklesIcon,
  CircleCheckIcon,
  CircleXIcon,
  CircleMinusIcon,
  ThumbsUpIcon,
  TriangleAlertIcon,
  LightbulbIcon,
  BriefcaseIcon,
  MessageSquareQuoteIcon,
  RotateCcwIcon,
  PencilIcon,
  ListChecksIcon,
  UserIcon,
  TargetIcon,
  GraduationCapIcon,
  CodeIcon,
  NetworkIcon,
  BookOpenIcon,
  BrainIcon,
  CompassIcon,
  ChevronDownIcon,
  EyeIcon,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { sourcingApi, CvMatchInput, CvMatchResult, CvInterviewPrep } from "@/lib/api";

const MAX_FILE_SIZE = 10 * 1024 * 1024;
const ACCEPTED_EXTENSIONS = /\.(pdf|txt|md)$/i;

type InputMode = "text" | "file";

type DocInput = { mode: InputMode; text: string; file: File | null };

const EMPTY_INPUT: DocInput = { mode: "text", text: "", file: null };

const LEVEL_STYLES: Record<CvMatchResult["match_level"], { label: string; ring: string; text: string; bg: string }> = {
  excellent: { label: "Excellent match", ring: "stroke-emerald-500", text: "text-emerald-700", bg: "bg-emerald-50 border-emerald-200" },
  strong: { label: "Strong match", ring: "stroke-blue-500", text: "text-blue-700", bg: "bg-blue-50 border-blue-200" },
  moderate: { label: "Moderate match", ring: "stroke-amber-500", text: "text-amber-700", bg: "bg-amber-50 border-amber-200" },
  weak: { label: "Weak match", ring: "stroke-red-500", text: "text-red-700", bg: "bg-red-50 border-red-200" },
};

const RECOMMENDATION_STYLES: Record<CvMatchResult["recommendation"], { label: string; className: string }> = {
  strong_yes: { label: "Strongly recommend", className: "bg-emerald-600 text-white border-emerald-600" },
  yes: { label: "Recommend", className: "bg-blue-600 text-white border-blue-600" },
  maybe: { label: "Consider with caution", className: "bg-amber-500 text-white border-amber-500" },
  no: { label: "Not recommended", className: "bg-red-600 text-white border-red-600" },
};

const CATEGORY_LABELS: Record<string, string> = {
  skills: "Skills",
  experience: "Experience",
  responsibilities: "Responsibilities",
  education: "Education & Certs",
};

const PRIORITY_STYLES: Record<string, string> = {
  high: "bg-red-50 text-red-700 border-red-200",
  medium: "bg-amber-50 text-amber-700 border-amber-200",
  low: "bg-slate-50 text-slate-600 border-slate-200",
};

const RELEVANCE_STYLES: Record<string, string> = {
  high: "bg-emerald-50 text-emerald-700 border-emerald-200",
  medium: "bg-blue-50 text-blue-700 border-blue-200",
  low: "bg-slate-50 text-slate-600 border-slate-200",
};

function scoreColor(score: number) {
  if (score >= 85) return "bg-emerald-500";
  if (score >= 70) return "bg-blue-500";
  if (score >= 50) return "bg-amber-500";
  return "bg-red-500";
}

function formatSize(bytes: number) {
  if (bytes < 1024) return `${bytes} B`;
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(0)} KB`;
  return `${(bytes / (1024 * 1024)).toFixed(1)} MB`;
}

function isReady(input: DocInput) {
  return input.mode === "file" ? !!input.file : input.text.trim().length > 0;
}

// ── Input panel ─────────────────────────────────────────────────────────────

function DocumentInput({
  title,
  description,
  placeholder,
  value,
  onChange,
  disabled,
}: {
  title: string;
  description: string;
  placeholder: string;
  value: DocInput;
  onChange: (v: DocInput) => void;
  disabled: boolean;
}) {
  const fileRef = useRef<HTMLInputElement>(null);
  const [dragging, setDragging] = useState(false);

  function acceptFile(file: File | undefined) {
    if (!file) return;
    if (!ACCEPTED_EXTENSIONS.test(file.name)) {
      toast.error("Unsupported file type. Please upload a PDF or TXT file.");
      return;
    }
    if (file.size > MAX_FILE_SIZE) {
      toast.error("File too large. Maximum size is 10MB.");
      return;
    }
    onChange({ ...value, file });
  }

  return (
    <Card className="border-slate-200 bg-white shadow-sm flex flex-col">
      <CardHeader className="pb-3">
        <div className="flex items-start justify-between gap-3">
          <div>
            <CardTitle className="text-slate-800 text-base flex items-center gap-2">
              {title}
              {isReady(value) && <CircleCheckIcon className="w-4 h-4 text-emerald-500" />}
            </CardTitle>
            <p className="text-xs text-slate-500 mt-1">{description}</p>
          </div>
          <div className="inline-flex rounded-lg border border-slate-200 bg-slate-50 p-0.5 flex-shrink-0" role="tablist">
            {(["text", "file"] as InputMode[]).map((mode) => (
              <button
                key={mode}
                role="tab"
                aria-selected={value.mode === mode}
                disabled={disabled}
                onClick={() => onChange({ ...value, mode })}
                className={`flex items-center gap-1.5 px-3 py-1.5 rounded-md text-xs font-medium transition-colors ${
                  value.mode === mode ? "bg-white text-slate-900 shadow-sm" : "text-slate-500 hover:text-slate-700"
                }`}
              >
                {mode === "text" ? <TypeIcon className="w-3.5 h-3.5" /> : <CloudUploadIcon className="w-3.5 h-3.5" />}
                {mode === "text" ? "Paste text" : "Upload file"}
              </button>
            ))}
          </div>
        </div>
      </CardHeader>
      <CardContent className="flex-1">
        {value.mode === "text" ? (
          <div className="space-y-1.5">
            <Textarea
              rows={12}
              value={value.text}
              disabled={disabled}
              onChange={(e) => onChange({ ...value, text: e.target.value })}
              placeholder={placeholder}
              className="border-slate-300 resize-none text-sm h-72"
            />
            <p className="text-xs text-slate-400 text-right">{value.text.length.toLocaleString()} characters</p>
          </div>
        ) : value.file ? (
          <div className="h-72 flex flex-col items-center justify-center gap-4 rounded-lg border border-slate-200 bg-slate-50">
            <div className="flex items-center gap-3 bg-white border border-slate-200 rounded-lg px-4 py-3 shadow-sm max-w-full">
              <div className="w-10 h-10 rounded-lg bg-violet-50 flex items-center justify-center flex-shrink-0">
                <FileTextIcon className="w-5 h-5 text-violet-600" />
              </div>
              <div className="min-w-0">
                <p className="text-sm font-medium text-slate-800 truncate">{value.file.name}</p>
                <p className="text-xs text-slate-400">{formatSize(value.file.size)}</p>
              </div>
              <Button
                variant="ghost"
                size="icon"
                disabled={disabled}
                onClick={() => onChange({ ...value, file: null })}
                className="text-slate-400 hover:text-red-500 flex-shrink-0"
                aria-label="Remove file"
              >
                <XIcon className="w-4 h-4" />
              </Button>
            </div>
            <button
              disabled={disabled}
              onClick={() => fileRef.current?.click()}
              className="text-xs text-violet-600 hover:text-violet-800 underline underline-offset-2"
            >
              Choose a different file
            </button>
          </div>
        ) : (
          <button
            disabled={disabled}
            onClick={() => fileRef.current?.click()}
            onDragOver={(e) => {
              e.preventDefault();
              setDragging(true);
            }}
            onDragLeave={() => setDragging(false)}
            onDrop={(e) => {
              e.preventDefault();
              setDragging(false);
              acceptFile(e.dataTransfer.files?.[0]);
            }}
            className={`w-full h-72 flex flex-col items-center justify-center gap-3 rounded-lg border-2 border-dashed transition-colors ${
              dragging ? "border-violet-500 bg-violet-50" : "border-slate-300 bg-slate-50 hover:border-violet-400 hover:bg-violet-50/50"
            }`}
          >
            <div className="w-12 h-12 rounded-full bg-white border border-slate-200 flex items-center justify-center shadow-sm">
              <CloudUploadIcon className="w-6 h-6 text-violet-600" />
            </div>
            <div className="text-center">
              <p className="text-sm font-medium text-slate-700">
                Drop a file here or <span className="text-violet-600">browse</span>
              </p>
              <p className="text-xs text-slate-400 mt-1">PDF or TXT, up to 10MB</p>
            </div>
          </button>
        )}
        <input
          ref={fileRef}
          type="file"
          accept=".pdf,.txt,.md,application/pdf,text/plain"
          className="hidden"
          onChange={(e) => {
            acceptFile(e.target.files?.[0]);
            e.target.value = "";
          }}
        />
      </CardContent>
    </Card>
  );
}

// ── Result components ───────────────────────────────────────────────────────

function ScoreRing({ score, ringClass }: { score: number; ringClass: string }) {
  const radius = 54;
  const circumference = 2 * Math.PI * radius;
  const offset = circumference * (1 - score / 100);
  return (
    <div className="relative w-36 h-36 flex-shrink-0" role="img" aria-label={`Match score ${score} percent`}>
      <svg viewBox="0 0 128 128" className="w-full h-full -rotate-90">
        <circle cx="64" cy="64" r={radius} fill="none" strokeWidth="12" className="stroke-slate-100" />
        <circle
          cx="64"
          cy="64"
          r={radius}
          fill="none"
          strokeWidth="12"
          strokeLinecap="round"
          strokeDasharray={circumference}
          strokeDashoffset={offset}
          className={`${ringClass} transition-[stroke-dashoffset] duration-1000 ease-out`}
        />
      </svg>
      <div className="absolute inset-0 flex flex-col items-center justify-center">
        <span className="text-4xl font-bold text-slate-900 tabular-nums">{score}%</span>
        <span className="text-xs text-slate-400 uppercase tracking-wider">Match</span>
      </div>
    </div>
  );
}

function SkillStatusIcon({ status }: { status: string }) {
  if (status === "matched") return <CircleCheckIcon className="w-4 h-4 text-emerald-500 flex-shrink-0" />;
  if (status === "partial") return <CircleMinusIcon className="w-4 h-4 text-amber-500 flex-shrink-0" />;
  return <CircleXIcon className="w-4 h-4 text-red-500 flex-shrink-0" />;
}

function SkillsAnalysis({ skills }: { skills: CvMatchResult["skills_analysis"] }) {
  const [filter, setFilter] = useState<"all" | "matched" | "partial" | "missing">("all");
  const counts = {
    all: skills.length,
    matched: skills.filter((s) => s.status === "matched").length,
    partial: skills.filter((s) => s.status === "partial").length,
    missing: skills.filter((s) => s.status === "missing").length,
  };
  const visible = filter === "all" ? skills : skills.filter((s) => s.status === filter);
  const sorted = [...visible].sort((a, b) => (a.importance === b.importance ? 0 : a.importance === "required" ? -1 : 1));

  const filters: { key: typeof filter; label: string; active: string }[] = [
    { key: "all", label: "All", active: "bg-slate-900 text-white border-slate-900" },
    { key: "matched", label: "Matched", active: "bg-emerald-600 text-white border-emerald-600" },
    { key: "partial", label: "Partial", active: "bg-amber-500 text-white border-amber-500" },
    { key: "missing", label: "Missing", active: "bg-red-600 text-white border-red-600" },
  ];

  return (
    <Card className="border-slate-200 bg-white shadow-sm">
      <CardHeader className="pb-3">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          <CardTitle className="text-slate-800 text-base flex items-center gap-2">
            <ListChecksIcon className="w-4 h-4 text-violet-600" />
            Skills &amp; Requirements Match
          </CardTitle>
          <div className="flex flex-wrap gap-1.5">
            {filters.map((f) => (
              <button
                key={f.key}
                onClick={() => setFilter(f.key)}
                className={`text-xs font-medium px-2.5 py-1 rounded-full border transition-colors ${
                  filter === f.key ? f.active : "bg-white text-slate-600 border-slate-200 hover:bg-slate-50"
                }`}
              >
                {f.label} <span className="opacity-75">{counts[f.key]}</span>
              </button>
            ))}
          </div>
        </div>
        {counts.all > 0 && (
          <div className="flex h-2 rounded-full overflow-hidden bg-slate-100 mt-3" aria-hidden>
            <div className="bg-emerald-500" style={{ width: `${(counts.matched / counts.all) * 100}%` }} />
            <div className="bg-amber-400" style={{ width: `${(counts.partial / counts.all) * 100}%` }} />
            <div className="bg-red-400" style={{ width: `${(counts.missing / counts.all) * 100}%` }} />
          </div>
        )}
      </CardHeader>
      <CardContent>
        {sorted.length === 0 ? (
          <p className="text-sm text-slate-400 text-center py-6">No skills in this category.</p>
        ) : (
          <div className="divide-y divide-slate-100 border border-slate-200 rounded-lg overflow-hidden">
            {sorted.map((s, i) => (
              <div key={i} className="flex items-start gap-3 px-4 py-3 bg-white">
                <SkillStatusIcon status={s.status} />
                <div className="flex-1 min-w-0">
                  <div className="flex flex-wrap items-center gap-2">
                    <span className="text-sm font-semibold text-slate-800">{s.skill}</span>
                    <Badge
                      variant="outline"
                      className={
                        s.importance === "required"
                          ? "bg-violet-50 text-violet-700 border-violet-200 text-[10px] uppercase tracking-wide"
                          : "bg-slate-50 text-slate-500 border-slate-200 text-[10px] uppercase tracking-wide"
                      }
                    >
                      {s.importance}
                    </Badge>
                  </div>
                  {s.evidence && <p className="text-xs text-slate-500 mt-1 leading-relaxed">{s.evidence}</p>}
                </div>
              </div>
            ))}
          </div>
        )}
      </CardContent>
    </Card>
  );
}

function InsightList({
  title,
  icon: Icon,
  iconClass,
  dotClass,
  items,
  emptyText,
  badgeKey,
}: {
  title: string;
  icon: React.ComponentType<{ className?: string }>;
  iconClass: string;
  dotClass: string;
  items: { title: string; detail: string; severity?: string; impact?: string }[];
  emptyText: string;
  badgeKey?: "severity" | "impact";
}) {
  return (
    <Card className="border-slate-200 bg-white shadow-sm h-full">
      <CardHeader className="pb-3">
        <CardTitle className="text-slate-800 text-base flex items-center gap-2">
          <Icon className={`w-4 h-4 ${iconClass}`} />
          {title}
        </CardTitle>
      </CardHeader>
      <CardContent>
        {items.length === 0 ? (
          <p className="text-sm text-slate-400">{emptyText}</p>
        ) : (
          <ul className="space-y-3">
            {items.map((item, i) => {
              const badge = badgeKey ? item[badgeKey] : undefined;
              return (
                <li key={i} className="flex gap-3">
                  <span className={`mt-1.5 w-1.5 h-1.5 rounded-full flex-shrink-0 ${dotClass}`} />
                  <div className="min-w-0">
                    <div className="flex flex-wrap items-center gap-2">
                      <p className="text-sm font-semibold text-slate-800">{item.title}</p>
                      {badge && (
                        <Badge variant="outline" className={`text-[10px] uppercase tracking-wide ${PRIORITY_STYLES[badge] ?? PRIORITY_STYLES.low}`}>
                          {badge}
                          {badgeKey === "impact" ? " impact" : ""}
                        </Badge>
                      )}
                    </div>
                    <p className="text-sm text-slate-600 mt-0.5 leading-relaxed">{item.detail}</p>
                  </div>
                </li>
              );
            })}
          </ul>
        )}
      </CardContent>
    </Card>
  );
}

function MatchResults({ result }: { result: CvMatchResult }) {
  const level = LEVEL_STYLES[result.match_level] ?? LEVEL_STYLES.weak;
  const recommendation = RECOMMENDATION_STYLES[result.recommendation];
  const roles = result.experience_analysis?.relevant_roles ?? [];

  return (
    <div className="space-y-5">
      {/* Overview */}
      <Card className="border-slate-200 bg-white shadow-sm overflow-hidden">
        <CardContent className="p-6">
          <div className="flex flex-col md:flex-row gap-6 md:items-center">
            <ScoreRing score={result.overall_score} ringClass={level.ring} />
            <div className="flex-1 min-w-0 space-y-3">
              <div className="flex flex-wrap items-center gap-2">
                <Badge variant="outline" className={`${level.bg} ${level.text} font-semibold`}>
                  {level.label}
                </Badge>
                {recommendation && (
                  <Badge variant="outline" className={recommendation.className}>
                    {recommendation.label}
                  </Badge>
                )}
              </div>
              <div className="flex flex-wrap gap-x-6 gap-y-1 text-sm">
                {result.candidate?.name && (
                  <span className="flex items-center gap-1.5 text-slate-700">
                    <UserIcon className="w-4 h-4 text-slate-400" />
                    <span className="font-semibold">{result.candidate.name}</span>
                    {result.candidate.current_title && <span className="text-slate-500">· {result.candidate.current_title}</span>}
                  </span>
                )}
                {result.job?.title && (
                  <span className="flex items-center gap-1.5 text-slate-700">
                    <TargetIcon className="w-4 h-4 text-slate-400" />
                    <span className="font-semibold">{result.job.title}</span>
                  </span>
                )}
              </div>
              <p className="text-sm text-slate-600 leading-relaxed">{result.summary}</p>
              {result.recommendation_reason && (
                <p className="text-xs text-slate-500 italic">{result.recommendation_reason}</p>
              )}
            </div>
          </div>
        </CardContent>

        {/* Category breakdown */}
        <div className="border-t border-slate-100 bg-slate-50/60 px-6 py-5 grid grid-cols-1 sm:grid-cols-2 gap-x-8 gap-y-5">
          {Object.entries(result.category_scores).map(([key, cat]) => (
            <div key={key}>
              <div className="flex items-baseline justify-between mb-1.5">
                <span className="text-sm font-semibold text-slate-700">
                  {CATEGORY_LABELS[key] ?? key}
                  <span className="ml-1.5 text-xs font-normal text-slate-400">{cat.weight}% weight</span>
                </span>
                <span className="text-sm font-bold text-slate-900 tabular-nums">{cat.score}%</span>
              </div>
              <div className="h-2 rounded-full bg-slate-200 overflow-hidden">
                <div
                  className={`h-full rounded-full ${scoreColor(cat.score)} transition-[width] duration-700`}
                  style={{ width: `${cat.score}%` }}
                />
              </div>
              {cat.rationale && <p className="text-xs text-slate-500 mt-1.5 leading-relaxed">{cat.rationale}</p>}
            </div>
          ))}
        </div>
      </Card>

      {/* Strengths & gaps */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-5">
        <InsightList
          title="Key Strengths"
          icon={ThumbsUpIcon}
          iconClass="text-emerald-600"
          dotClass="bg-emerald-500"
          items={result.strengths}
          emptyText="No notable strengths identified."
        />
        <InsightList
          title="Gaps & Concerns"
          icon={TriangleAlertIcon}
          iconClass="text-amber-600"
          dotClass="bg-amber-500"
          items={result.gaps}
          emptyText="No significant gaps — this CV covers the role's requirements."
          badgeKey="severity"
        />
      </div>

      {/* Skills */}
      <SkillsAnalysis skills={result.skills_analysis} />

      {/* Improvements */}
      <Card className="border-violet-200 bg-gradient-to-br from-violet-50 to-white shadow-sm">
        <CardHeader className="pb-3">
          <CardTitle className="text-slate-800 text-base flex items-center gap-2">
            <LightbulbIcon className="w-4 h-4 text-violet-600" />
            {result.overall_score >= 85 ? "Polishing a Strong Match" : "Path to a Perfect Match"}
          </CardTitle>
          <p className="text-xs text-slate-500">Actionable steps to close the gap between this CV and the role.</p>
        </CardHeader>
        <CardContent>
          <ol className="grid grid-cols-1 md:grid-cols-2 gap-3">
            {result.improvements.map((item, i) => (
              <li key={i} className="flex gap-3 bg-white border border-violet-100 rounded-lg p-3">
                <span className="w-6 h-6 rounded-full bg-violet-600 text-white text-xs font-bold flex items-center justify-center flex-shrink-0">
                  {i + 1}
                </span>
                <div className="min-w-0">
                  <div className="flex flex-wrap items-center gap-2">
                    <p className="text-sm font-semibold text-slate-800">{item.title}</p>
                    {item.impact && (
                      <Badge variant="outline" className={`text-[10px] uppercase tracking-wide ${PRIORITY_STYLES[item.impact] ?? PRIORITY_STYLES.low}`}>
                        {item.impact} impact
                      </Badge>
                    )}
                  </div>
                  <p className="text-sm text-slate-600 mt-0.5 leading-relaxed">{item.detail}</p>
                </div>
              </li>
            ))}
          </ol>
        </CardContent>
      </Card>

      {/* Experience & interview questions */}
      <div className="grid grid-cols-1 lg:grid-cols-5 gap-5">
        <Card className="border-slate-200 bg-white shadow-sm lg:col-span-3">
          <CardHeader className="pb-3">
            <CardTitle className="text-slate-800 text-base flex items-center gap-2">
              <BriefcaseIcon className="w-4 h-4 text-blue-600" />
              Work Experience Fit
            </CardTitle>
            <div className="flex flex-wrap gap-4 text-xs text-slate-500 pt-1">
              {result.candidate?.total_experience_years != null && (
                <span>
                  Candidate: <span className="font-semibold text-slate-700">{result.candidate.total_experience_years} yrs</span>
                </span>
              )}
              {!!result.job?.required_years && (
                <span>
                  Role requires: <span className="font-semibold text-slate-700">{result.job.required_years}+ yrs</span>
                </span>
              )}
            </div>
          </CardHeader>
          <CardContent className="space-y-4">
            {result.experience_analysis?.assessment && (
              <p className="text-sm text-slate-600 leading-relaxed">{result.experience_analysis.assessment}</p>
            )}
            {roles.length > 0 && (
              <div className="space-y-2">
                {roles.map((role, i) => (
                  <div key={i} className="border border-slate-200 rounded-lg px-4 py-3">
                    <div className="flex flex-wrap items-start justify-between gap-2">
                      <div className="min-w-0">
                        <p className="text-sm font-semibold text-slate-800">{role.title}</p>
                        <p className="text-xs text-slate-500">
                          {role.company}
                          {role.duration ? ` · ${role.duration}` : ""}
                        </p>
                      </div>
                      <Badge variant="outline" className={`text-[10px] uppercase tracking-wide ${RELEVANCE_STYLES[role.relevance] ?? RELEVANCE_STYLES.low}`}>
                        {role.relevance} relevance
                      </Badge>
                    </div>
                    {role.note && <p className="text-xs text-slate-500 mt-1.5 leading-relaxed">{role.note}</p>}
                  </div>
                ))}
              </div>
            )}
          </CardContent>
        </Card>

        <Card className="border-slate-200 bg-white shadow-sm lg:col-span-2">
          <CardHeader className="pb-3">
            <CardTitle className="text-slate-800 text-base flex items-center gap-2">
              <MessageSquareQuoteIcon className="w-4 h-4 text-slate-600" />
              Suggested Interview Questions
            </CardTitle>
          </CardHeader>
          <CardContent>
            <ol className="space-y-3">
              {result.interview_questions.map((q, i) => (
                <li key={i} className="flex gap-2.5 text-sm text-slate-600 leading-relaxed">
                  <span className="text-slate-400 font-semibold tabular-nums">{i + 1}.</span>
                  <span>{q}</span>
                </li>
              ))}
            </ol>
          </CardContent>
        </Card>
      </div>

      {result.interview_prep && <InterviewPrep prep={result.interview_prep} />}
    </div>
  );
}

// ── Interview preparation ───────────────────────────────────────────────────

const DIFFICULTY_STYLES: Record<string, string> = {
  easy: "bg-emerald-50 text-emerald-700 border-emerald-200",
  medium: "bg-amber-50 text-amber-700 border-amber-200",
  hard: "bg-red-50 text-red-700 border-red-200",
};

const SCENARIO_LABELS: Record<string, string> = {
  system_design: "System design",
  debugging: "Debugging",
  architecture: "Architecture",
  problem_solving: "Problem solving",
  case_study: "Case study",
};

function CodingChallengeCard({ challenge, index }: { challenge: CvInterviewPrep["coding_challenges"][number]; index: number }) {
  const [hintsShown, setHintsShown] = useState(0);
  const [showApproach, setShowApproach] = useState(false);
  const hints = challenge.hints ?? [];

  return (
    <div className="border border-slate-200 rounded-lg overflow-hidden">
      <div className="flex flex-wrap items-center justify-between gap-2 px-4 py-3 bg-slate-50 border-b border-slate-200">
        <p className="text-sm font-semibold text-slate-800">
          <span className="text-slate-400 mr-1.5">#{index + 1}</span>
          {challenge.title}
        </p>
        <Badge variant="outline" className={`text-[10px] uppercase tracking-wide ${DIFFICULTY_STYLES[challenge.difficulty] ?? DIFFICULTY_STYLES.medium}`}>
          {challenge.difficulty}
        </Badge>
      </div>
      <div className="px-4 py-3 space-y-3">
        <p className="text-sm text-slate-700 leading-relaxed whitespace-pre-wrap">{challenge.problem}</p>
        {challenge.skills_tested?.length > 0 && (
          <div className="flex flex-wrap gap-1.5">
            {challenge.skills_tested.map((s, i) => (
              <span key={i} className="text-xs bg-violet-50 text-violet-700 border border-violet-100 rounded-full px-2 py-0.5">
                {s}
              </span>
            ))}
          </div>
        )}

        {hintsShown > 0 && (
          <ol className="space-y-1.5">
            {hints.slice(0, hintsShown).map((hint, i) => (
              <li key={i} className="flex gap-2 text-sm text-slate-600 bg-amber-50/60 border border-amber-100 rounded-md px-3 py-2">
                <LightbulbIcon className="w-4 h-4 text-amber-500 flex-shrink-0 mt-0.5" />
                <span>
                  <span className="font-semibold text-amber-700">Hint {i + 1}:</span> {hint}
                </span>
              </li>
            ))}
          </ol>
        )}

        {showApproach && (
          <div className="text-sm text-slate-700 bg-emerald-50/60 border border-emerald-100 rounded-md px-3 py-2 leading-relaxed whitespace-pre-wrap">
            <span className="font-semibold text-emerald-700">Suggested approach: </span>
            {challenge.approach}
          </div>
        )}

        <div className="flex flex-wrap gap-2 pt-1">
          {hintsShown < hints.length && (
            <Button variant="outline" size="sm" onClick={() => setHintsShown((n) => n + 1)} className="border-slate-300 text-slate-600 gap-1.5 h-8">
              <LightbulbIcon className="w-3.5 h-3.5" />
              {hintsShown === 0 ? "Show a hint" : "Next hint"}
              <span className="text-slate-400">
                {hintsShown}/{hints.length}
              </span>
            </Button>
          )}
          {challenge.approach && (
            <Button variant="outline" size="sm" onClick={() => setShowApproach((v) => !v)} className="border-slate-300 text-slate-600 gap-1.5 h-8">
              <EyeIcon className="w-3.5 h-3.5" />
              {showApproach ? "Hide approach" : "Reveal approach"}
            </Button>
          )}
        </div>
      </div>
    </div>
  );
}

function TheoryQuestion({ item }: { item: CvInterviewPrep["theory_questions"][number] }) {
  const [open, setOpen] = useState(false);
  return (
    <div className="border border-slate-200 rounded-lg overflow-hidden">
      <button
        onClick={() => setOpen((v) => !v)}
        className="w-full flex items-start justify-between gap-3 px-4 py-3 text-left hover:bg-slate-50 transition-colors"
        aria-expanded={open}
      >
        <div className="min-w-0">
          {item.topic && <p className="text-[10px] font-semibold uppercase tracking-wider text-violet-600 mb-0.5">{item.topic}</p>}
          <p className="text-sm font-medium text-slate-800">{item.question}</p>
        </div>
        <ChevronDownIcon className={`w-4 h-4 text-slate-400 flex-shrink-0 mt-1 transition-transform ${open ? "rotate-180" : ""}`} />
      </button>
      {open && item.key_points?.length > 0 && (
        <div className="px-4 pb-3 pt-1 border-t border-slate-100 bg-slate-50/60">
          <p className="text-xs font-semibold text-slate-500 mb-1.5 mt-2">A strong answer covers:</p>
          <ul className="space-y-1">
            {item.key_points.map((point, i) => (
              <li key={i} className="flex gap-2 text-sm text-slate-600">
                <CircleCheckIcon className="w-3.5 h-3.5 text-emerald-500 flex-shrink-0 mt-1" />
                {point}
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
}

type PrepTab = "focus" | "coding" | "algorithms" | "theory" | "applied";

function InterviewPrep({ prep }: { prep: CvInterviewPrep }) {
  const tabs: { key: PrepTab; label: string; icon: React.ComponentType<{ className?: string }>; count: number }[] = [
    { key: "focus", label: "Focus Areas", icon: CompassIcon, count: prep.focus_areas.length },
    { key: "coding", label: "Coding Challenges", icon: CodeIcon, count: prep.coding_challenges.length },
    { key: "algorithms", label: "Algorithms", icon: NetworkIcon, count: prep.algorithms.length },
    { key: "theory", label: "Theory", icon: BookOpenIcon, count: prep.theory_questions.length },
    {
      key: "applied",
      label: prep.role_type === "technical" ? "Applied Thinking" : "Case Questions",
      icon: BrainIcon,
      count: prep.applied_scenarios.length,
    },
  ];
  const visibleTabs = tabs.filter((t) => t.count > 0);
  const [active, setActive] = useState<PrepTab>(visibleTabs[0]?.key ?? "focus");

  if (visibleTabs.length === 0) return null;

  return (
    <Card className="border-slate-200 bg-white shadow-sm">
      <CardHeader className="pb-3">
        <CardTitle className="text-slate-800 text-base flex items-center gap-2">
          <GraduationCapIcon className="w-4 h-4 text-violet-600" />
          Interview Preparation
        </CardTitle>
        <p className="text-xs text-slate-500">
          Tailored to this role&apos;s requirements and weighted towards the gaps found in the CV.
        </p>
        <div className="flex gap-1 overflow-x-auto border-b border-slate-200 -mx-1 px-1 pt-2" role="tablist">
          {visibleTabs.map((tab) => (
            <button
              key={tab.key}
              role="tab"
              aria-selected={active === tab.key}
              onClick={() => setActive(tab.key)}
              className={`flex items-center gap-1.5 px-3 py-2 text-sm font-medium whitespace-nowrap border-b-2 -mb-px transition-colors ${
                active === tab.key ? "border-violet-600 text-violet-700" : "border-transparent text-slate-500 hover:text-slate-700"
              }`}
            >
              <tab.icon className="w-4 h-4" />
              {tab.label}
              <span className="text-xs text-slate-400 tabular-nums">{tab.count}</span>
            </button>
          ))}
        </div>
      </CardHeader>
      <CardContent>
        {active === "focus" && (
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            {prep.focus_areas.map((area, i) => (
              <div key={i} className="border border-slate-200 rounded-lg px-4 py-3">
                <div className="flex flex-wrap items-center justify-between gap-2">
                  <p className="text-sm font-semibold text-slate-800">{area.topic}</p>
                  <Badge variant="outline" className={`text-[10px] uppercase tracking-wide ${PRIORITY_STYLES[area.priority] ?? PRIORITY_STYLES.low}`}>
                    {area.priority} priority
                  </Badge>
                </div>
                <p className="text-sm text-slate-600 mt-1 leading-relaxed">{area.reason}</p>
              </div>
            ))}
          </div>
        )}

        {active === "coding" && (
          <div className="space-y-4">
            {prep.coding_challenges.map((c, i) => (
              <CodingChallengeCard key={i} challenge={c} index={i} />
            ))}
          </div>
        )}

        {active === "algorithms" && (
          <div className="divide-y divide-slate-100 border border-slate-200 rounded-lg overflow-hidden">
            {prep.algorithms.map((algo, i) => (
              <div key={i} className="flex flex-col sm:flex-row sm:items-start gap-2 sm:gap-4 px-4 py-3">
                <div className="sm:w-56 flex-shrink-0">
                  <p className="text-sm font-semibold text-slate-800">{algo.name}</p>
                  {algo.complexity && (
                    <code className="inline-block mt-1 text-[11px] font-mono bg-slate-100 text-slate-600 rounded px-1.5 py-0.5">
                      {algo.complexity}
                    </code>
                  )}
                </div>
                <p className="text-sm text-slate-600 leading-relaxed">{algo.relevance}</p>
              </div>
            ))}
          </div>
        )}

        {active === "theory" && (
          <div className="space-y-2">
            {prep.theory_questions.map((q, i) => (
              <TheoryQuestion key={i} item={q} />
            ))}
          </div>
        )}

        {active === "applied" && (
          <div className="space-y-3">
            {prep.applied_scenarios.map((s, i) => (
              <div key={i} className="border border-slate-200 rounded-lg px-4 py-3 space-y-2">
                <Badge variant="outline" className="text-[10px] uppercase tracking-wide bg-blue-50 text-blue-700 border-blue-200">
                  {SCENARIO_LABELS[s.type] ?? s.type}
                </Badge>
                <p className="text-sm text-slate-800 leading-relaxed">{s.scenario}</p>
                {s.what_interviewers_look_for?.length > 0 && (
                  <div className="bg-slate-50 rounded-md px-3 py-2">
                    <p className="text-xs font-semibold text-slate-500 mb-1">What interviewers look for:</p>
                    <ul className="space-y-1">
                      {s.what_interviewers_look_for.map((point, j) => (
                        <li key={j} className="flex gap-2 text-sm text-slate-600">
                          <CircleCheckIcon className="w-3.5 h-3.5 text-emerald-500 flex-shrink-0 mt-1" />
                          {point}
                        </li>
                      ))}
                    </ul>
                  </div>
                )}
              </div>
            ))}
          </div>
        )}
      </CardContent>
    </Card>
  );
}

// ── Page ────────────────────────────────────────────────────────────────────

const LOADING_STEPS = [
  "Reading documents",
  "Extracting requirements",
  "Comparing skills & experience",
  "Scoring the match",
  "Preparing interview guide",
];

export default function CvMatchPage() {
  const [jd, setJd] = useState<DocInput>(EMPTY_INPUT);
  const [cv, setCv] = useState<DocInput>(EMPTY_INPUT);
  const [loading, setLoading] = useState(false);
  const [loadingStep, setLoadingStep] = useState(0);
  const [result, setResult] = useState<CvMatchResult | null>(null);
  const [showForm, setShowForm] = useState(true);

  const canSubmit = isReady(jd) && isReady(cv) && !loading;

  function toPayload(input: DocInput): CvMatchInput {
    return input.mode === "file" ? { file: input.file } : { text: input.text };
  }

  async function handleAnalyze() {
    if (!isReady(jd) || !isReady(cv)) {
      toast.error("Please provide both a job description and a CV.");
      return;
    }

    setLoading(true);
    setLoadingStep(0);
    const timer = setInterval(() => setLoadingStep((s) => Math.min(s + 1, LOADING_STEPS.length - 1)), 15000);
    try {
      const res = await sourcingApi.matchCv(toPayload(jd), toPayload(cv));
      setResult(res.data.data);
      setShowForm(false);
      toast.success("Match analysis complete.");
    } catch (err: unknown) {
      const message =
        (err as { response?: { data?: { error?: string } } })?.response?.data?.error ??
        "Failed to analyse the match. Please try again.";
      toast.error(message);
    } finally {
      clearInterval(timer);
      setLoading(false);
    }
  }

  function handleReset() {
    setJd(EMPTY_INPUT);
    setCv(EMPTY_INPUT);
    setResult(null);
    setShowForm(true);
  }

  return (
    <div className="p-6 max-w-6xl mx-auto space-y-6">
      <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-3">
        <div>
          <div className="flex items-center gap-2 mb-1">
            <FileCheck2Icon className="w-5 h-5 text-violet-600" />
            <h1 className="text-2xl font-bold text-slate-900">CV ↔ Job Match</h1>
          </div>
          <p className="text-slate-500 text-sm">
            Compare a CV against a job description. AI scores the fit, explains matched and missing skills, and suggests how to close the gap.
          </p>
        </div>
        {result && !loading && (
          <div className="flex gap-2 flex-shrink-0">
            <Button variant="outline" size="sm" onClick={() => setShowForm((v) => !v)} className="border-slate-300 text-slate-600 gap-1.5">
              <PencilIcon className="w-4 h-4" />
              {showForm ? "Hide inputs" : "Edit inputs"}
            </Button>
            <Button variant="outline" size="sm" onClick={handleReset} className="border-slate-300 text-slate-600 gap-1.5">
              <RotateCcwIcon className="w-4 h-4" />
              New analysis
            </Button>
          </div>
        )}
      </div>

      {showForm && (
        <div className="space-y-4">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-5">
            <DocumentInput
              title="1. Job Description"
              description="The role's requirements, responsibilities and skills."
              placeholder="Paste the full job description here…"
              value={jd}
              onChange={setJd}
              disabled={loading}
            />
            <DocumentInput
              title="2. Candidate CV"
              description="The candidate's resume with skills and work history."
              placeholder="Paste the candidate's CV / resume here…"
              value={cv}
              onChange={setCv}
              disabled={loading}
            />
          </div>

          <div className="flex flex-col sm:flex-row items-center justify-between gap-3 bg-white border border-slate-200 rounded-xl px-5 py-4 shadow-sm">
            <p className="text-xs text-slate-500">
              Documents are analysed on the fly and are not saved. Analysis usually takes 1–2 minutes.
            </p>
            <Button
              onClick={handleAnalyze}
              disabled={!canSubmit}
              className="bg-violet-600 hover:bg-violet-500 text-white px-6 w-full sm:w-auto"
            >
              {loading ? (
                <>
                  <Loader2Icon className="w-4 h-4 mr-2 animate-spin" />
                  Analysing…
                </>
              ) : (
                <>
                  <SparklesIcon className="w-4 h-4 mr-2" />
                  Analyse Match
                </>
              )}
            </Button>
          </div>
        </div>
      )}

      {loading && (
        <Card className="border-slate-200 bg-white shadow-sm">
          <CardContent className="py-10 flex flex-col items-center gap-6">
            <Loader2Icon className="w-8 h-8 text-violet-600 animate-spin" />
            <ol className="space-y-2.5">
              {LOADING_STEPS.map((step, i) => (
                <li key={step} className="flex items-center gap-2.5 text-sm">
                  {i < loadingStep ? (
                    <CircleCheckIcon className="w-4 h-4 text-emerald-500" />
                  ) : i === loadingStep ? (
                    <Loader2Icon className="w-4 h-4 text-violet-600 animate-spin" />
                  ) : (
                    <span className="w-4 h-4 rounded-full border-2 border-slate-200" />
                  )}
                  <span className={i <= loadingStep ? "text-slate-700 font-medium" : "text-slate-400"}>{step}</span>
                </li>
              ))}
            </ol>
          </CardContent>
        </Card>
      )}

      {result && !loading && <MatchResults result={result} />}
    </div>
  );
}
