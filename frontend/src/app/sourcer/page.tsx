"use client";

import { useState, useEffect, useCallback } from "react";
import Link from "next/link";
import { toast } from "sonner";
import {
  UsersIcon,
  FileTextIcon,
  SearchIcon,
  Loader2Icon,
  CalendarIcon,
  ArrowRightIcon,
  ZapIcon,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { sourcingApi, JobDescription } from "@/lib/api";
import { getStoredUser } from "@/lib/auth";

const statusConfig: Record<string, { label: string; className: string }> = {
  completed: { label: "Completed", className: "bg-emerald-100 text-emerald-700 border-emerald-200" },
  pending: { label: "Pending", className: "bg-amber-100 text-amber-700 border-amber-200" },
  processing: { label: "Processing", className: "bg-blue-100 text-blue-700 border-blue-200" },
  failed: { label: "Failed", className: "bg-red-100 text-red-700 border-red-200" },
};

function formatDate(dateStr: string) {
  return new Date(dateStr).toLocaleDateString("en-US", {
    month: "short",
    day: "numeric",
    year: "numeric",
  });
}

export default function SourcerDashboardPage() {
  const [jobs, setJobs] = useState<JobDescription[]>([]);
  const [candidatesCount, setCandidatesCount] = useState<number>(0);
  const [loading, setLoading] = useState(true);
  const user = getStoredUser();

  const fetchData = useCallback(async () => {
    setLoading(true);
    try {
      const [jobsRes, candidatesRes] = await Promise.all([
        sourcingApi.getJobs(),
        sourcingApi.getCandidates(1),
      ]);
      const raw = jobsRes.data;
      setJobs(Array.isArray(raw?.data) ? raw.data : Array.isArray(raw) ? raw : []);
      const candData = candidatesRes.data?.data;
      setCandidatesCount(candData?.total ?? candData?.candidates?.length ?? 0);
    } catch {
      toast.error("Failed to load dashboard data.");
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchData();
  }, [fetchData]);

  const recentJobs = jobs.slice(0, 5);
  const completedJobs = jobs.filter((j) => j.status === "completed").length;

  return (
    <div className="p-6 max-w-5xl mx-auto space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-2xl font-bold text-slate-900">
          Welcome back{user?.full_name ? `, ${user.full_name.split(" ")[0]}` : ""}!
        </h1>
        <p className="text-slate-500 text-sm mt-1">
          Here&apos;s an overview of your sourcing activity.
        </p>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <Card className="border-slate-200 bg-white shadow-sm">
          <CardContent className="p-5">
            <div className="flex items-start justify-between">
              <div>
                <p className="text-slate-500 text-sm">Total Candidates</p>
                <p className="text-3xl font-bold text-slate-900 mt-1">
                  {loading ? "—" : candidatesCount}
                </p>
              </div>
              <div className="w-10 h-10 bg-blue-50 rounded-lg flex items-center justify-center">
                <UsersIcon className="w-5 h-5 text-blue-600" />
              </div>
            </div>
          </CardContent>
        </Card>

        <Card className="border-slate-200 bg-white shadow-sm">
          <CardContent className="p-5">
            <div className="flex items-start justify-between">
              <div>
                <p className="text-slate-500 text-sm">Jobs Parsed</p>
                <p className="text-3xl font-bold text-slate-900 mt-1">
                  {loading ? "—" : jobs.length}
                </p>
              </div>
              <div className="w-10 h-10 bg-purple-50 rounded-lg flex items-center justify-center">
                <FileTextIcon className="w-5 h-5 text-purple-600" />
              </div>
            </div>
          </CardContent>
        </Card>

        <Card className="border-slate-200 bg-white shadow-sm">
          <CardContent className="p-5">
            <div className="flex items-start justify-between">
              <div>
                <p className="text-slate-500 text-sm">Completed Searches</p>
                <p className="text-3xl font-bold text-slate-900 mt-1">
                  {loading ? "—" : completedJobs}
                </p>
              </div>
              <div className="w-10 h-10 bg-emerald-50 rounded-lg flex items-center justify-center">
                <ZapIcon className="w-5 h-5 text-emerald-600" />
              </div>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Quick action */}
      <Card className="border-blue-200 bg-gradient-to-r from-blue-600 to-blue-700 text-white shadow-sm">
        <CardContent className="p-5 flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4">
          <div>
            <h3 className="font-semibold text-lg">Find your next hire</h3>
            <p className="text-blue-100 text-sm mt-0.5">
              Paste a job description and get AI-ranked candidate matches instantly.
            </p>
          </div>
          <Link href="/sourcer/search">
            <Button className="bg-white text-blue-700 hover:bg-blue-50 font-medium shrink-0">
              <SearchIcon className="w-4 h-4 mr-2" />
              Start searching
            </Button>
          </Link>
        </CardContent>
      </Card>

      {/* Recent JDs */}
      <Card className="border-slate-200 bg-white shadow-sm">
        <CardHeader className="flex-row items-center justify-between pb-4">
          <div>
            <CardTitle className="text-slate-800 text-base">Recent Job Descriptions</CardTitle>
            <CardDescription>Your latest parsed job postings</CardDescription>
          </div>
          <Link href="/sourcer/jobs">
            <Button variant="ghost" size="sm" className="text-blue-600 hover:text-blue-700 hover:bg-blue-50 gap-1">
              View all
              <ArrowRightIcon className="w-3.5 h-3.5" />
            </Button>
          </Link>
        </CardHeader>
        <CardContent>
          {loading ? (
            <div className="flex items-center justify-center py-10">
              <Loader2Icon className="w-5 h-5 text-blue-600 animate-spin" />
            </div>
          ) : recentJobs.length === 0 ? (
            <div className="text-center py-10">
              <FileTextIcon className="w-8 h-8 text-slate-300 mx-auto mb-2" />
              <p className="text-slate-400 text-sm">No job descriptions yet.</p>
              <Link href="/sourcer/search">
                <Button size="sm" className="mt-3 bg-blue-600 hover:bg-blue-500 text-white">
                  Parse your first JD
                </Button>
              </Link>
            </div>
          ) : (
            <div className="divide-y divide-slate-100">
              {recentJobs.map((job) => {
                const sc = statusConfig[job.status] ?? statusConfig.pending;
                return (
                  <div key={job.id} className="py-3 flex items-center gap-3">
                    <div className="flex-1 min-w-0">
                      <p className="text-slate-800 font-medium text-sm truncate">
                        {job.title || "Untitled Job"}
                      </p>
                      {job.company_name && (
                        <p className="text-slate-400 text-xs truncate">{job.company_name}</p>
                      )}
                    </div>
                    <Badge className={`text-xs border ${sc.className} flex-shrink-0`} variant="outline">
                      {sc.label}
                    </Badge>
                    <div className="flex items-center gap-1 text-slate-400 text-xs flex-shrink-0">
                      <CalendarIcon className="w-3 h-3" />
                      <span>{formatDate(job.created_at)}</span>
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
