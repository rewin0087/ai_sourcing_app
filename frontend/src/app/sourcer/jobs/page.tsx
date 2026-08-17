"use client";

import { useState, useEffect, useCallback } from "react";
import { toast } from "sonner";
import Link from "next/link";
import {
  FileTextIcon,
  Loader2Icon,
  Trash2Icon,
  CalendarIcon,
  SearchIcon,
  XIcon,
  UsersIcon,
  MapPinIcon,
  BriefcaseIcon,
  BuildingIcon,
  DollarSignIcon,
  TagIcon,
  TrophyIcon,
  ChevronDownIcon,
  ChevronUpIcon,
  ExternalLinkIcon,
  SparklesIcon,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { sourcingApi, JobDescription, MatchResult } from "@/lib/api";

const statusConfig: Record<string, { label: string; className: string }> = {
  completed: { label: "Completed", className: "bg-emerald-100 text-emerald-700 border-emerald-200" },
  pending: { label: "Pending", className: "bg-amber-100 text-amber-700 border-amber-200" },
  processing: { label: "Processing", className: "bg-blue-100 text-blue-700 border-blue-200" },
  failed: { label: "Failed", className: "bg-red-100 text-red-700 border-red-200" },
};

const rankColors = ["text-amber-500", "text-slate-400", "text-amber-700"];
const rankBgClass = ["bg-amber-50 border-amber-200", "bg-slate-50 border-slate-200", "bg-amber-50/60 border-amber-100"];

function formatDate(dateStr: string) {
  return new Date(dateStr).toLocaleDateString("en-US", {
    month: "short",
    day: "numeric",
    year: "numeric",
  });
}

function ScoreCircle({ score }: { score: number }) {
  const color = score >= 70 ? "text-emerald-600" : score >= 50 ? "text-amber-600" : "text-red-500";
  const display = Number.isInteger(score) ? score : score.toFixed(1);
  return (
    <div className="flex flex-col items-center gap-1 flex-shrink-0">
      <div className={`text-xl font-bold tabular-nums ${color}`}>{display}%</div>
      <div className="w-14">
        <Progress value={score} className="h-1.5" />
      </div>
      <span className="text-xs text-slate-400">overall</span>
    </div>
  );
}

function ScoreBar({ label, value }: { label: string; value: number }) {
  const display = Number.isInteger(value) ? value : value.toFixed(1);
  return (
    <div>
      <div className="flex justify-between text-xs text-slate-500 mb-0.5">
        <span>{label}</span>
        <span className="font-medium">{display}%</span>
      </div>
      <Progress value={value} className="h-1" />
    </div>
  );
}

export default function JobsPage() {
  const [jobs, setJobs] = useState<JobDescription[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState("");
  const [deletingId, setDeletingId] = useState<number | null>(null);
  const [selectedJob, setSelectedJob] = useState<JobDescription | null>(null);
  const [activeTab, setActiveTab] = useState<"details" | "candidates">("details");
  const [loadingDetail, setLoadingDetail] = useState(false);
  const [searching, setSearching] = useState(false);
  const [results, setResults] = useState<MatchResult[] | null>(null);
  const [expandedReason, setExpandedReason] = useState<number | null>(null);

  const fetchJobs = useCallback(async () => {
    setLoading(true);
    try {
      const res = await sourcingApi.getJobs();
      const raw = res.data?.data;
      setJobs(Array.isArray(raw) ? raw : []);
    } catch {
      toast.error("Failed to load job descriptions.");
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchJobs();
  }, [fetchJobs]);

  async function selectJob(job: JobDescription) {
    setSelectedJob(job);
    setActiveTab("details");
    setResults(null);
    setExpandedReason(null);
    setLoadingDetail(true);
    try {
      const res = await sourcingApi.getJob(job.id);
      const detail: JobDescription = res.data.data ?? res.data;
      setSelectedJob(detail);
    } catch {
      toast.error("Failed to load job details.");
    } finally {
      setLoadingDetail(false);
    }
  }

  function closePanel() {
    setSelectedJob(null);
    setResults(null);
    setExpandedReason(null);
  }

  async function handleDelete(id: number, e: React.MouseEvent) {
    e.stopPropagation();
    if (!confirm("Delete this job description?")) return;
    setDeletingId(id);
    try {
      await sourcingApi.deleteJob(id);
      toast.success("Job description deleted.");
      setJobs((prev) => prev.filter((j) => j.id !== id));
      if (selectedJob?.id === id) closePanel();
    } catch {
      toast.error("Failed to delete job description.");
    } finally {
      setDeletingId(null);
    }
  }

  async function handleFindCandidates() {
    if (!selectedJob) return;
    setActiveTab("candidates");
    setSearching(true);
    setResults(null);
    setExpandedReason(null);
    try {
      const res = await sourcingApi.searchCandidates({
        job_description_id: selectedJob.id,
        limit: 20,
      });
      const matches: MatchResult[] = res.data.data?.candidates ?? res.data?.candidates ?? [];
      setResults(matches);
      if (matches.length === 0) {
        toast.info("No matching candidates found.");
      } else {
        toast.success(`Found ${matches.length} matched candidate${matches.length !== 1 ? "s" : ""}.`);
      }
    } catch {
      toast.error("Candidate search failed. Please try again.");
    } finally {
      setSearching(false);
    }
  }

  const filtered = jobs.filter(
    (j) =>
      !search.trim() ||
      (j.title ?? "").toLowerCase().includes(search.toLowerCase()) ||
      (j.company_name ?? "").toLowerCase().includes(search.toLowerCase())
  );

  const panelOpen = !!selectedJob;

  return (
    <div className="flex flex-col h-full overflow-hidden">
      {/* Page header */}
      <div className="flex items-center justify-between gap-3 px-6 py-4 border-b border-slate-200 bg-white flex-shrink-0">
        <div>
          <h1 className="text-xl font-bold text-slate-900">Job Descriptions</h1>
          <p className="text-slate-500 text-xs mt-0.5">
            {jobs.length} job description{jobs.length !== 1 ? "s" : ""}
          </p>
        </div>
        <div className="relative">
          <SearchIcon className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
          <Input
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder="Search by title or company…"
            className="pl-9 border-slate-300 w-64 h-9 text-sm"
          />
        </div>
      </div>

      {/* Split body */}
      <div className="flex flex-1 min-h-0">
        {/* Jobs list column */}
        <div
          className={`flex flex-col bg-white overflow-y-auto transition-all duration-200 ${
            panelOpen
              ? "w-[360px] flex-shrink-0 border-r border-slate-200"
              : "flex-1"
          }`}
        >
          {loading ? (
            <div className="flex items-center justify-center py-16">
              <Loader2Icon className="w-6 h-6 text-blue-600 animate-spin" />
            </div>
          ) : filtered.length === 0 ? (
            <div className="flex flex-col items-center justify-center flex-1 py-16 text-slate-400">
              <FileTextIcon className="w-10 h-10 mb-3 opacity-30" />
              <p className="font-medium text-sm">No job descriptions found.</p>
              <p className="text-xs mt-1">
                {search
                  ? "Try a different search."
                  : "Go to Find Candidates to parse your first JD."}
              </p>
            </div>
          ) : (
            <Table>
              <TableHeader className="sticky top-0 z-10">
                <TableRow className="bg-slate-50 border-b border-slate-200">
                  <TableHead className="text-slate-600 font-semibold text-xs">Title</TableHead>
                  {!panelOpen && (
                    <TableHead className="text-slate-600 font-semibold text-xs">Company</TableHead>
                  )}
                  <TableHead className="text-slate-600 font-semibold text-xs">Status</TableHead>
                  {!panelOpen && (
                    <TableHead className="text-slate-600 font-semibold text-xs">Date</TableHead>
                  )}
                  <TableHead className="w-8" />
                </TableRow>
              </TableHeader>
              <TableBody>
                {filtered.map((job) => {
                  const sc = statusConfig[job.status] ?? statusConfig.pending;
                  const isSelected = selectedJob?.id === job.id;
                  return (
                    <TableRow
                      key={job.id}
                      className={`cursor-pointer transition-colors ${
                        isSelected
                          ? "bg-blue-50 border-l-2 border-l-blue-500"
                          : "hover:bg-slate-50"
                      }`}
                      onClick={() => selectJob(job)}
                    >
                      <TableCell className="py-3">
                        <div className="font-medium text-slate-800 text-sm truncate max-w-[140px]">
                          {job.title || (
                            <span className="text-slate-400 italic">Untitled</span>
                          )}
                        </div>
                        {panelOpen && (
                          <div className="text-slate-400 text-xs truncate max-w-[140px] mt-0.5">
                            {job.company_name}
                          </div>
                        )}
                      </TableCell>
                      {!panelOpen && (
                        <TableCell className="text-slate-500 text-sm">
                          {job.company_name || "—"}
                        </TableCell>
                      )}
                      <TableCell>
                        <Badge
                          className={`text-xs border ${sc.className}`}
                          variant="outline"
                        >
                          {sc.label}
                        </Badge>
                      </TableCell>
                      {!panelOpen && (
                        <TableCell>
                          <span className="flex items-center gap-1 text-slate-400 text-xs whitespace-nowrap">
                            <CalendarIcon className="w-3 h-3" />
                            {formatDate(job.created_at)}
                          </span>
                        </TableCell>
                      )}
                      <TableCell>
                        <Button
                          variant="ghost"
                          size="icon"
                          className="w-6 h-6 text-slate-400 hover:text-red-600 hover:bg-red-50"
                          onClick={(e) => handleDelete(job.id, e)}
                          disabled={deletingId === job.id}
                        >
                          {deletingId === job.id ? (
                            <Loader2Icon className="w-3 h-3 animate-spin" />
                          ) : (
                            <Trash2Icon className="w-3 h-3" />
                          )}
                        </Button>
                      </TableCell>
                    </TableRow>
                  );
                })}
              </TableBody>
            </Table>
          )}
        </div>

        {/* Side panel */}
        {selectedJob && (
          <div className="flex-1 flex flex-col min-w-0 overflow-hidden bg-slate-50">
            {/* Panel header */}
            <div className="flex-shrink-0 bg-white border-b border-slate-200 px-5 py-4">
              <div className="flex items-start justify-between gap-3 mb-3">
                <div className="min-w-0">
                  <h2 className="text-base font-bold text-slate-900 leading-snug truncate">
                    {selectedJob.title || "Untitled Job"}
                  </h2>
                  <div className="flex flex-wrap items-center gap-x-3 gap-y-1 mt-1 text-xs text-slate-500">
                    {selectedJob.company_name && (
                      <span className="flex items-center gap-1">
                        <BuildingIcon className="w-3 h-3" />
                        {selectedJob.company_name}
                      </span>
                    )}
                    {selectedJob.location && (
                      <span className="flex items-center gap-1">
                        <MapPinIcon className="w-3 h-3" />
                        {selectedJob.location}
                      </span>
                    )}
                    {selectedJob.salary_range && (
                      <span className="flex items-center gap-1">
                        <DollarSignIcon className="w-3 h-3" />
                        {selectedJob.salary_range}
                      </span>
                    )}
                  </div>
                </div>
                <Button
                  variant="ghost"
                  size="icon"
                  className="flex-shrink-0 w-7 h-7 text-slate-400 hover:text-slate-600 hover:bg-slate-100"
                  onClick={closePanel}
                >
                  <XIcon className="w-4 h-4" />
                </Button>
              </div>

              <div className="flex items-center gap-2 flex-wrap">
                <Badge
                  className={`text-xs border ${statusConfig[selectedJob.status]?.className ?? ""}`}
                  variant="outline"
                >
                  {statusConfig[selectedJob.status]?.label ?? selectedJob.status}
                </Badge>
                {selectedJob.employment_type && (
                  <Badge
                    className="text-xs border bg-slate-100 text-slate-600 border-slate-200"
                    variant="outline"
                  >
                    {selectedJob.employment_type}
                  </Badge>
                )}
                {selectedJob.experience_level && (
                  <Badge
                    className="text-xs border bg-purple-50 text-purple-700 border-purple-200 capitalize"
                    variant="outline"
                  >
                    {selectedJob.experience_level}
                  </Badge>
                )}
                <Button
                  onClick={handleFindCandidates}
                  disabled={searching}
                  size="sm"
                  className="ml-auto bg-blue-600 hover:bg-blue-500 text-white text-xs gap-1.5 h-7"
                >
                  {searching ? (
                    <>
                      <Loader2Icon className="w-3.5 h-3.5 animate-spin" />
                      Searching…
                    </>
                  ) : (
                    <>
                      <SparklesIcon className="w-3.5 h-3.5" />
                      Find Candidates
                    </>
                  )}
                </Button>
              </div>
            </div>

            {/* Tabs */}
            <Tabs
              value={activeTab}
              onValueChange={(v) => setActiveTab(v as "details" | "candidates")}
              className="flex flex-col flex-1 min-h-0"
            >
              <div className="flex-shrink-0 bg-white border-b border-slate-200 px-5">
                <TabsList className="h-10 bg-transparent p-0 rounded-none gap-1">
                  <TabsTrigger
                    value="details"
                    className="px-3 h-10 text-sm rounded-none border-b-2 border-transparent data-[state=active]:border-blue-600 data-[state=active]:text-blue-600 data-[state=active]:bg-transparent data-[state=active]:shadow-none text-slate-500 hover:text-slate-700 bg-transparent"
                  >
                    Details
                  </TabsTrigger>
                  <TabsTrigger
                    value="candidates"
                    className="px-3 h-10 text-sm rounded-none border-b-2 border-transparent data-[state=active]:border-blue-600 data-[state=active]:text-blue-600 data-[state=active]:bg-transparent data-[state=active]:shadow-none text-slate-500 hover:text-slate-700 bg-transparent"
                  >
                    Candidates
                    {results !== null && (
                      <span className="ml-1.5 bg-blue-100 text-blue-700 text-xs rounded-full px-1.5 py-px font-medium">
                        {results.length}
                      </span>
                    )}
                  </TabsTrigger>
                </TabsList>
              </div>

              {/* Details tab */}
              <TabsContent
                value="details"
                className="flex-1 overflow-y-auto p-5 m-0 data-[state=inactive]:hidden"
              >
                {loadingDetail ? (
                  <div className="flex items-center justify-center py-16">
                    <Loader2Icon className="w-6 h-6 text-blue-600 animate-spin" />
                  </div>
                ) : (
                  <div className="space-y-5">
                    {selectedJob.summary && (
                      <section>
                        <p className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-2">
                          Summary
                        </p>
                        <p className="text-slate-600 text-sm leading-relaxed">{selectedJob.summary}</p>
                      </section>
                    )}

                    {selectedJob.required_skills?.length > 0 && (
                      <section>
                        <p className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-2 flex items-center gap-1">
                          <TagIcon className="w-3.5 h-3.5" />
                          Required Skills ({selectedJob.required_skills.length})
                        </p>
                        <div className="flex flex-wrap gap-1.5">
                          {selectedJob.required_skills.map((s) => (
                            <Badge
                              key={s.name}
                              className="bg-blue-50 text-blue-700 border-blue-200 text-xs"
                              variant="outline"
                            >
                              {s.name}
                              {s.years_required ? ` · ${s.years_required}y` : ""}
                            </Badge>
                          ))}
                        </div>
                      </section>
                    )}

                    {selectedJob.preferred_skills?.length > 0 && (
                      <section>
                        <p className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-2 flex items-center gap-1">
                          <TagIcon className="w-3.5 h-3.5" />
                          Preferred Skills ({selectedJob.preferred_skills.length})
                        </p>
                        <div className="flex flex-wrap gap-1.5">
                          {selectedJob.preferred_skills.map((s) => (
                            <Badge
                              key={s.name}
                              className="bg-slate-100 text-slate-600 border-slate-200 text-xs"
                              variant="outline"
                            >
                              {s.name}
                            </Badge>
                          ))}
                        </div>
                      </section>
                    )}

                    {selectedJob.responsibilities && (
                      <section>
                        <p className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-2">
                          Responsibilities
                        </p>
                        <p className="text-slate-600 text-sm leading-relaxed whitespace-pre-line">
                          {selectedJob.responsibilities}
                        </p>
                      </section>
                    )}

                    {selectedJob.qualifications && (
                      <section>
                        <p className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-2">
                          Qualifications
                        </p>
                        <p className="text-slate-600 text-sm leading-relaxed whitespace-pre-line">
                          {selectedJob.qualifications}
                        </p>
                      </section>
                    )}

                    {selectedJob.about_company && (
                      <section>
                        <p className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-2">
                          About the Company
                        </p>
                        <p className="text-slate-600 text-sm leading-relaxed">
                          {selectedJob.about_company}
                        </p>
                      </section>
                    )}

                    <p className="text-xs text-slate-400 pt-3 border-t border-slate-100">
                      Parsed on {formatDate(selectedJob.created_at)}
                    </p>
                  </div>
                )}
              </TabsContent>

              {/* Candidates tab */}
              <TabsContent
                value="candidates"
                className="flex-1 overflow-y-auto p-5 m-0 data-[state=inactive]:hidden"
              >
                {searching ? (
                  <div className="flex flex-col items-center justify-center h-64 gap-3">
                    <Loader2Icon className="w-8 h-8 text-blue-600 animate-spin" />
                    <p className="text-slate-500 text-sm">Running AI-powered candidate matching…</p>
                  </div>
                ) : results === null ? (
                  <div className="flex flex-col items-center justify-center h-64 gap-4 text-center">
                    <div className="w-14 h-14 rounded-2xl bg-blue-50 flex items-center justify-center">
                      <UsersIcon className="w-7 h-7 text-blue-500" />
                    </div>
                    <div>
                      <p className="font-semibold text-slate-700 mb-1">No candidates matched yet</p>
                      <p className="text-slate-400 text-sm max-w-[240px]">
                        Click "Find Candidates" to run AI scoring and ranking.
                      </p>
                    </div>
                    <Button
                      onClick={handleFindCandidates}
                      className="bg-blue-600 hover:bg-blue-500 text-white gap-2"
                    >
                      <SparklesIcon className="w-4 h-4" />
                      Find Candidates
                    </Button>
                  </div>
                ) : results.length === 0 ? (
                  <div className="flex flex-col items-center justify-center h-64 gap-3 text-center">
                    <UsersIcon className="w-10 h-10 text-slate-300" />
                    <p className="text-slate-500 font-medium">No candidates matched.</p>
                    <p className="text-slate-400 text-xs">
                      Ensure candidates have complete profiles with relevant skills.
                    </p>
                  </div>
                ) : (
                  <div className="space-y-3">
                    <p className="text-xs text-slate-500 font-medium">
                      {results.length} candidate{results.length !== 1 ? "s" : ""} ranked by AI match score
                    </p>
                    {results.map((result, idx) => {
                      const isExpanded = expandedReason === result.rank;
                      const color = rankColors[idx] ?? "text-slate-500";
                      const bg = rankBgClass[idx] ?? "bg-white border-slate-200";

                      return (
                        <div
                          key={result.candidate.id}
                          className={`bg-white border rounded-xl shadow-sm overflow-hidden ${idx < 3 ? bg : "border-slate-200"}`}
                        >
                          <div className="p-4">
                            <div className="flex items-start gap-3">
                              {/* Rank */}
                              <div className={`text-2xl font-black flex-shrink-0 w-8 text-center ${color}`}>
                                #{result.rank}
                              </div>

                              {/* Content */}
                              <div className="flex-1 min-w-0">
                                <div className="flex items-start justify-between gap-2 mb-1">
                                  <div className="min-w-0">
                                    <h3 className="text-slate-900 font-semibold text-sm leading-snug">
                                      {result.candidate.full_name}
                                      {idx === 0 && (
                                        <TrophyIcon className="inline w-3.5 h-3.5 text-amber-500 ml-1.5 mb-0.5" />
                                      )}
                                    </h3>
                                    {result.candidate.current_title && (
                                      <p className="text-slate-500 text-xs flex items-center gap-1 mt-0.5">
                                        <BriefcaseIcon className="w-3 h-3 flex-shrink-0" />
                                        <span className="truncate">{result.candidate.current_title}</span>
                                      </p>
                                    )}
                                  </div>
                                  <ScoreCircle score={result.scores.overall} />
                                </div>

                                {/* Score bars */}
                                <div className="grid grid-cols-3 gap-2 mt-2 mb-3">
                                  <ScoreBar label="Skills" value={result.scores.skill_match} />
                                  <ScoreBar label="Experience" value={result.scores.experience_match} />
                                  <ScoreBar label="Similarity" value={result.scores.similarity} />
                                </div>

                                {/* Skill badges */}
                                <div className="space-y-1.5 mb-3">
                                  {result.matched_skills.length > 0 && (
                                    <div className="flex flex-wrap gap-1">
                                      {result.matched_skills.slice(0, 6).map((skill) => (
                                        <Badge
                                          key={skill}
                                          className="bg-emerald-50 text-emerald-700 border-emerald-200 text-xs px-1.5"
                                          variant="outline"
                                        >
                                          {skill}
                                        </Badge>
                                      ))}
                                      {result.matched_skills.length > 6 && (
                                        <Badge
                                          className="bg-slate-100 text-slate-500 border-slate-200 text-xs px-1.5"
                                          variant="outline"
                                        >
                                          +{result.matched_skills.length - 6}
                                        </Badge>
                                      )}
                                    </div>
                                  )}
                                  {result.missing_skills.length > 0 && (
                                    <div className="flex flex-wrap gap-1">
                                      {result.missing_skills.slice(0, 4).map((skill) => (
                                        <Badge
                                          key={skill}
                                          className="bg-red-50 text-red-600 border-red-200 text-xs px-1.5"
                                          variant="outline"
                                        >
                                          Missing: {skill}
                                        </Badge>
                                      ))}
                                    </div>
                                  )}
                                </div>

                                {/* Actions */}
                                <div className="flex gap-2">
                                  <Link href={`/sourcer/candidates/${result.candidate.id}`} target="_blank">
                                    <Button
                                      size="sm"
                                      className="bg-blue-600 hover:bg-blue-500 text-white text-xs h-7 gap-1 px-2.5"
                                    >
                                      <ExternalLinkIcon className="w-3 h-3" />
                                      Profile
                                    </Button>
                                  </Link>
                                  {result.ai_reasoning && (
                                    <Button
                                      variant="outline"
                                      size="sm"
                                      className="border-slate-200 text-slate-600 text-xs h-7 gap-1 px-2.5"
                                      onClick={() =>
                                        setExpandedReason(isExpanded ? null : result.rank)
                                      }
                                    >
                                      AI Reasoning
                                      {isExpanded ? (
                                        <ChevronUpIcon className="w-3 h-3" />
                                      ) : (
                                        <ChevronDownIcon className="w-3 h-3" />
                                      )}
                                    </Button>
                                  )}
                                </div>

                                {/* AI reasoning accordion */}
                                {isExpanded && result.ai_reasoning && (
                                  <div className="mt-3 pt-3 border-t border-slate-100">
                                    <p className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-1.5">
                                      AI Reasoning
                                    </p>
                                    <p className="text-slate-600 text-xs leading-relaxed bg-slate-50 rounded-lg p-2.5 border border-slate-200">
                                      {result.ai_reasoning}
                                    </p>
                                  </div>
                                )}
                              </div>
                            </div>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                )}
              </TabsContent>
            </Tabs>
          </div>
        )}
      </div>
    </div>
  );
}
