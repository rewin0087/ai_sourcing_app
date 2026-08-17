"use client";

import { useState, useEffect, useCallback } from "react";
import { toast } from "sonner";
import {
  PlusIcon,
  Loader2Icon,
  PencilIcon,
  Trash2Icon,
  AwardIcon,
  CalendarIcon,
  AlertCircleIcon,
  CheckCircleIcon,
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
import { candidateApi, Certification } from "@/lib/api";

function formatDate(dateStr?: string) {
  if (!dateStr) return "";
  const d = new Date(dateStr);
  return d.toLocaleDateString("en-US", { month: "short", year: "numeric" });
}

function isExpired(dateStr?: string) {
  if (!dateStr) return false;
  return new Date(dateStr) < new Date();
}

const emptyForm: Partial<Certification> = {
  certificate_name: "",
  issuing_org: "",
  issue_date: "",
  expiry_date: "",
  skills_covered: "",
};

export default function CertificationsPage() {
  const [certifications, setCertifications] = useState<Certification[]>([]);
  const [loading, setLoading] = useState(true);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editCert, setEditCert] = useState<Certification | null>(null);
  const [form, setForm] = useState<Partial<Certification>>(emptyForm);
  const [saving, setSaving] = useState(false);
  const [deletingId, setDeletingId] = useState<number | null>(null);

  const fetchCertifications = useCallback(async () => {
    setLoading(true);
    try {
      const res = await candidateApi.getCertifications();
      const rawCert = res.data?.data;
      setCertifications(Array.isArray(rawCert) ? rawCert : []);
    } catch {
      toast.error("Failed to load certifications.");
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchCertifications();
  }, [fetchCertifications]);

  function openAdd() {
    setEditCert(null);
    setForm(emptyForm);
    setDialogOpen(true);
  }

  function openEdit(cert: Certification) {
    setEditCert(cert);
    setForm({ ...cert });
    setDialogOpen(true);
  }

  function setField(field: keyof Certification, value: string) {
    setForm((prev) => ({ ...prev, [field]: value }));
  }

  async function handleSave() {
    if (!form.certificate_name?.trim()) {
      toast.error("Certificate name is required.");
      return;
    }
    setSaving(true);
    try {
      if (editCert) {
        await candidateApi.updateCertification(editCert.id, form);
        toast.success("Certification updated.");
      } else {
        await candidateApi.createCertification(form);
        toast.success("Certification added.");
      }
      setDialogOpen(false);
      fetchCertifications();
    } catch {
      toast.error("Failed to save certification.");
    } finally {
      setSaving(false);
    }
  }

  async function handleDelete(id: number) {
    setDeletingId(id);
    try {
      await candidateApi.deleteCertification(id);
      toast.success("Certification removed.");
      setCertifications((prev) => prev.filter((c) => c.id !== id));
    } catch {
      toast.error("Failed to delete certification.");
    } finally {
      setDeletingId(null);
    }
  }

  const active = certifications.filter((c) => !isExpired(c.expiry_date));
  const expired = certifications.filter((c) => isExpired(c.expiry_date));

  return (
    <div className="p-6 max-w-4xl mx-auto space-y-5">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
        <div>
          <h1 className="text-2xl font-bold text-slate-900">Certifications</h1>
          <p className="text-slate-500 text-sm mt-0.5">
            {active.length} valid · {expired.length} expired
          </p>
        </div>
        <Button className="bg-blue-600 hover:bg-blue-500 text-white" onClick={openAdd}>
          <PlusIcon className="w-4 h-4 mr-2" />
          Add certification
        </Button>
      </div>

      {loading ? (
        <div className="flex items-center justify-center py-20">
          <Loader2Icon className="w-6 h-6 text-blue-600 animate-spin" />
        </div>
      ) : certifications.length === 0 ? (
        <div className="bg-white border border-slate-200 rounded-xl p-16 flex flex-col items-center shadow-sm">
          <AwardIcon className="w-12 h-12 text-slate-300 mb-3" />
          <p className="text-slate-500 font-medium">No certifications yet.</p>
          <Button className="mt-4 bg-blue-600 hover:bg-blue-500 text-white" onClick={openAdd}>
            <PlusIcon className="w-4 h-4 mr-2" />
            Add certification
          </Button>
        </div>
      ) : (
        <div className="space-y-3">
          {certifications.map((cert) => {
            const expired = isExpired(cert.expiry_date);
            return (
              <div
                key={cert.id}
                className={`bg-white border rounded-xl shadow-sm p-5 ${
                  expired ? "border-red-200" : "border-slate-200"
                }`}
              >
                <div className="flex items-start gap-4">
                  <div
                    className={`w-11 h-11 rounded-lg flex items-center justify-center flex-shrink-0 ${
                      expired ? "bg-red-50" : "bg-amber-50"
                    }`}
                  >
                    <AwardIcon
                      className={`w-5 h-5 ${expired ? "text-red-500" : "text-amber-600"}`}
                    />
                  </div>

                  <div className="flex-1 min-w-0">
                    <div className="flex flex-wrap items-center gap-2 mb-1">
                      <h3 className="text-slate-900 font-semibold text-base leading-tight">
                        {cert.certificate_name}
                      </h3>
                      {cert.expiry_date ? (
                        expired ? (
                          <Badge className="bg-red-100 text-red-700 border-red-200 text-xs flex items-center gap-1">
                            <AlertCircleIcon className="w-3 h-3" />
                            Expired
                          </Badge>
                        ) : (
                          <Badge className="bg-emerald-100 text-emerald-700 border-emerald-200 text-xs flex items-center gap-1">
                            <CheckCircleIcon className="w-3 h-3" />
                            Valid
                          </Badge>
                        )
                      ) : (
                        <Badge className="bg-slate-100 text-slate-600 border-slate-200 text-xs">
                          No expiry
                        </Badge>
                      )}
                    </div>

                    {cert.issuing_org && (
                      <p className="text-slate-600 text-sm">{cert.issuing_org}</p>
                    )}

                    <div className="flex flex-wrap items-center gap-4 mt-2">
                      {cert.issue_date && (
                        <span className="flex items-center gap-1 text-xs text-slate-500">
                          <CalendarIcon className="w-3 h-3" />
                          Issued: {formatDate(cert.issue_date)}
                        </span>
                      )}
                      {cert.expiry_date && (
                        <span
                          className={`flex items-center gap-1 text-xs ${
                            expired ? "text-red-500" : "text-slate-500"
                          }`}
                        >
                          <CalendarIcon className="w-3 h-3" />
                          Expires: {formatDate(cert.expiry_date)}
                        </span>
                      )}
                    </div>

                    {cert.skills_covered && (
                      <p className="text-slate-500 text-xs mt-2">
                        <span className="font-medium">Skills covered:</span> {cert.skills_covered}
                      </p>
                    )}
                  </div>

                  <div className="flex items-center gap-1 flex-shrink-0">
                    <Button
                      variant="ghost"
                      size="icon"
                      className="w-8 h-8 text-slate-400 hover:text-blue-600 hover:bg-blue-50"
                      onClick={() => openEdit(cert)}
                    >
                      <PencilIcon className="w-4 h-4" />
                    </Button>
                    <Button
                      variant="ghost"
                      size="icon"
                      className="w-8 h-8 text-slate-400 hover:text-red-600 hover:bg-red-50"
                      onClick={() => handleDelete(cert.id)}
                      disabled={deletingId === cert.id}
                    >
                      {deletingId === cert.id ? (
                        <Loader2Icon className="w-4 h-4 animate-spin" />
                      ) : (
                        <Trash2Icon className="w-4 h-4" />
                      )}
                    </Button>
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      )}

      {/* Add/Edit dialog */}
      <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle>{editCert ? "Edit certification" : "Add certification"}</DialogTitle>
            <DialogDescription>Enter your certification details.</DialogDescription>
          </DialogHeader>

          <div className="space-y-4 py-2">
            <div className="space-y-1.5">
              <Label className="text-sm text-slate-700">Certificate name *</Label>
              <Input
                value={form.certificate_name ?? ""}
                onChange={(e) => setField("certificate_name", e.target.value)}
                placeholder="AWS Solutions Architect"
                className="border-slate-300"
              />
            </div>

            <div className="space-y-1.5">
              <Label className="text-sm text-slate-700">Issuing organization</Label>
              <Input
                value={form.issuing_org ?? ""}
                onChange={(e) => setField("issuing_org", e.target.value)}
                placeholder="Amazon Web Services"
                className="border-slate-300"
              />
            </div>

            <div className="grid grid-cols-2 gap-3">
              <div className="space-y-1.5">
                <Label className="text-sm text-slate-700">Issue date</Label>
                <Input
                  type="date"
                  value={form.issue_date ?? ""}
                  onChange={(e) => setField("issue_date", e.target.value)}
                  className="border-slate-300"
                />
              </div>
              <div className="space-y-1.5">
                <Label className="text-sm text-slate-700">Expiry date</Label>
                <Input
                  type="date"
                  value={form.expiry_date ?? ""}
                  onChange={(e) => setField("expiry_date", e.target.value)}
                  className="border-slate-300"
                />
              </div>
            </div>

            <div className="space-y-1.5">
              <Label className="text-sm text-slate-700">Skills covered</Label>
              <Input
                value={form.skills_covered ?? ""}
                onChange={(e) => setField("skills_covered", e.target.value)}
                placeholder="Cloud architecture, serverless, IAM…"
                className="border-slate-300"
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
