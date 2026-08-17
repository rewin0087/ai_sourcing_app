"use client";

import { useState, useCallback, useEffect } from "react";
import { toast } from "sonner";
import {
  UploadCloudIcon,
  FileTextIcon,
  CheckCircleIcon,
  Loader2Icon,
  CodeIcon,
  BriefcaseIcon,
  XIcon,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { Badge } from "@/components/ui/badge";
import { candidateApi, Candidate } from "@/lib/api";

type UploadResult = {
  skills_count: number;
  experiences_count: number;
};

export default function ResumePage() {
  const [file, setFile] = useState<File | null>(null);
  const [dragging, setDragging] = useState(false);
  const [uploading, setUploading] = useState(false);
  const [progress, setProgress] = useState(0);
  const [result, setResult] = useState<UploadResult | null>(null);
  const [profile, setProfile] = useState<Partial<Candidate> | null>(null);

  useEffect(() => {
    candidateApi
      .getProfile()
      .then((r) => setProfile(r.data.data))
      .catch(() => {});
  }, []);

  const handleDrop = useCallback((e: React.DragEvent) => {
    e.preventDefault();
    setDragging(false);
    const dropped = e.dataTransfer.files[0];
    if (dropped && (dropped.type === "application/pdf" || dropped.type === "text/plain")) {
      setFile(dropped);
      setResult(null);
    } else {
      toast.error("Only PDF or TXT files are supported.");
    }
  }, []);

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const picked = e.target.files?.[0];
    if (picked) {
      setFile(picked);
      setResult(null);
    }
  };

  async function handleUpload() {
    if (!file) return;
    setUploading(true);
    setProgress(10);

    // Simulate progress while uploading
    const tick = setInterval(() => {
      setProgress((p) => (p < 85 ? p + 8 : p));
    }, 400);

    try {
      const res = await candidateApi.uploadResume(file);
      clearInterval(tick);
      setProgress(100);
      const data = res.data;
      setResult({
        skills_count: data.skills_count ?? data.profile?.skills?.length ?? 0,
        experiences_count:
          data.experiences_count ?? data.profile?.work_experiences?.length ?? 0,
      });
      toast.success("Resume processed successfully!");
      // Refresh profile stats
      const profileRes = await candidateApi.getProfile();
      setProfile(profileRes.data.data);
    } catch {
      clearInterval(tick);
      setProgress(0);
      toast.error("Failed to process resume. Please try again.");
    } finally {
      setUploading(false);
    }
  }

  function handleRemove() {
    setFile(null);
    setResult(null);
    setProgress(0);
  }

  const formatSize = (bytes: number) =>
    bytes > 1_000_000
      ? `${(bytes / 1_000_000).toFixed(1)} MB`
      : `${(bytes / 1_000).toFixed(0)} KB`;

  return (
    <div className="p-6 max-w-3xl mx-auto space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-slate-900">Resume Upload</h1>
        <p className="text-slate-500 text-sm mt-1">
          Upload your resume and let AI extract your skills and experience automatically.
        </p>
      </div>

      {/* Current profile stats */}
      {profile && (
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
          {[
            { label: "Skills", value: profile.skills?.length ?? 0, icon: CodeIcon, color: "text-blue-600", bg: "bg-blue-50" },
            { label: "Experiences", value: profile.work_experiences?.length ?? 0, icon: BriefcaseIcon, color: "text-emerald-600", bg: "bg-emerald-50" },
          ].map((s) => (
            <Card key={s.label} className="border-slate-200 bg-white shadow-sm col-span-2 sm:col-span-1">
              <CardContent className="p-4">
                <div className={`w-8 h-8 ${s.bg} rounded-lg flex items-center justify-center mb-2`}>
                  <s.icon className={`w-4 h-4 ${s.color}`} />
                </div>
                <p className={`text-2xl font-bold ${s.color}`}>{s.value}</p>
                <p className="text-slate-500 text-xs">{s.label} in profile</p>
              </CardContent>
            </Card>
          ))}
        </div>
      )}

      {/* Drop zone */}
      <Card className="border-slate-200 bg-white shadow-sm">
        <CardHeader>
          <CardTitle className="text-slate-800">Upload Resume</CardTitle>
          <CardDescription>Supported formats: PDF, TXT. Maximum size: 10 MB.</CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          {!file ? (
            <label
              htmlFor="resume-input"
              onDragOver={(e) => {
                e.preventDefault();
                setDragging(true);
              }}
              onDragLeave={() => setDragging(false)}
              onDrop={handleDrop}
              className={`flex flex-col items-center justify-center border-2 border-dashed rounded-xl p-12 cursor-pointer transition-all ${
                dragging
                  ? "border-blue-400 bg-blue-50"
                  : "border-slate-300 hover:border-blue-400 hover:bg-slate-50"
              }`}
            >
              <UploadCloudIcon
                className={`w-12 h-12 mb-3 ${dragging ? "text-blue-500" : "text-slate-400"}`}
              />
              <p className="text-slate-700 font-medium text-sm">
                {dragging ? "Drop file here" : "Drag & drop your resume here"}
              </p>
              <p className="text-slate-400 text-xs mt-1">or click to browse files</p>
              <input
                id="resume-input"
                type="file"
                accept=".pdf,.txt"
                className="hidden"
                onChange={handleFileChange}
              />
            </label>
          ) : (
            <div className="border border-slate-200 rounded-xl p-4">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 bg-blue-50 rounded-lg flex items-center justify-center flex-shrink-0">
                  <FileTextIcon className="w-5 h-5 text-blue-600" />
                </div>
                <div className="flex-1 min-w-0">
                  <p className="text-slate-800 text-sm font-medium truncate">{file.name}</p>
                  <p className="text-slate-400 text-xs">{formatSize(file.size)}</p>
                </div>
                {!uploading && !result && (
                  <Button
                    variant="ghost"
                    size="icon"
                    className="text-slate-400 hover:text-red-500"
                    onClick={handleRemove}
                  >
                    <XIcon className="w-4 h-4" />
                  </Button>
                )}
              </div>

              {uploading && (
                <div className="mt-4 space-y-1">
                  <div className="flex justify-between text-xs text-slate-500">
                    <span>Processing…</span>
                    <span>{progress}%</span>
                  </div>
                  <Progress value={progress} className="h-1.5" />
                </div>
              )}

              {result && (
                <div className="mt-4 p-3 bg-emerald-50 border border-emerald-200 rounded-lg flex items-start gap-3">
                  <CheckCircleIcon className="w-5 h-5 text-emerald-600 flex-shrink-0 mt-0.5" />
                  <div>
                    <p className="text-emerald-800 text-sm font-medium">Processed successfully!</p>
                    <p className="text-emerald-600 text-xs mt-0.5">
                      Extracted {result.skills_count} skills and {result.experiences_count} work experiences.
                    </p>
                  </div>
                </div>
              )}
            </div>
          )}

          <div className="flex justify-end gap-3">
            {file && !result && (
              <Button
                onClick={handleUpload}
                disabled={uploading}
                className="bg-blue-600 hover:bg-blue-500 text-white"
              >
                {uploading ? (
                  <>
                    <Loader2Icon className="w-4 h-4 mr-2 animate-spin" />
                    Processing…
                  </>
                ) : (
                  <>
                    <UploadCloudIcon className="w-4 h-4 mr-2" />
                    Upload & Extract
                  </>
                )}
              </Button>
            )}
            {result && (
              <Button
                variant="outline"
                className="border-slate-300"
                onClick={() => {
                  setFile(null);
                  setResult(null);
                  setProgress(0);
                }}
              >
                Upload another
              </Button>
            )}
          </div>
        </CardContent>
      </Card>

      {/* Info section */}
      <div className="grid sm:grid-cols-3 gap-4">
        {[
          { title: "AI Extraction", desc: "Skills, roles, and responsibilities are automatically parsed from your resume.", badge: "Powered by AI" },
          { title: "Always Editable", desc: "Review and edit extracted data in the Skills and Experience sections.", badge: "Full control" },
          { title: "Better Matches", desc: "A complete profile improves your visibility in recruiter searches.", badge: "Higher visibility" },
        ].map((item) => (
          <div key={item.title} className="bg-white border border-slate-200 rounded-xl p-4 shadow-sm">
            <Badge className="bg-blue-50 text-blue-700 border-blue-100 mb-2 text-xs">
              {item.badge}
            </Badge>
            <h3 className="text-slate-800 font-semibold text-sm mb-1">{item.title}</h3>
            <p className="text-slate-500 text-xs leading-relaxed">{item.desc}</p>
          </div>
        ))}
      </div>
    </div>
  );
}
