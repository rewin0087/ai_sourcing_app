"use client";

import { useState, useEffect, useCallback } from "react";
import Link from "next/link";
import { toast } from "sonner";
import {
  SearchIcon,
  Loader2Icon,
  UsersIcon,
  MapPinIcon,
  BriefcaseIcon,
  ChevronLeftIcon,
  ChevronRightIcon,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent } from "@/components/ui/card";
import { sourcingApi } from "@/lib/api";

type CandidateSummary = {
  id: number;
  full_name: string;
  current_title?: string;
  city?: string;
  country?: string;
  primary_skills: string[];
  total_skills: number;
  years_experience: number;
};

export default function SourcerCandidatesPage() {
  const [candidates, setCandidates] = useState<CandidateSummary[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState("");
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [total, setTotal] = useState(0);

  const fetchCandidates = useCallback(async (p: number) => {
    setLoading(true);
    try {
      const res = await sourcingApi.getCandidates(p);
      const payload = res.data.data;
      setCandidates(payload.candidates ?? []);
      setTotal(payload.total ?? 0);
      setTotalPages(Math.ceil((payload.total ?? 1) / (payload.per_page ?? 20)));
    } catch {
      toast.error("Failed to load candidates.");
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchCandidates(page);
  }, [fetchCandidates, page]);

  const filtered = search.trim()
    ? candidates.filter(
        (c) =>
          c.full_name.toLowerCase().includes(search.toLowerCase()) ||
          c.current_title?.toLowerCase().includes(search.toLowerCase()) ||
          c.primary_skills.some((s) => s.toLowerCase().includes(search.toLowerCase()))
      )
    : candidates;

  function getInitials(name: string) {
    return name
      .split(" ")
      .slice(0, 2)
      .map((n) => n[0])
      .join("")
      .toUpperCase();
  }

  const avatarColors = [
    "bg-blue-500",
    "bg-emerald-500",
    "bg-purple-500",
    "bg-amber-500",
    "bg-rose-500",
    "bg-cyan-500",
  ];

  return (
    <div className="p-6 max-w-6xl mx-auto space-y-5">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
        <div>
          <h1 className="text-2xl font-bold text-slate-900">Candidates</h1>
          <p className="text-slate-500 text-sm mt-0.5">
            {total} candidate{total !== 1 ? "s" : ""} in the database
          </p>
        </div>

        <div className="relative">
          <SearchIcon className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
          <Input
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder="Search by name, title, or skill…"
            className="pl-9 border-slate-300 w-72"
          />
        </div>
      </div>

      {loading ? (
        <div className="flex items-center justify-center py-20">
          <Loader2Icon className="w-6 h-6 text-blue-600 animate-spin" />
        </div>
      ) : filtered.length === 0 ? (
        <div className="flex flex-col items-center justify-center py-20 bg-white border border-slate-200 rounded-xl shadow-sm">
          <UsersIcon className="w-12 h-12 text-slate-300 mb-3" />
          <p className="text-slate-500 font-medium">No candidates found.</p>
          {search && (
            <p className="text-slate-400 text-xs mt-1">Try a different search term.</p>
          )}
        </div>
      ) : (
        <>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
            {filtered.map((candidate, idx) => {
              const color = avatarColors[idx % avatarColors.length];
              const location = [candidate.city, candidate.country]
                .filter(Boolean)
                .join(", ");

              return (
                <Link key={candidate.id} href={`/sourcer/candidates/${candidate.id}`}>
                  <Card className="border-slate-200 bg-white shadow-sm hover:shadow-md hover:border-blue-300 transition-all cursor-pointer group">
                    <CardContent className="p-5">
                      <div className="flex items-start gap-3 mb-3">
                        <div
                          className={`w-11 h-11 rounded-full ${color} flex items-center justify-center text-white font-bold text-sm flex-shrink-0`}
                        >
                          {getInitials(candidate.full_name)}
                        </div>
                        <div className="flex-1 min-w-0">
                          <p className="text-slate-900 font-semibold text-sm leading-tight truncate group-hover:text-blue-700 transition-colors">
                            {candidate.full_name}
                          </p>
                          {candidate.current_title && (
                            <div className="flex items-center gap-1 text-slate-500 text-xs mt-0.5">
                              <BriefcaseIcon className="w-3 h-3 flex-shrink-0" />
                              <span className="truncate">{candidate.current_title}</span>
                            </div>
                          )}
                          {location && (
                            <div className="flex items-center gap-1 text-slate-400 text-xs mt-0.5">
                              <MapPinIcon className="w-3 h-3 flex-shrink-0" />
                              <span className="truncate">{location}</span>
                            </div>
                          )}
                        </div>
                      </div>

                      {/* Skills */}
                      {candidate.primary_skills.length > 0 && (
                        <div className="flex flex-wrap gap-1.5 mb-3">
                          {candidate.primary_skills.slice(0, 4).map((skill) => (
                            <Badge
                              key={skill}
                              className="bg-blue-50 text-blue-700 border-blue-200 text-xs"
                              variant="outline"
                            >
                              {skill}
                            </Badge>
                          ))}
                          {candidate.primary_skills.length > 4 && (
                            <Badge
                              className="bg-slate-100 text-slate-500 border-slate-200 text-xs"
                              variant="outline"
                            >
                              +{candidate.primary_skills.length - 4}
                            </Badge>
                          )}
                        </div>
                      )}

                      <div className="flex items-center justify-between text-xs text-slate-400 pt-2 border-t border-slate-100">
                        <span>{candidate.total_skills} skills total</span>
                        {candidate.years_experience > 0 && (
                          <span>{candidate.years_experience}y experience</span>
                        )}
                      </div>
                    </CardContent>
                  </Card>
                </Link>
              );
            })}
          </div>

          {/* Pagination */}
          {totalPages > 1 && (
            <div className="flex items-center justify-center gap-3 pt-2">
              <Button
                variant="outline"
                size="sm"
                className="border-slate-300"
                onClick={() => setPage((p) => Math.max(1, p - 1))}
                disabled={page === 1 || loading}
              >
                <ChevronLeftIcon className="w-4 h-4" />
                Previous
              </Button>
              <span className="text-slate-500 text-sm">
                Page {page} of {totalPages}
              </span>
              <Button
                variant="outline"
                size="sm"
                className="border-slate-300"
                onClick={() => setPage((p) => Math.min(totalPages, p + 1))}
                disabled={page === totalPages || loading}
              >
                Next
                <ChevronRightIcon className="w-4 h-4" />
              </Button>
            </div>
          )}
        </>
      )}
    </div>
  );
}
