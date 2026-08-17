"use client";

import { useState, useEffect, useCallback } from "react";
import { toast } from "sonner";
import {
  PlusIcon,
  Loader2Icon,
  PencilIcon,
  Trash2Icon,
  GraduationCapIcon,
  CalendarIcon,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Checkbox } from "@/components/ui/checkbox";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { candidateApi, Education } from "@/lib/api";

function formatDate(dateStr?: string) {
  if (!dateStr) return "";
  const d = new Date(dateStr);
  return d.toLocaleDateString("en-US", { month: "short", year: "numeric" });
}

const emptyForm: Partial<Education> = {
  school_name: "",
  degree_obtained: "",
  field_of_study: "",
  start_date: "",
  end_date: "",
  still_studying: false,
  description: "",
};

export default function EducationPage() {
  const [educations, setEducations] = useState<Education[]>([]);
  const [loading, setLoading] = useState(true);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editEdu, setEditEdu] = useState<Education | null>(null);
  const [form, setForm] = useState<Partial<Education>>(emptyForm);
  const [saving, setSaving] = useState(false);
  const [deletingId, setDeletingId] = useState<number | null>(null);

  const fetchEducations = useCallback(async () => {
    setLoading(true);
    try {
      const res = await candidateApi.getEducations();
      const rawEdu = res.data?.data;
      setEducations(Array.isArray(rawEdu) ? rawEdu : []);
    } catch {
      toast.error("Failed to load educations.");
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchEducations();
  }, [fetchEducations]);

  function openAdd() {
    setEditEdu(null);
    setForm(emptyForm);
    setDialogOpen(true);
  }

  function openEdit(edu: Education) {
    setEditEdu(edu);
    setForm({ ...edu });
    setDialogOpen(true);
  }

  function setField(field: keyof Education, value: unknown) {
    setForm((prev) => ({ ...prev, [field]: value }));
  }

  async function handleSave() {
    if (!form.school_name?.trim()) {
      toast.error("School name is required.");
      return;
    }
    setSaving(true);
    try {
      if (editEdu) {
        await candidateApi.updateEducation(editEdu.id, form);
        toast.success("Education updated.");
      } else {
        await candidateApi.createEducation(form);
        toast.success("Education added.");
      }
      setDialogOpen(false);
      fetchEducations();
    } catch {
      toast.error("Failed to save education.");
    } finally {
      setSaving(false);
    }
  }

  async function handleDelete(id: number) {
    setDeletingId(id);
    try {
      await candidateApi.deleteEducation(id);
      toast.success("Education removed.");
      setEducations((prev) => prev.filter((e) => e.id !== id));
    } catch {
      toast.error("Failed to delete education.");
    } finally {
      setDeletingId(null);
    }
  }

  return (
    <div className="p-6 max-w-4xl mx-auto space-y-5">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
        <div>
          <h1 className="text-2xl font-bold text-slate-900">Education</h1>
          <p className="text-slate-500 text-sm mt-0.5">
            {educations.length} education record{educations.length !== 1 ? "s" : ""}
          </p>
        </div>
        <Button className="bg-blue-600 hover:bg-blue-500 text-white" onClick={openAdd}>
          <PlusIcon className="w-4 h-4 mr-2" />
          Add education
        </Button>
      </div>

      {loading ? (
        <div className="flex items-center justify-center py-20">
          <Loader2Icon className="w-6 h-6 text-blue-600 animate-spin" />
        </div>
      ) : educations.length === 0 ? (
        <div className="bg-white border border-slate-200 rounded-xl p-16 flex flex-col items-center shadow-sm">
          <GraduationCapIcon className="w-12 h-12 text-slate-300 mb-3" />
          <p className="text-slate-500 font-medium">No education records yet.</p>
          <Button className="mt-4 bg-blue-600 hover:bg-blue-500 text-white" onClick={openAdd}>
            <PlusIcon className="w-4 h-4 mr-2" />
            Add education
          </Button>
        </div>
      ) : (
        <div className="space-y-3">
          {educations.map((edu) => (
            <div
              key={edu.id}
              className="bg-white border border-slate-200 rounded-xl shadow-sm p-5"
            >
              <div className="flex items-start gap-4">
                <div className="w-11 h-11 rounded-lg bg-purple-50 flex items-center justify-center flex-shrink-0">
                  <GraduationCapIcon className="w-5 h-5 text-purple-600" />
                </div>

                <div className="flex-1 min-w-0">
                  <h3 className="text-slate-900 font-semibold text-base leading-tight">
                    {edu.school_name}
                  </h3>
                  {(edu.degree_obtained || edu.field_of_study) && (
                    <p className="text-slate-600 text-sm mt-0.5">
                      {[edu.degree_obtained, edu.field_of_study].filter(Boolean).join(" · ")}
                    </p>
                  )}
                  <div className="flex items-center gap-1 mt-2 text-xs text-slate-500">
                    <CalendarIcon className="w-3 h-3" />
                    <span>
                      {formatDate(edu.start_date)}
                      {edu.start_date ? " – " : ""}
                      {edu.still_studying ? "Present" : formatDate(edu.end_date)}
                    </span>
                  </div>
                  {edu.description && (
                    <p className="text-slate-500 text-sm mt-2 leading-relaxed">{edu.description}</p>
                  )}
                </div>

                <div className="flex items-center gap-1 flex-shrink-0">
                  <Button
                    variant="ghost"
                    size="icon"
                    className="w-8 h-8 text-slate-400 hover:text-blue-600 hover:bg-blue-50"
                    onClick={() => openEdit(edu)}
                  >
                    <PencilIcon className="w-4 h-4" />
                  </Button>
                  <Button
                    variant="ghost"
                    size="icon"
                    className="w-8 h-8 text-slate-400 hover:text-red-600 hover:bg-red-50"
                    onClick={() => handleDelete(edu.id)}
                    disabled={deletingId === edu.id}
                  >
                    {deletingId === edu.id ? (
                      <Loader2Icon className="w-4 h-4 animate-spin" />
                    ) : (
                      <Trash2Icon className="w-4 h-4" />
                    )}
                  </Button>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Add/Edit dialog */}
      <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle>{editEdu ? "Edit education" : "Add education"}</DialogTitle>
            <DialogDescription>Enter your academic details.</DialogDescription>
          </DialogHeader>

          <div className="space-y-4 py-2">
            <div className="space-y-1.5">
              <Label className="text-sm text-slate-700">School / University *</Label>
              <Input
                value={form.school_name ?? ""}
                onChange={(e) => setField("school_name", e.target.value)}
                placeholder="MIT"
                className="border-slate-300"
              />
            </div>

            <div className="grid grid-cols-2 gap-3">
              <div className="space-y-1.5">
                <Label className="text-sm text-slate-700">Degree</Label>
                <Input
                  value={form.degree_obtained ?? ""}
                  onChange={(e) => setField("degree_obtained", e.target.value)}
                  placeholder="B.Sc."
                  className="border-slate-300"
                />
              </div>
              <div className="space-y-1.5">
                <Label className="text-sm text-slate-700">Field of study</Label>
                <Input
                  value={form.field_of_study ?? ""}
                  onChange={(e) => setField("field_of_study", e.target.value)}
                  placeholder="Computer Science"
                  className="border-slate-300"
                />
              </div>
            </div>

            <div className="grid grid-cols-2 gap-3">
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
                  disabled={!!form.still_studying}
                  className="border-slate-300"
                />
              </div>
            </div>

            <div className="flex items-center gap-2">
              <Checkbox
                id="still-studying"
                checked={!!form.still_studying}
                onCheckedChange={(v) => {
                  setField("still_studying", !!v);
                  if (v) setField("end_date", "");
                }}
              />
              <Label htmlFor="still-studying" className="text-sm text-slate-700 cursor-pointer">
                Currently enrolled
              </Label>
            </div>

            <div className="space-y-1.5">
              <Label className="text-sm text-slate-700">Description</Label>
              <Textarea
                rows={3}
                value={form.description ?? ""}
                onChange={(e) => setField("description", e.target.value)}
                placeholder="Relevant coursework, thesis, honors…"
                className="border-slate-300 resize-none"
              />
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
