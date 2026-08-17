"use client";

import { useState, useEffect, useCallback } from "react";
import { toast } from "sonner";
import {
  PlusIcon,
  Loader2Icon,
  PencilIcon,
  Trash2Icon,
  BuildingIcon,
  CalendarIcon,
  ChevronDownIcon,
  ChevronUpIcon,
  BriefcaseIcon,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Badge } from "@/components/ui/badge";
import { Checkbox } from "@/components/ui/checkbox";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { candidateApi, WorkExperience } from "@/lib/api";

const employmentTypeLabel: Record<number, string> = {
  1: "Full-time",
  2: "Part-time",
  3: "Contract",
};

const locationTypeLabel: Record<number, string> = {
  1: "On-site",
  2: "Remote",
  3: "Hybrid",
};

function formatDate(dateStr?: string) {
  if (!dateStr) return "";
  const d = new Date(dateStr);
  return d.toLocaleDateString("en-US", { month: "short", year: "numeric" });
}

const emptyForm: Partial<WorkExperience> = {
  company_name: "",
  job_title: "",
  work_status: 0,
  employment_type: 1,
  location: "",
  location_type: 1,
  description: "",
  start_date: "",
  end_date: "",
};

export default function ExperiencePage() {
  const [experiences, setExperiences] = useState<WorkExperience[]>([]);
  const [loading, setLoading] = useState(true);
  const [expanded, setExpanded] = useState<number | null>(null);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editExp, setEditExp] = useState<WorkExperience | null>(null);
  const [form, setForm] = useState<Partial<WorkExperience>>(emptyForm);
  const [saving, setSaving] = useState(false);
  const [deletingId, setDeletingId] = useState<number | null>(null);

  const fetchExperiences = useCallback(async () => {
    setLoading(true);
    try {
      const res = await candidateApi.getWorkExperiences();
      const rawExp = res.data?.data;
      setExperiences(Array.isArray(rawExp) ? rawExp : []);
    } catch {
      toast.error("Failed to load work experiences.");
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchExperiences();
  }, [fetchExperiences]);

  function openAdd() {
    setEditExp(null);
    setForm(emptyForm);
    setDialogOpen(true);
  }

  function openEdit(exp: WorkExperience) {
    setEditExp(exp);
    setForm({ ...exp });
    setDialogOpen(true);
  }

  function setField(field: keyof WorkExperience, value: unknown) {
    setForm((prev) => ({ ...prev, [field]: value }));
  }

  async function handleSave() {
    if (!form.company_name?.trim() || !form.job_title?.trim()) {
      toast.error("Company name and job title are required.");
      return;
    }
    setSaving(true);
    try {
      if (editExp) {
        await candidateApi.updateWorkExperience(editExp.id, form);
        toast.success("Experience updated.");
      } else {
        await candidateApi.createWorkExperience(form);
        toast.success("Experience added.");
      }
      setDialogOpen(false);
      fetchExperiences();
    } catch {
      toast.error("Failed to save experience.");
    } finally {
      setSaving(false);
    }
  }

  async function handleDelete(id: number) {
    setDeletingId(id);
    try {
      await candidateApi.deleteWorkExperience(id);
      toast.success("Experience removed.");
      setExperiences((prev) => prev.filter((e) => e.id !== id));
    } catch {
      toast.error("Failed to delete experience.");
    } finally {
      setDeletingId(null);
    }
  }

  return (
    <div className="p-6 max-w-4xl mx-auto space-y-5">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
        <div>
          <h1 className="text-2xl font-bold text-slate-900">Work Experience</h1>
          <p className="text-slate-500 text-sm mt-0.5">
            {experiences.length} position{experiences.length !== 1 ? "s" : ""} in your profile
          </p>
        </div>
        <Button className="bg-blue-600 hover:bg-blue-500 text-white" onClick={openAdd}>
          <PlusIcon className="w-4 h-4 mr-2" />
          Add experience
        </Button>
      </div>

      {loading ? (
        <div className="flex items-center justify-center py-20">
          <Loader2Icon className="w-6 h-6 text-blue-600 animate-spin" />
        </div>
      ) : experiences.length === 0 ? (
        <div className="bg-white border border-slate-200 rounded-xl p-16 flex flex-col items-center shadow-sm">
          <BriefcaseIcon className="w-12 h-12 text-slate-300 mb-3" />
          <p className="text-slate-500 font-medium">No work experience added yet.</p>
          <Button className="mt-4 bg-blue-600 hover:bg-blue-500 text-white" onClick={openAdd}>
            <PlusIcon className="w-4 h-4 mr-2" />
            Add your first role
          </Button>
        </div>
      ) : (
        <div className="space-y-3">
          {experiences.map((exp) => (
            <div
              key={exp.id}
              className="bg-white border border-slate-200 rounded-xl shadow-sm overflow-hidden"
            >
              <div className="p-5">
                <div className="flex items-start gap-4">
                  {/* Company icon */}
                  <div className="w-11 h-11 rounded-lg bg-slate-100 flex items-center justify-center flex-shrink-0">
                    <BuildingIcon className="w-5 h-5 text-slate-500" />
                  </div>

                  <div className="flex-1 min-w-0">
                    <div className="flex flex-wrap items-center gap-2 mb-1">
                      <h3 className="text-slate-900 font-semibold text-base leading-tight">
                        {exp.job_title}
                      </h3>
                      {exp.work_status === 1 ? (
                        <Badge className="bg-emerald-100 text-emerald-700 border-emerald-200 text-xs">
                          Current
                        </Badge>
                      ) : (
                        <Badge className="bg-slate-100 text-slate-600 border-slate-200 text-xs">
                          Past
                        </Badge>
                      )}
                    </div>
                    <p className="text-slate-700 font-medium text-sm">{exp.company_name}</p>
                    <div className="flex flex-wrap items-center gap-3 mt-2">
                      <span className="flex items-center gap-1 text-xs text-slate-500">
                        <CalendarIcon className="w-3 h-3" />
                        {formatDate(exp.start_date)} –{" "}
                        {exp.work_status === 1 ? "Present" : formatDate(exp.end_date)}
                      </span>
                      {exp.location && (
                        <span className="text-xs text-slate-500">{exp.location}</span>
                      )}
                      <Badge variant="outline" className="text-xs border-slate-200 text-slate-500">
                        {employmentTypeLabel[exp.employment_type]}
                      </Badge>
                      <Badge variant="outline" className="text-xs border-slate-200 text-slate-500">
                        {locationTypeLabel[exp.location_type]}
                      </Badge>
                    </div>
                  </div>

                  <div className="flex items-center gap-1 flex-shrink-0">
                    <Button
                      variant="ghost"
                      size="icon"
                      className="w-8 h-8 text-slate-400 hover:text-blue-600 hover:bg-blue-50"
                      onClick={() => openEdit(exp)}
                    >
                      <PencilIcon className="w-4 h-4" />
                    </Button>
                    <Button
                      variant="ghost"
                      size="icon"
                      className="w-8 h-8 text-slate-400 hover:text-red-600 hover:bg-red-50"
                      onClick={() => handleDelete(exp.id)}
                      disabled={deletingId === exp.id}
                    >
                      {deletingId === exp.id ? (
                        <Loader2Icon className="w-4 h-4 animate-spin" />
                      ) : (
                        <Trash2Icon className="w-4 h-4" />
                      )}
                    </Button>
                    <Button
                      variant="ghost"
                      size="icon"
                      className="w-8 h-8 text-slate-400 hover:text-slate-700"
                      onClick={() => setExpanded(expanded === exp.id ? null : exp.id)}
                    >
                      {expanded === exp.id ? (
                        <ChevronUpIcon className="w-4 h-4" />
                      ) : (
                        <ChevronDownIcon className="w-4 h-4" />
                      )}
                    </Button>
                  </div>
                </div>

                {/* Expanded content */}
                {expanded === exp.id && (
                  <div className="mt-4 pt-4 border-t border-slate-100 space-y-4">
                    {exp.description && (
                      <div>
                        <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">
                          Description
                        </p>
                        <p className="text-slate-700 text-sm leading-relaxed whitespace-pre-line">
                          {exp.description}
                        </p>
                      </div>
                    )}

                    {exp.projects && exp.projects.length > 0 && (
                      <div>
                        <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">
                          Projects ({exp.projects.length})
                        </p>
                        <div className="space-y-3">
                          {exp.projects.map((proj) => (
                            <div
                              key={proj.id}
                              className="bg-slate-50 border border-slate-200 rounded-lg p-3"
                            >
                              <div className="flex items-center gap-2 mb-1">
                                <span className="text-slate-800 font-medium text-sm">
                                  {proj.project_name}
                                </span>
                                <Badge
                                  className={`text-xs ${
                                    proj.project_status === 1
                                      ? "bg-emerald-100 text-emerald-700"
                                      : "bg-slate-100 text-slate-600"
                                  }`}
                                >
                                  {proj.project_status === 1 ? "Active" : "Completed"}
                                </Badge>
                              </div>
                              {proj.description && (
                                <p className="text-slate-500 text-xs leading-relaxed">
                                  {proj.description}
                                </p>
                              )}
                              {proj.skills_used && (
                                <p className="text-slate-500 text-xs mt-1">
                                  <span className="font-medium">Skills:</span> {proj.skills_used}
                                </p>
                              )}
                            </div>
                          ))}
                        </div>
                      </div>
                    )}
                  </div>
                )}
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Add/Edit dialog */}
      <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle>{editExp ? "Edit experience" : "Add experience"}</DialogTitle>
            <DialogDescription>
              Fill in your work history details.
            </DialogDescription>
          </DialogHeader>

          <div className="space-y-4 py-2">
            <div className="grid grid-cols-2 gap-3">
              <div className="col-span-2 space-y-1.5">
                <Label className="text-sm text-slate-700">Company name *</Label>
                <Input
                  value={form.company_name ?? ""}
                  onChange={(e) => setField("company_name", e.target.value)}
                  placeholder="Acme Corp"
                  className="border-slate-300"
                />
              </div>

              <div className="col-span-2 space-y-1.5">
                <Label className="text-sm text-slate-700">Job title *</Label>
                <Input
                  value={form.job_title ?? ""}
                  onChange={(e) => setField("job_title", e.target.value)}
                  placeholder="Senior Engineer"
                  className="border-slate-300"
                />
              </div>

              <div className="space-y-1.5">
                <Label className="text-sm text-slate-700">Employment type</Label>
                <Select
                  value={String(form.employment_type ?? 1) as string}
                  onValueChange={(v) => setField("employment_type", parseInt(v ?? "1"))}
                >
                  <SelectTrigger className="border-slate-300">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="1">Full-time</SelectItem>
                    <SelectItem value="2">Part-time</SelectItem>
                    <SelectItem value="3">Contract</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-1.5">
                <Label className="text-sm text-slate-700">Work arrangement</Label>
                <Select
                  value={String(form.location_type ?? 1)}
                  onValueChange={(v) => setField("location_type", parseInt(v ?? "1"))}
                >
                  <SelectTrigger className="border-slate-300">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="1">On-site</SelectItem>
                    <SelectItem value="2">Remote</SelectItem>
                    <SelectItem value="3">Hybrid</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="col-span-2 space-y-1.5">
                <Label className="text-sm text-slate-700">Location</Label>
                <Input
                  value={form.location ?? ""}
                  onChange={(e) => setField("location", e.target.value)}
                  placeholder="San Francisco, CA"
                  className="border-slate-300"
                />
              </div>

              <div className="space-y-1.5">
                <Label className="text-sm text-slate-700">Start date</Label>
                <Input
                  type="date"
                  value={form.start_date ?? ""}
                  onChange={(e) => setField("start_date", e.target.value)}
                  className="border-slate-300"
                />
              </div>

              <div className="space-y-1.5">
                <Label className="text-sm text-slate-700">End date</Label>
                <Input
                  type="date"
                  value={form.end_date ?? ""}
                  onChange={(e) => setField("end_date", e.target.value)}
                  disabled={form.work_status === 1}
                  className="border-slate-300"
                />
              </div>

              <div className="col-span-2 flex items-center gap-2">
                <Checkbox
                  id="current-job"
                  checked={form.work_status === 1}
                  onCheckedChange={(v) => {
                    setField("work_status", v ? 1 : 0);
                    if (v) setField("end_date", "");
                  }}
                />
                <Label htmlFor="current-job" className="text-sm text-slate-700 cursor-pointer">
                  I currently work here
                </Label>
              </div>

              <div className="col-span-2 space-y-1.5">
                <Label className="text-sm text-slate-700">Description</Label>
                <Textarea
                  rows={4}
                  value={form.description ?? ""}
                  onChange={(e) => setField("description", e.target.value)}
                  placeholder="Describe your responsibilities and achievements…"
                  className="border-slate-300 resize-none"
                />
              </div>
            </div>
          </div>

          <DialogFooter>
            <Button variant="outline" onClick={() => setDialogOpen(false)} className="border-slate-300">
              Cancel
            </Button>
            <Button
              onClick={handleSave}
              disabled={saving}
              className="bg-blue-600 hover:bg-blue-500 text-white"
            >
              {saving ? (
                <>
                  <Loader2Icon className="w-4 h-4 mr-2 animate-spin" />
                  Saving…
                </>
              ) : (
                "Save"
              )}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
