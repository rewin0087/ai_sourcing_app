"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { toast } from "sonner";
import {
  WandSparklesIcon,
  Loader2Icon,
  SearchIcon,
  ChevronDownIcon,
  ChevronUpIcon,
  ClipboardCopyIcon,
  CheckIcon,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Separator } from "@/components/ui/separator";
import { sourcingApi, RefinedJobDescription } from "@/lib/api";

const EXAMPLE_NARRATIVES = [
  "Looking for a senior developer who knows React and Node.js, needs to be able to work with REST APIs and databases. Should have some cloud experience preferably AWS. Will be building our customer-facing web app.",
  "We need a data scientist to help us understand our user data. They should know Python and machine learning. Would be nice if they have experience with NLP. Remote friendly.",
];

function SectionBlock({ title, content }: { title: string; content: string }) {
  const [open, setOpen] = useState(true);
  return (
    <div className="border border-slate-200 rounded-lg overflow-hidden">
      <button
        onClick={() => setOpen((v) => !v)}
        className="w-full flex items-center justify-between px-4 py-3 bg-slate-50 text-sm font-semibold text-slate-700 hover:bg-slate-100 transition-colors"
      >
        {title}
        {open ? <ChevronUpIcon className="w-4 h-4 text-slate-400" /> : <ChevronDownIcon className="w-4 h-4 text-slate-400" />}
      </button>
      {open && (
        <div className="px-4 py-3 text-sm text-slate-600 leading-relaxed whitespace-pre-wrap bg-white">
          {content}
        </div>
      )}
    </div>
  );
}

export default function RefineJDPage() {
  const router = useRouter();
  const [narrative, setNarrative] = useState("");
  const [loading, setLoading] = useState(false);
  const [refined, setRefined] = useState<RefinedJobDescription | null>(null);
  const [copied, setCopied] = useState(false);

  async function handleRefine() {
    if (!narrative.trim()) {
      toast.error("Please enter a job description narrative.");
      return;
    }

    setLoading(true);
    setRefined(null);
    try {
      const res = await sourcingApi.refineJob(narrative);
      const data = res.data?.data ?? res.data;
      setRefined(data as RefinedJobDescription);
      toast.success("Job description refined successfully!");
    } catch {
      toast.error("Failed to refine job description. Please try again.");
    } finally {
      setLoading(false);
    }
  }

  function handleFindCandidates() {
    if (!refined?.formatted_text) return;
    localStorage.setItem("prefilled_jd", refined.formatted_text);
    router.push("/sourcer/search");
  }

  async function handleCopy() {
    if (!refined?.formatted_text) return;
    await navigator.clipboard.writeText(refined.formatted_text);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
    toast.success("Copied to clipboard!");
  }

  const experienceBadge: Record<string, string> = {
    entry: "bg-green-50 text-green-700 border-green-200",
    mid: "bg-blue-50 text-blue-700 border-blue-200",
    senior: "bg-purple-50 text-purple-700 border-purple-200",
    lead: "bg-amber-50 text-amber-700 border-amber-200",
  };

  return (
    <div className="p-6 max-w-4xl mx-auto space-y-6">
      <div>
        <div className="flex items-center gap-2 mb-1">
          <WandSparklesIcon className="w-5 h-5 text-violet-600" />
          <h1 className="text-2xl font-bold text-slate-900">Refine Job Description</h1>
        </div>
        <p className="text-slate-500 text-sm">
          Paste a simple narrative and AI will expand it into a structured, detailed job description ready for candidate search.
        </p>
      </div>

      {/* Input */}
      <Card className="border-slate-200 bg-white shadow-sm">
        <CardHeader className="pb-3">
          <CardTitle className="text-slate-800 text-base">Narrative Input</CardTitle>
        </CardHeader>
        <CardContent className="space-y-3">
          <Textarea
            rows={8}
            value={narrative}
            onChange={(e) => setNarrative(e.target.value)}
            placeholder="Describe the role in plain language…&#10;&#10;e.g. Looking for a senior developer who knows React and Node.js, needs to work with REST APIs and AWS. Will be building our customer-facing web app."
            className="border-slate-300 resize-none text-sm"
          />
          <div className="flex flex-wrap items-center gap-2">
            <span className="text-xs text-slate-400">Try an example:</span>
            {EXAMPLE_NARRATIVES.map((ex, i) => (
              <button
                key={i}
                onClick={() => setNarrative(ex)}
                className="text-xs text-violet-600 hover:text-violet-800 underline underline-offset-2"
              >
                Example {i + 1}
              </button>
            ))}
          </div>
          <div className="flex justify-between items-center">
            <span className="text-xs text-slate-400">{narrative.length} characters</span>
            <Button
              onClick={handleRefine}
              disabled={loading}
              className="bg-violet-600 hover:bg-violet-500 text-white px-6"
            >
              {loading ? (
                <>
                  <Loader2Icon className="w-4 h-4 mr-2 animate-spin" />
                  Refining…
                </>
              ) : (
                <>
                  <WandSparklesIcon className="w-4 h-4 mr-2" />
                  Refine with AI
                </>
              )}
            </Button>
          </div>
        </CardContent>
      </Card>

      {/* Loading state */}
      {loading && (
        <div className="flex flex-col items-center justify-center py-16 gap-3">
          <Loader2Icon className="w-8 h-8 text-violet-600 animate-spin" />
          <p className="text-slate-500 text-sm">AI is expanding your job description…</p>
        </div>
      )}

      {/* Refined output */}
      {refined && !loading && (
        <div className="space-y-4">
          {/* Header with actions */}
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
            <div>
              <h2 className="text-xl font-bold text-slate-900">{refined.title}</h2>
              <div className="flex flex-wrap items-center gap-2 mt-1">
                {refined.experience_level && (
                  <Badge
                    variant="outline"
                    className={experienceBadge[refined.experience_level] ?? "bg-slate-50 text-slate-700 border-slate-200"}
                  >
                    {refined.experience_level.charAt(0).toUpperCase() + refined.experience_level.slice(1)}-level
                  </Badge>
                )}
                {refined.employment_type && (
                  <Badge variant="outline" className="bg-slate-50 text-slate-700 border-slate-200">
                    {refined.employment_type}
                  </Badge>
                )}
              </div>
            </div>

            <div className="flex gap-2">
              <Button
                variant="outline"
                size="sm"
                onClick={handleCopy}
                className="border-slate-300 text-slate-600 gap-1.5"
              >
                {copied ? (
                  <>
                    <CheckIcon className="w-4 h-4 text-emerald-500" />
                    Copied
                  </>
                ) : (
                  <>
                    <ClipboardCopyIcon className="w-4 h-4" />
                    Copy text
                  </>
                )}
              </Button>
              <Button
                onClick={handleFindCandidates}
                className="bg-blue-600 hover:bg-blue-500 text-white gap-1.5"
              >
                <SearchIcon className="w-4 h-4" />
                Find Candidates
              </Button>
            </div>
          </div>

          {/* Structured sections */}
          <div className="space-y-3">
            {refined.summary && (
              <SectionBlock title="Job Summary" content={refined.summary} />
            )}
            {refined.responsibilities && (
              <SectionBlock title="Key Responsibilities" content={refined.responsibilities} />
            )}
            {refined.qualifications && (
              <SectionBlock title="Required Qualifications" content={refined.qualifications} />
            )}
            {refined.about_company && (
              <SectionBlock title="About the Company" content={refined.about_company} />
            )}
          </div>

          {/* Skills */}
          {(refined.required_skills.length > 0 || refined.preferred_skills.length > 0) && (
            <Card className="border-slate-200 bg-white shadow-sm">
              <CardHeader className="pb-2">
                <CardTitle className="text-slate-800 text-sm">Technical Skills</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                {refined.required_skills.length > 0 && (
                  <div>
                    <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">Required</p>
                    <div className="flex flex-wrap gap-2">
                      {refined.required_skills.map((skill, i) => (
                        <div key={i} className="flex items-center gap-1.5 bg-blue-50 border border-blue-200 rounded-full px-3 py-1">
                          <span className="text-sm font-medium text-blue-800">{skill.name}</span>
                          {skill.proficiency && (
                            <span className="text-xs text-blue-500">{skill.proficiency}</span>
                          )}
                          {skill.years_required > 0 && (
                            <span className="text-xs text-blue-400">{skill.years_required}yr+</span>
                          )}
                        </div>
                      ))}
                    </div>
                  </div>
                )}

                {refined.required_skills.length > 0 && refined.preferred_skills.length > 0 && (
                  <Separator className="bg-slate-100" />
                )}

                {refined.preferred_skills.length > 0 && (
                  <div>
                    <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">Preferred</p>
                    <div className="flex flex-wrap gap-2">
                      {refined.preferred_skills.map((skill, i) => (
                        <div key={i} className="flex items-center gap-1.5 bg-slate-50 border border-slate-200 rounded-full px-3 py-1">
                          <span className="text-sm font-medium text-slate-700">{skill.name}</span>
                          {skill.proficiency && (
                            <span className="text-xs text-slate-400">{skill.proficiency}</span>
                          )}
                          {skill.years_required > 0 && (
                            <span className="text-xs text-slate-400">{skill.years_required}yr+</span>
                          )}
                        </div>
                      ))}
                    </div>
                  </div>
                )}
              </CardContent>
            </Card>
          )}

          {/* CTA banner */}
          <div className="bg-blue-50 border border-blue-200 rounded-xl p-4 flex flex-col sm:flex-row items-center justify-between gap-3">
            <div>
              <p className="text-blue-800 font-semibold text-sm">Ready to find candidates?</p>
              <p className="text-blue-600 text-xs mt-0.5">
                This refined job description will be pre-filled in the candidate search form.
              </p>
            </div>
            <Button
              onClick={handleFindCandidates}
              className="bg-blue-600 hover:bg-blue-500 text-white gap-1.5 flex-shrink-0"
            >
              <SearchIcon className="w-4 h-4" />
              Find Candidates
            </Button>
          </div>
        </div>
      )}
    </div>
  );
}
