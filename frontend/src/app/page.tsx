"use client";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { BriefcaseIcon, UsersIcon, SparklesIcon, ZapIcon, ShieldCheckIcon, BarChart3Icon } from "lucide-react";

export default function Home() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900">
      <nav className="border-b border-slate-700/50 backdrop-blur-sm">
        <div className="max-w-7xl mx-auto px-6 py-4 flex items-center justify-between">
          <div className="flex items-center gap-2">
            <div className="w-8 h-8 rounded-lg bg-blue-500 flex items-center justify-center">
              <ZapIcon className="w-5 h-5 text-white" />
            </div>
            <span className="text-white font-bold text-xl">TalentHub</span>
          </div>
          <div className="flex items-center gap-3">
            <Link href="/login">
              <Button variant="ghost" className="text-slate-300 hover:text-white hover:bg-slate-700">
                Sign In
              </Button>
            </Link>
            <Link href="/register">
              <Button className="bg-blue-500 hover:bg-blue-600 text-white">Get Started</Button>
            </Link>
          </div>
        </div>
      </nav>

      <section className="max-w-7xl mx-auto px-6 py-24 text-center">
        <Badge className="mb-6 bg-blue-500/10 text-blue-400 border-blue-500/20 hover:bg-blue-500/10">
          <SparklesIcon className="w-3 h-3 mr-1" />
          AI-Powered Talent Matching
        </Badge>
        <h1 className="text-5xl md:text-7xl font-bold text-white mb-6 leading-tight">
          Find the Right{" "}
          <span className="bg-gradient-to-r from-blue-400 to-cyan-400 bg-clip-text text-transparent">
            Talent
          </span>{" "}
          Instantly
        </h1>
        <p className="text-slate-400 text-xl max-w-3xl mx-auto mb-10">
          Upload a job description and let AI match you with the most relevant candidates using semantic search and intelligent ranking.
        </p>
        <div className="flex flex-col sm:flex-row gap-4 justify-center">
          <Link href="/register?role=sourcer">
            <Button size="lg" className="bg-blue-500 hover:bg-blue-600 text-white px-8">
              <UsersIcon className="w-5 h-5 mr-2" />
              I&apos;m a Recruiter
            </Button>
          </Link>
          <Link href="/register?role=candidate">
            <Button size="lg" variant="outline" className="border-slate-600 text-slate-200 hover:bg-slate-800 px-8">
              <BriefcaseIcon className="w-5 h-5 mr-2" />
              I&apos;m a Professional
            </Button>
          </Link>
        </div>
      </section>

      <section className="max-w-7xl mx-auto px-6 py-20">
        <div className="grid md:grid-cols-3 gap-8">
          {[
            { icon: SparklesIcon, title: "AI-Powered Extraction", desc: "Upload PDF or paste job descriptions. Our AI extracts structured requirements automatically.", color: "text-blue-400", bg: "bg-blue-500/10" },
            { icon: BarChart3Icon, title: "Semantic Matching", desc: "Vector embeddings and RAG technology rank candidates by true relevance, not just keyword matches.", color: "text-emerald-400", bg: "bg-emerald-500/10" },
            { icon: ShieldCheckIcon, title: "Rich Candidate Profiles", desc: "Candidates upload resumes; AI structures their skills, experience, education, and certifications.", color: "text-purple-400", bg: "bg-purple-500/10" },
          ].map((f) => (
            <div key={f.title} className="bg-slate-800/50 border border-slate-700/50 rounded-2xl p-8">
              <div className={`w-12 h-12 ${f.bg} rounded-xl flex items-center justify-center mb-4`}>
                <f.icon className={`w-6 h-6 ${f.color}`} />
              </div>
              <h3 className="text-white font-semibold text-lg mb-2">{f.title}</h3>
              <p className="text-slate-400 text-sm leading-relaxed">{f.desc}</p>
            </div>
          ))}
        </div>
      </section>

      <footer className="border-t border-slate-700/50 py-8 text-center text-slate-500 text-sm">
        © {new Date().getFullYear()} TalentHub. All rights reserved.
      </footer>
    </div>
  );
}
