"use client";

import { useState, useEffect, useCallback } from "react";
import { use } from "react";
import Link from "next/link";
import { toast } from "sonner";
import {
  Loader2Icon,
  ChevronLeftIcon,
  MapPinIcon,
  PhoneIcon,
  Link2Icon,
  MailIcon,
  BriefcaseIcon,
  GraduationCapIcon,
  AwardIcon,
  CalendarIcon,
  AlertCircleIcon,
  CheckCircleIcon,
  BuildingIcon,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Separator } from "@/components/ui/separator";
import { sourcingApi, Candidate, CandidateSkill } from "@/lib/api";

function formatDate(dateStr?: string) {
  if (!dateStr) return "";
  return new Date(dateStr).toLocaleDateString("en-US", { month: "short", year: "numeric" });
}

function isExpired(dateStr?: string) {
  if (!dateStr) return false;
  return new Date(dateStr) < new Date();
}

const proficiencyConfig: Record<string, { className: string }> = {
  Advanced: { className: "bg-emerald-100 text-emerald-700 border-emerald-200" },
  Intermediate: { className: "bg-amber-100 text-amber-700 border-amber-200" },
  Beginner: { className: "bg-slate-100 text-slate-600 border-slate-200" },
};

const skillTypeOrder: Record<string, number> = { Primary: 0, Secondary: 1, Tertiary: 2 };

function groupSkills(skills: CandidateSkill[]) {
  const groups: Record<string, CandidateSkill[]> = { Primary: [], Secondary: [], Tertiary: [] };
  for (const s of skills) {
    if (groups[s.skill_type]) groups[s.skill_type].push(s);
    else groups["Tertiary"].push(s);
  }
  return Object.entries(groups)
    .filter(([, v]) => v.length > 0)
    .sort(([a], [b]) => skillTypeOrder[a] - skillTypeOrder[b]);
}

export default function CandidateProfilePage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = use(params);
  const [candidate, setCandidate] = useState<Candidate | null>(null);
  const [loading, setLoading] = useState(true);

  const fetchCandidate = useCallback(async () => {
    setLoading(true);
    try {
      const res = await sourcingApi.getCandidate(parseInt(id));
      setCandidate(res.data.data ?? res.data);
    } catch {
      toast.error("Failed to load candidate profile.");
    } finally {
      setLoading(false);
    }
  }, [id]);

  useEffect(() => {
    fetchCandidate();
  }, [fetchCandidate]);

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <Loader2Icon className="w-8 h-8 text-blue-600 animate-spin" />
      </div>
    );
  }

  if (!candidate) {
    return (
      <div className="p-6 text-center">
        <p className="text-slate-500">Candidate not found.</p>
        <Link href="/sourcer/candidates">
          <Button variant="outline" className="mt-4 border-slate-300">
            <ChevronLeftIcon className="w-4 h-4 mr-2" />
            Back to candidates
          </Button>
        </Link>
      </div>
    );
  }

  const skillGroups = groupSkills(candidate.skills ?? []);
  const location = [candidate.city, candidate.country].filter(Boolean).join(", ");
  const initials = candidate.full_name
    .split(" ")
    .slice(0, 2)
    .map((n) => n[0])
    .join("")
    .toUpperCase();

  return (
    <div className="p-6 max-w-5xl mx-auto space-y-6">
      {/* Back */}
      <Link href="/sourcer/candidates">
        <Button variant="ghost" size="sm" className="text-slate-500 hover:text-slate-800 -ml-2 gap-1">
          <ChevronLeftIcon className="w-4 h-4" />
          All candidates
        </Button>
      </Link>

      {/* Profile header */}
      <Card className="border-slate-200 bg-white shadow-sm">
        <CardContent className="p-6">
          <div className="flex flex-col sm:flex-row gap-5 items-start">
            <div className="w-16 h-16 rounded-2xl bg-blue-600 flex items-center justify-center text-white font-bold text-xl flex-shrink-0">
              {initials}
            </div>
            <div className="flex-1 min-w-0">
              <h1 className="text-2xl font-bold text-slate-900">{candidate.full_name}</h1>
              {candidate.current_title && (
                <p className="text-slate-600 font-medium mt-0.5">{candidate.current_title}</p>
              )}

              <div className="flex flex-wrap gap-4 mt-3 text-sm text-slate-500">
                {location && (
                  <span className="flex items-center gap-1.5">
                    <MapPinIcon className="w-4 h-4" /> {location}
                  </span>
                )}
                {candidate.email && (
                  <span className="flex items-center gap-1.5">
                    <span className="text-slate-400">@</span> {candidate.email}
                  </span>
                )}
                {candidate.phone && (
                  <span className="flex items-center gap-1.5">
                    <PhoneIcon className="w-4 h-4" /> {candidate.phone}
                  </span>
                )}
              </div>

              <div className="flex gap-3 mt-3">
                {candidate.linkedin_url && (
                  <a
                    href={candidate.linkedin_url}
                    target="_blank"
                    rel="noreferrer"
                    className="flex items-center gap-1.5 text-blue-600 hover:text-blue-700 text-sm font-medium"
                  >
                    <Link2Icon className="w-4 h-4" /> LinkedIn
                  </a>
                )}
                {candidate.github_url && (
                  <a
                    href={candidate.github_url}
                    target="_blank"
                    rel="noreferrer"
                    className="flex items-center gap-1.5 text-slate-700 hover:text-slate-900 text-sm font-medium"
                  >
                    <Link2Icon className="w-4 h-4" /> GitHub
                  </a>
                )}
              </div>
            </div>

            <div className="flex gap-3 sm:flex-col flex-shrink-0">
              {[
                { label: "Skills", value: candidate.skills?.length ?? 0 },
                { label: "Experiences", value: candidate.work_experiences?.length ?? 0 },
                { label: "Certifications", value: candidate.certifications?.length ?? 0 },
              ].map((s) => (
                <div key={s.label} className="text-center">
                  <p className="text-2xl font-bold text-slate-900">{s.value}</p>
                  <p className="text-xs text-slate-400">{s.label}</p>
                </div>
              ))}
            </div>
          </div>

          {candidate.about_me && (
            <>
              <Separator className="my-4 bg-slate-100" />
              <div>
                <p className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-2">About</p>
                <p className="text-slate-600 text-sm leading-relaxed">{candidate.about_me}</p>
              </div>
            </>
          )}
        </CardContent>
      </Card>

      {/* Skills */}
      {skillGroups.length > 0 && (
        <Card className="border-slate-200 bg-white shadow-sm">
          <CardHeader className="pb-3">
            <CardTitle className="text-slate-800 text-base flex items-center gap-2">
              Skills
              <Badge className="bg-blue-50 text-blue-700 border-blue-100">
                {candidate.skills?.length ?? 0} total
              </Badge>
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-5">
            {skillGroups.map(([type, skills]) => (
              <div key={type}>
                <p className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-2">
                  {type}
                </p>
                <div className="overflow-x-auto">
                  <table className="w-full text-sm">
                    <thead>
                      <tr className="border-b border-slate-100">
                        <th className="text-left text-xs text-slate-500 font-medium pb-2 pr-4">Skill</th>
                        <th className="text-left text-xs text-slate-500 font-medium pb-2 pr-4">Category</th>
                        <th className="text-left text-xs text-slate-500 font-medium pb-2 pr-4">Proficiency</th>
                        <th className="text-left text-xs text-slate-500 font-medium pb-2 pr-4">Exp.</th>
                        <th className="text-left text-xs text-slate-500 font-medium pb-2">Last used</th>
                      </tr>
                    </thead>
                    <tbody>
                      {skills.map((skill) => (
                        <tr key={skill.name} className="border-b border-slate-50 hover:bg-slate-50">
                          <td className="py-2 pr-4 font-medium text-slate-800">{skill.name}</td>
                          <td className="py-2 pr-4 text-slate-500">{skill.category}</td>
                          <td className="py-2 pr-4">
                            <Badge
                              className={`text-xs border ${proficiencyConfig[skill.proficiency]?.className ?? ""}`}
                              variant="outline"
                            >
                              {skill.proficiency}
                            </Badge>
                          </td>
                          <td className="py-2 pr-4 text-slate-500">{skill.years_of_exp}y</td>
                          <td className="py-2 text-slate-500">{skill.year_last_used ?? "—"}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            ))}
          </CardContent>
        </Card>
      )}

      {/* Work history */}
      {(candidate.work_experiences?.length ?? 0) > 0 && (
        <Card className="border-slate-200 bg-white shadow-sm">
          <CardHeader className="pb-3">
            <CardTitle className="text-slate-800 text-base flex items-center gap-2">
              <BriefcaseIcon className="w-4 h-4 text-slate-500" />
              Work History
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            {candidate.work_experiences.map((exp, i) => (
              <div key={`${exp.company_name}-${exp.start_date}`}>
                {i > 0 && <Separator className="mb-4 bg-slate-100" />}
                <div className="flex items-start gap-4">
                  <div className="w-10 h-10 rounded-lg bg-slate-100 flex items-center justify-center flex-shrink-0">
                    <BuildingIcon className="w-5 h-5 text-slate-500" />
                  </div>
                  <div className="flex-1">
                    <div className="flex flex-wrap items-center gap-2 mb-0.5">
                      <h3 className="text-slate-900 font-semibold text-sm">{exp.job_title}</h3>
                      {exp.work_status === 1 && (
                        <Badge className="bg-emerald-100 text-emerald-700 border-emerald-200 text-xs">
                          Current
                        </Badge>
                      )}
                    </div>
                    <p className="text-slate-600 text-sm">{exp.company_name}</p>
                    <p className="text-slate-400 text-xs mt-1 flex items-center gap-1">
                      <CalendarIcon className="w-3 h-3" />
                      {formatDate(exp.start_date)} –{" "}
                      {exp.work_status === 1 ? "Present" : formatDate(exp.end_date)}
                      {exp.location && ` · ${exp.location}`}
                    </p>
                    {exp.description && (
                      <p className="text-slate-500 text-sm mt-2 leading-relaxed">{exp.description}</p>
                    )}
                    {exp.projects?.length > 0 && (
                      <div className="mt-3 space-y-2">
                        <p className="text-xs font-semibold text-slate-400 uppercase tracking-wider">
                          Projects
                        </p>
                        {exp.projects.map((proj) => (
                          <div
                            key={proj.project_name}
                            className="bg-slate-50 border border-slate-200 rounded-lg p-3"
                          >
                            <p className="text-slate-800 font-medium text-xs">{proj.project_name}</p>
                            {proj.description && (
                              <p className="text-slate-500 text-xs mt-0.5 leading-relaxed">
                                {proj.description}
                              </p>
                            )}
                            {proj.skills_used && (
                              <p className="text-slate-400 text-xs mt-1">Skills: {proj.skills_used}</p>
                            )}
                          </div>
                        ))}
                      </div>
                    )}
                  </div>
                </div>
              </div>
            ))}
          </CardContent>
        </Card>
      )}

      {/* Education */}
      {(candidate.educations?.length ?? 0) > 0 && (
        <Card className="border-slate-200 bg-white shadow-sm">
          <CardHeader className="pb-3">
            <CardTitle className="text-slate-800 text-base flex items-center gap-2">
              <GraduationCapIcon className="w-4 h-4 text-slate-500" />
              Education
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            {candidate.educations.map((edu, i) => (
              <div key={`${edu.school_name}-${edu.start_date}`}>
                {i > 0 && <Separator className="mb-4 bg-slate-100" />}
                <div className="flex items-start gap-4">
                  <div className="w-10 h-10 rounded-lg bg-purple-50 flex items-center justify-center flex-shrink-0">
                    <GraduationCapIcon className="w-5 h-5 text-purple-500" />
                  </div>
                  <div>
                    <h3 className="text-slate-900 font-semibold text-sm">{edu.school_name}</h3>
                    {(edu.degree_obtained || edu.field_of_study) && (
                      <p className="text-slate-600 text-sm">
                        {[edu.degree_obtained, edu.field_of_study].filter(Boolean).join(" · ")}
                      </p>
                    )}
                    <p className="text-slate-400 text-xs mt-1 flex items-center gap-1">
                      <CalendarIcon className="w-3 h-3" />
                      {formatDate(edu.start_date)} –{" "}
                      {edu.still_studying ? "Present" : formatDate(edu.end_date)}
                    </p>
                    {edu.description && (
                      <p className="text-slate-500 text-xs mt-1.5">{edu.description}</p>
                    )}
                  </div>
                </div>
              </div>
            ))}
          </CardContent>
        </Card>
      )}

      {/* Certifications */}
      {(candidate.certifications?.length ?? 0) > 0 && (
        <Card className="border-slate-200 bg-white shadow-sm">
          <CardHeader className="pb-3">
            <CardTitle className="text-slate-800 text-base flex items-center gap-2">
              <AwardIcon className="w-4 h-4 text-slate-500" />
              Certifications
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid sm:grid-cols-2 gap-3">
              {candidate.certifications.map((cert) => {
                const expired = isExpired(cert.expiry_date);
                return (
                  <div
                    key={cert.certificate_name}
                    className={`border rounded-lg p-4 ${
                      expired ? "border-red-200 bg-red-50/30" : "border-slate-200 bg-white"
                    }`}
                  >
                    <div className="flex items-start gap-2">
                      <AwardIcon
                        className={`w-4 h-4 flex-shrink-0 mt-0.5 ${
                          expired ? "text-red-400" : "text-amber-500"
                        }`}
                      />
                      <div className="flex-1 min-w-0">
                        <p className="text-slate-800 font-medium text-sm truncate">
                          {cert.certificate_name}
                        </p>
                        {cert.issuing_org && (
                          <p className="text-slate-500 text-xs">{cert.issuing_org}</p>
                        )}
                        <div className="flex items-center gap-2 mt-1.5 flex-wrap">
                          {cert.issue_date && (
                            <span className="text-slate-400 text-xs flex items-center gap-0.5">
                              <CalendarIcon className="w-3 h-3" />
                              {formatDate(cert.issue_date)}
                            </span>
                          )}
                          {cert.expiry_date ? (
                            expired ? (
                              <Badge className="text-xs bg-red-100 text-red-700 border-red-200 flex items-center gap-0.5">
                                <AlertCircleIcon className="w-3 h-3" />
                                Expired {formatDate(cert.expiry_date)}
                              </Badge>
                            ) : (
                              <Badge className="text-xs bg-emerald-100 text-emerald-700 border-emerald-200 flex items-center gap-0.5">
                                <CheckCircleIcon className="w-3 h-3" />
                                Valid until {formatDate(cert.expiry_date)}
                              </Badge>
                            )
                          ) : (
                            <Badge className="text-xs bg-slate-100 text-slate-500 border-slate-200">
                              No expiry
                            </Badge>
                          )}
                        </div>
                      </div>
                    </div>
                  </div>
                );
              })}
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
