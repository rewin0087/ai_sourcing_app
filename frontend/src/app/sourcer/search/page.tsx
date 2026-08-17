"use client";

import { useState, useCallback, useEffect } from "react";
import { toast } from "sonner";
import {
  SearchIcon,
  Loader2Icon,
  UploadCloudIcon,
  FileTextIcon,
  XIcon,
  ChevronDownIcon,
  ChevronUpIcon,
  TrophyIcon,
  MapPinIcon,
  BriefcaseIcon,
  UserIcon,
  ExternalLinkIcon,
} from "lucide-react";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Progress } from "@/components/ui/progress";
import { sourcingApi, MatchResult } from "@/lib/api";

const rankColors = ["text-amber-500", "text-slate-400", "text-amber-700"];
const rankBg = ["bg-amber-50 border-amber-200", "bg-slate-50 border-slate-200", "bg-amber-50/60 border-amber-100"];

function ScoreCircle({ score }: { score: number }) {
  const color = score >= 70 ? "text-emerald-600" : score >= 50 ? "text-amber-600" : "text-red-500";
  const display = Number.isInteger(score) ? score : score.toFixed(1);
  return (
    <div className="flex flex-col items-center gap-1">
      <div className={`text-2xl font-bold ${color}`}>{display}%</div>
      <div className="w-20">
        <Progress value={score} className="h-1.5" />
      </div>
      <span className="text-xs text-slate-400">overall</span>
    </div>
  );
}

export default function SourcerSearchPage() {
  const [tab, setTab] = useState<"text" | "file">("text");
  const [jdText, setJdText] = useState("");
  const [file, setFile] = useState<File | null>(null);

  useEffect(() => {
    const prefilled = localStorage.getItem("prefilled_jd");
    if (prefilled) {
      setJdText(prefilled);
      setTab("text");
      localStorage.removeItem("prefilled_jd");
    }
  }, []);
  const [dragging, setDragging] = useState(false);
  const [loading, setLoading] = useState(false);
  const [results, setResults] = useState<MatchResult[] | null>(null);
  const [expanded, setExpanded] = useState<number | null>(null);

  const handleDrop = useCallback((e: React.DragEvent) => {
    e.preventDefault();
    setDragging(false);
    const dropped = e.dataTransfer.files[0];
    if (dropped && (dropped.type === "application/pdf" || dropped.type === "text/plain")) {
      setFile(dropped);
    } else {
      toast.error("Only PDF or TXT files are supported.");
    }
  }, []);

  async function handleSearch() {
    if (tab === "text" && !jdText.trim()) {
      toast.error("Please paste a job description.");
      return;
    }
    if (tab === "file" && !file) {
      toast.error("Please upload a job description file.");
      return;
    }

    setLoading(true);
    setResults(null);
    try {
      // Step 1: Parse the JD
      const parseRes = await sourcingApi.parseJob(
        tab === "text" ? jdText : undefined,
        tab === "file" ? file! : undefined
      );
      const jobId: number = parseRes.data.data?.id ?? parseRes.data.id;
      toast.success("Job description parsed! Searching candidates…");

      // Step 2: Search candidates
      const searchRes = await sourcingApi.searchCandidates({
        job_description_id: jobId,
        limit: 20,
      });
      const matches: MatchResult[] = searchRes.data.data?.candidates ?? [];
      setResults(matches);
      if (matches.length === 0) {
        toast.info("No matching candidates found.");
      } else {
        toast.success(`Found ${matches.length} matched candidate${matches.length !== 1 ? "s" : ""}.`);
      }
    } catch {
      toast.error("Search failed. Please try again.");
    } finally {
      setLoading(false);
    }
  }

  function handleRemoveFile() {
    setFile(null);
  }

  return (
    <div className="p-6 max-w-5xl mx-auto space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-slate-900">Find Candidates</h1>
        <p className="text-slate-500 text-sm mt-1">
          Paste or upload a job description to find AI-matched candidates.
        </p>
      </div>

      {/* Input card */}
      <Card className="border-slate-200 bg-white shadow-sm">
        <CardHeader className="pb-3">
          <CardTitle className="text-slate-800 text-base">Job Description</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <Tabs value={tab} onValueChange={(v) => setTab(v as "text" | "file")}>
            <TabsList className="bg-slate-100 border border-slate-200">
              <TabsTrigger value="text" className="data-[state=active]:bg-white data-[state=active]:shadow-sm">
                Paste text
              </TabsTrigger>
              <TabsTrigger value="file" className="data-[state=active]:bg-white data-[state=active]:shadow-sm">
                Upload file
              </TabsTrigger>
            </TabsList>

            <TabsContent value="text" className="mt-3">
              <Textarea
                rows={10}
                value={jdText}
                onChange={(e) => setJdText(e.target.value)}
                placeholder="Paste the full job description here…&#10;&#10;We are looking for a Senior Software Engineer with 5+ years of experience in React, Node.js, and AWS…"
                className="border-slate-300 resize-none font-mono text-sm"
              />
              <p className="text-slate-400 text-xs mt-1.5">
                {jdText.length} characters
              </p>
            </TabsContent>

            <TabsContent value="file" className="mt-3">
              {!file ? (
                <label
                  htmlFor="jd-file"
                  onDragOver={(e) => { e.preventDefault(); setDragging(true); }}
                  onDragLeave={() => setDragging(false)}
                  onDrop={handleDrop}
                  className={`flex flex-col items-center justify-center border-2 border-dashed rounded-xl p-10 cursor-pointer transition-all ${
                    dragging
                      ? "border-blue-400 bg-blue-50"
                      : "border-slate-300 hover:border-blue-400 hover:bg-slate-50"
                  }`}
                >
                  <UploadCloudIcon className={`w-10 h-10 mb-3 ${dragging ? "text-blue-500" : "text-slate-400"}`} />
                  <p className="text-slate-700 font-medium text-sm">
                    {dragging ? "Drop here" : "Drag & drop or click to upload"}
                  </p>
                  <p className="text-slate-400 text-xs mt-1">PDF or TXT, max 10 MB</p>
                  <input
                    id="jd-file"
                    type="file"
                    accept=".pdf,.txt"
                    className="hidden"
                    onChange={(e) => { const f = e.target.files?.[0]; if (f) setFile(f); }}
                  />
                </label>
              ) : (
                <div className="flex items-center gap-3 border border-slate-200 rounded-xl p-4">
                  <div className="w-10 h-10 bg-blue-50 rounded-lg flex items-center justify-center flex-shrink-0">
                    <FileTextIcon className="w-5 h-5 text-blue-600" />
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="text-slate-800 text-sm font-medium truncate">{file.name}</p>
                    <p className="text-slate-400 text-xs">
                      {file.size > 1_000_000
                        ? `${(file.size / 1_000_000).toFixed(1)} MB`
                        : `${(file.size / 1_000).toFixed(0)} KB`}
                    </p>
                  </div>
                  <Button variant="ghost" size="icon" className="text-slate-400 hover:text-red-500" onClick={handleRemoveFile}>
                    <XIcon className="w-4 h-4" />
                  </Button>
                </div>
              )}
            </TabsContent>
          </Tabs>

          <div className="flex justify-end">
            <Button
              onClick={handleSearch}
              disabled={loading}
              className="bg-blue-600 hover:bg-blue-500 text-white px-6"
            >
              {loading ? (
                <>
                  <Loader2Icon className="w-4 h-4 mr-2 animate-spin" />
                  Searching…
                </>
              ) : (
                <>
                  <SearchIcon className="w-4 h-4 mr-2" />
                  Parse &amp; Search
                </>
              )}
            </Button>
          </div>
        </CardContent>
      </Card>

      {/* Results */}
      {loading && (
        <div className="flex flex-col items-center justify-center py-16 gap-3">
          <Loader2Icon className="w-8 h-8 text-blue-600 animate-spin" />
          <p className="text-slate-500 text-sm">Parsing job description and matching candidates…</p>
        </div>
      )}

      {results !== null && !loading && (
        <div className="space-y-4">
          <div className="flex items-center justify-between">
            <h2 className="text-lg font-semibold text-slate-800">
              {results.length} Candidate{results.length !== 1 ? "s" : ""} matched
            </h2>
          </div>

          {results.length === 0 ? (
            <div className="bg-white border border-slate-200 rounded-xl p-16 flex flex-col items-center shadow-sm">
              <UserIcon className="w-10 h-10 text-slate-300 mb-3" />
              <p className="text-slate-500">No candidates matched this job description.</p>
              <p className="text-slate-400 text-xs mt-1">Try broadening the requirements or ensure candidates have complete profiles.</p>
            </div>
          ) : (
            results.map((result, idx) => {
              const rankColor = rankColors[idx] ?? "text-slate-500";
              const rankBgClass = rankBg[idx] ?? "bg-white border-slate-200";
              const overallPct = result.scores.overall;
              const isExpanded = expanded === result.rank;

              return (
                <div
                  key={result.candidate.id}
                  className={`bg-white border rounded-xl shadow-sm overflow-hidden transition-all ${idx < 3 ? rankBgClass : "border-slate-200"}`}
                >
                  <div className="p-5">
                    <div className="flex flex-col sm:flex-row sm:items-start gap-4">
                      {/* Rank badge */}
                      <div className="flex sm:flex-col items-center gap-3 sm:gap-1 flex-shrink-0">
                        <div className={`text-3xl font-black ${rankColor}`}>
                          #{result.rank}
                        </div>
                        {idx < 3 && <TrophyIcon className={`w-4 h-4 ${rankColor} hidden sm:block`} />}
                      </div>

                      {/* Candidate info */}
                      <div className="flex-1 min-w-0">
                        <div className="flex flex-wrap items-center gap-2 mb-1">
                          <h3 className="text-slate-900 font-semibold text-base">
                            {result.candidate.full_name}
                          </h3>
                          {idx === 0 && (
                            <Badge className="bg-amber-100 text-amber-700 border-amber-200 text-xs">
                              Top Match
                            </Badge>
                          )}
                        </div>

                        {result.candidate.current_title && (
                          <div className="flex items-center gap-1.5 text-slate-600 text-sm mb-1">
                            <BriefcaseIcon className="w-3.5 h-3.5" />
                            {result.candidate.current_title}
                          </div>
                        )}
                        {result.candidate.location && (
                          <div className="flex items-center gap-1.5 text-slate-500 text-xs mb-3">
                            <MapPinIcon className="w-3 h-3" />
                            {result.candidate.location}
                          </div>
                        )}

                        {/* Score bars */}
                        <div className="grid grid-cols-3 gap-3 mb-3">
                          {[
                            { label: "Skills", val: result.scores.skill_match },
                            { label: "Experience", val: result.scores.experience_match },
                            { label: "Similarity", val: result.scores.similarity },
                          ].map((s) => {
                            const display = Number.isInteger(s.val) ? s.val : s.val.toFixed(1);
                            return (
                              <div key={s.label}>
                                <div className="flex justify-between text-xs text-slate-500 mb-0.5">
                                  <span>{s.label}</span>
                                  <span className="font-medium">{display}%</span>
                                </div>
                                <Progress value={s.val} className="h-1" />
                              </div>
                            );
                          })}
                        </div>

                        {/* Skills chips */}
                        <div className="space-y-2">
                          {result.matched_skills.length > 0 && (
                            <div className="flex flex-wrap gap-1.5">
                              {result.matched_skills.slice(0, 8).map((skill) => (
                                <Badge
                                  key={skill}
                                  className="bg-emerald-50 text-emerald-700 border-emerald-200 text-xs"
                                  variant="outline"
                                >
                                  {skill}
                                </Badge>
                              ))}
                              {result.matched_skills.length > 8 && (
                                <Badge className="bg-slate-100 text-slate-500 border-slate-200 text-xs" variant="outline">
                                  +{result.matched_skills.length - 8} more
                                </Badge>
                              )}
                            </div>
                          )}
                          {result.missing_skills.length > 0 && (
                            <div className="flex flex-wrap gap-1.5">
                              {result.missing_skills.slice(0, 5).map((skill) => (
                                <Badge
                                  key={skill}
                                  className="bg-red-50 text-red-600 border-red-200 text-xs"
                                  variant="outline"
                                >
                                  Missing: {skill}
                                </Badge>
                              ))}
                            </div>
                          )}
                        </div>
                      </div>

                      {/* Score + actions */}
                      <div className="flex sm:flex-col items-center gap-4 flex-shrink-0">
                        <ScoreCircle score={result.scores.overall} />
                        <div className="flex gap-2 sm:flex-col">
                          <Link href={`/sourcer/candidates/${result.candidate.id}`} target="_blank">
                            <Button
                              size="sm"
                              className="bg-blue-600 hover:bg-blue-500 text-white text-xs gap-1"
                            >
                              <ExternalLinkIcon className="w-3 h-3" />
                              Full profile
                            </Button>
                          </Link>
                          {result.ai_reasoning && (
                            <Button
                              variant="outline"
                              size="sm"
                              className="border-slate-300 text-slate-600 text-xs gap-1"
                              onClick={() => setExpanded(isExpanded ? null : result.rank)}
                            >
                              AI reasoning
                              {isExpanded ? (
                                <ChevronUpIcon className="w-3 h-3" />
                              ) : (
                                <ChevronDownIcon className="w-3 h-3" />
                              )}
                            </Button>
                          )}
                        </div>
                      </div>
                    </div>

                    {/* AI Reasoning accordion */}
                    {isExpanded && result.ai_reasoning && (
                      <div className="mt-4 pt-4 border-t border-slate-100">
                        <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">
                          AI Reasoning
                        </p>
                        <p className="text-slate-600 text-sm leading-relaxed bg-slate-50 rounded-lg p-3 border border-slate-200">
                          {result.ai_reasoning}
                        </p>
                      </div>
                    )}
                  </div>
                </div>
              );
            })
          )}
        </div>
      )}
    </div>
  );
}
