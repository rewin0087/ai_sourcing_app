"use client";

import { useState, useEffect, useCallback } from "react";
import { toast } from "sonner";
import {
  PlusIcon,
  Loader2Icon,
  PencilIcon,
  Trash2Icon,
  SearchIcon,
  CodeIcon,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
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
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { candidateApi, CandidateSkill } from "@/lib/api";

const proficiencyConfig: Record<string, { label: string; className: string }> = {
  Advanced: { label: "Advanced", className: "bg-emerald-100 text-emerald-700 border-emerald-200" },
  Intermediate: { label: "Intermediate", className: "bg-amber-100 text-amber-700 border-amber-200" },
  Beginner: { label: "Beginner", className: "bg-slate-100 text-slate-600 border-slate-200" },
};

const skillTypeConfig: Record<string, { className: string }> = {
  Primary: { className: "bg-blue-100 text-blue-700 border-blue-200" },
  Secondary: { className: "bg-purple-100 text-purple-700 border-purple-200" },
  Tertiary: { className: "bg-slate-100 text-slate-600 border-slate-200" },
};

const emptyForm: Partial<CandidateSkill> = {
  name: "",
  category: "",
  proficiency: "Intermediate",
  years_of_exp: "0",
  skill_type: "Primary",
  year_last_used: new Date().getFullYear(),
  certification: "No",
  delivered_projects: "",
};

export default function SkillsPage() {
  const [skills, setSkills] = useState<CandidateSkill[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState("");
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editSkill, setEditSkill] = useState<CandidateSkill | null>(null);
  const [form, setForm] = useState<Partial<CandidateSkill>>(emptyForm);
  const [saving, setSaving] = useState(false);
  const [deletingId, setDeletingId] = useState<number | null>(null);

  const fetchSkills = useCallback(async () => {
    setLoading(true);
    try {
      const res = await candidateApi.getSkills();
      const rawSkills = res.data?.data;
      setSkills(Array.isArray(rawSkills) ? rawSkills : []);
    } catch {
      toast.error("Failed to load skills.");
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchSkills();
  }, [fetchSkills]);

  function openAdd() {
    setEditSkill(null);
    setForm(emptyForm);
    setDialogOpen(true);
  }

  function openEdit(skill: CandidateSkill) {
    setEditSkill(skill);
    setForm({ ...skill });
    setDialogOpen(true);
  }

  function setField(field: keyof CandidateSkill, value: string | number) {
    setForm((prev) => ({ ...prev, [field]: value }));
  }

  async function handleSave() {
    if (!form.name?.trim()) {
      toast.error("Skill name is required.");
      return;
    }
    setSaving(true);
    try {
      if (editSkill) {
        await candidateApi.updateSkill(editSkill.id, form);
        toast.success("Skill updated.");
      } else {
        await candidateApi.createSkill(form);
        toast.success("Skill added.");
      }
      setDialogOpen(false);
      fetchSkills();
    } catch {
      toast.error("Failed to save skill.");
    } finally {
      setSaving(false);
    }
  }

  async function handleDelete(id: number) {
    setDeletingId(id);
    try {
      await candidateApi.deleteSkill(id);
      toast.success("Skill removed.");
      setSkills((prev) => prev.filter((s) => s.id !== id));
    } catch {
      toast.error("Failed to delete skill.");
    } finally {
      setDeletingId(null);
    }
  }

  const filtered = skills.filter(
    (s) =>
      s.name.toLowerCase().includes(search.toLowerCase()) ||
      s.category.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div className="p-6 max-w-5xl mx-auto space-y-5">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
        <div>
          <h1 className="text-2xl font-bold text-slate-900">Skills</h1>
          <p className="text-slate-500 text-sm mt-0.5">
            {skills.length} skill{skills.length !== 1 ? "s" : ""} in your profile
          </p>
        </div>
        <Button className="bg-blue-600 hover:bg-blue-500 text-white" onClick={openAdd}>
          <PlusIcon className="w-4 h-4 mr-2" />
          Add skill
        </Button>
      </div>

      {/* Search */}
      <div className="relative max-w-xs">
        <SearchIcon className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
        <Input
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          placeholder="Search skills…"
          className="pl-9 border-slate-300"
        />
      </div>

      {/* Table */}
      <div className="bg-white border border-slate-200 rounded-xl shadow-sm overflow-hidden">
        {loading ? (
          <div className="flex items-center justify-center py-16">
            <Loader2Icon className="w-6 h-6 text-blue-600 animate-spin" />
          </div>
        ) : filtered.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-16 text-slate-400">
            <CodeIcon className="w-10 h-10 mb-3 opacity-30" />
            <p className="font-medium text-sm">No skills found</p>
            <p className="text-xs mt-1">{search ? "Try a different search term." : "Add your first skill to get started."}</p>
          </div>
        ) : (
          <div className="overflow-x-auto">
            <Table>
              <TableHeader>
                <TableRow className="bg-slate-50 border-b border-slate-200">
                  <TableHead className="text-slate-600 font-semibold">Skill</TableHead>
                  <TableHead className="text-slate-600 font-semibold">Category</TableHead>
                  <TableHead className="text-slate-600 font-semibold">Proficiency</TableHead>
                  <TableHead className="text-slate-600 font-semibold">Type</TableHead>
                  <TableHead className="text-slate-600 font-semibold">Exp.</TableHead>
                  <TableHead className="text-slate-600 font-semibold">Last Used</TableHead>
                  <TableHead className="w-20" />
                </TableRow>
              </TableHeader>
              <TableBody>
                {filtered.map((skill) => (
                  <TableRow key={skill.id} className="hover:bg-slate-50 transition-colors">
                    <TableCell className="font-medium text-slate-800">{skill.name}</TableCell>
                    <TableCell className="text-slate-500 text-sm">{skill.category}</TableCell>
                    <TableCell>
                      <Badge
                        className={`text-xs border ${proficiencyConfig[skill.proficiency]?.className ?? ""}`}
                        variant="outline"
                      >
                        {skill.proficiency}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <Badge
                        className={`text-xs border ${skillTypeConfig[skill.skill_type]?.className ?? ""}`}
                        variant="outline"
                      >
                        {skill.skill_type}
                      </Badge>
                    </TableCell>
                    <TableCell className="text-slate-500 text-sm">{skill.years_of_exp}y</TableCell>
                    <TableCell className="text-slate-500 text-sm">{skill.year_last_used ?? "—"}</TableCell>
                    <TableCell>
                      <div className="flex items-center gap-1">
                        <Button
                          variant="ghost"
                          size="icon"
                          className="w-7 h-7 text-slate-400 hover:text-blue-600 hover:bg-blue-50"
                          onClick={() => openEdit(skill)}
                        >
                          <PencilIcon className="w-3.5 h-3.5" />
                        </Button>
                        <Button
                          variant="ghost"
                          size="icon"
                          className="w-7 h-7 text-slate-400 hover:text-red-600 hover:bg-red-50"
                          onClick={() => handleDelete(skill.id)}
                          disabled={deletingId === skill.id}
                        >
                          {deletingId === skill.id ? (
                            <Loader2Icon className="w-3.5 h-3.5 animate-spin" />
                          ) : (
                            <Trash2Icon className="w-3.5 h-3.5" />
                          )}
                        </Button>
                      </div>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>
        )}
      </div>

      {/* Add/Edit dialog */}
      <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle>{editSkill ? "Edit skill" : "Add skill"}</DialogTitle>
            <DialogDescription>
              {editSkill ? "Update the details for this skill." : "Add a new skill to your profile."}
            </DialogDescription>
          </DialogHeader>

          <div className="space-y-4 py-2">
            <div className="grid grid-cols-2 gap-3">
              <div className="col-span-2 space-y-1.5">
                <Label className="text-sm text-slate-700">Skill name *</Label>
                <Input
                  value={form.name ?? ""}
                  onChange={(e) => setField("name", e.target.value)}
                  placeholder="e.g. React"
                  className="border-slate-300"
                />
              </div>

              <div className="space-y-1.5">
                <Label className="text-sm text-slate-700">Category</Label>
                <Input
                  value={form.category ?? ""}
                  onChange={(e) => setField("category", e.target.value)}
                  placeholder="e.g. Frontend"
                  className="border-slate-300"
                />
              </div>

              <div className="space-y-1.5">
                <Label className="text-sm text-slate-700">Years of experience</Label>
                <Input
                  type="number"
                  min={0}
                  value={form.years_of_exp ?? "0"}
                  onChange={(e) => setField("years_of_exp", e.target.value)}
                  className="border-slate-300"
                />
              </div>

              <div className="space-y-1.5">
                <Label className="text-sm text-slate-700">Proficiency</Label>
                <Select
                  value={form.proficiency ?? "Intermediate"}
                  onValueChange={(v) => setField("proficiency", v ?? "Intermediate")}
                >
                  <SelectTrigger className="border-slate-300">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="Beginner">Beginner</SelectItem>
                    <SelectItem value="Intermediate">Intermediate</SelectItem>
                    <SelectItem value="Advanced">Advanced</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-1.5">
                <Label className="text-sm text-slate-700">Skill type</Label>
                <Select
                  value={form.skill_type ?? "Primary"}
                  onValueChange={(v) => setField("skill_type", v ?? "Primary")}
                >
                  <SelectTrigger className="border-slate-300">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="Primary">Primary</SelectItem>
                    <SelectItem value="Secondary">Secondary</SelectItem>
                    <SelectItem value="Tertiary">Tertiary</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-1.5">
                <Label className="text-sm text-slate-700">Year last used</Label>
                <Input
                  type="number"
                  min={2000}
                  max={new Date().getFullYear()}
                  value={form.year_last_used ?? new Date().getFullYear()}
                  onChange={(e) => setField("year_last_used", parseInt(e.target.value))}
                  className="border-slate-300"
                />
              </div>

              <div className="space-y-1.5">
                <Label className="text-sm text-slate-700">Certified?</Label>
                <Select
                  value={form.certification ?? "No"}
                  onValueChange={(v) => setField("certification", v ?? "No")}
                >
                  <SelectTrigger className="border-slate-300">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="Yes">Yes</SelectItem>
                    <SelectItem value="No">No</SelectItem>
                  </SelectContent>
                </Select>
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
