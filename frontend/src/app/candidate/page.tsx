"use client";

import { useState, useEffect, useCallback } from "react";
import { toast } from "sonner";
import {
  Loader2Icon,
  UserIcon,
  PhoneIcon,
  MapPinIcon,
  BriefcaseIcon,
  Link2Icon,
  CheckCircleIcon,
  SaveIcon,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { Badge } from "@/components/ui/badge";
import { Separator } from "@/components/ui/separator";
import { candidateApi, Candidate } from "@/lib/api";

const profileFields = [
  "first_name",
  "last_name",
  "email",
  "phone",
  "city",
  "country",
  "current_title",
  "about_me",
  "linkedin_url",
  "github_url",
];

function calcCompletion(profile: Partial<Candidate>): number {
  const filled = profileFields.filter(
    (f) => profile[f as keyof Candidate] && String(profile[f as keyof Candidate]).trim() !== ""
  ).length;
  const skillsBonus = (profile.skills?.length ?? 0) > 0 ? 1 : 0;
  const expBonus = (profile.work_experiences?.length ?? 0) > 0 ? 1 : 0;
  const eduBonus = (profile.educations?.length ?? 0) > 0 ? 1 : 0;
  const total = profileFields.length + 3;
  return Math.round(((filled + skillsBonus + expBonus + eduBonus) / total) * 100);
}

export default function CandidateDashboardPage() {
  const [profile, setProfile] = useState<Partial<Candidate>>({});
  const [form, setForm] = useState<Partial<Candidate>>({});
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);

  const fetchProfile = useCallback(async () => {
    setLoading(true);
    try {
      const res = await candidateApi.getProfile();
      const data = res.data.data;
      setProfile(data);
      setForm({
        first_name: data.first_name,
        last_name: data.last_name,
        email: data.email,
        phone: data.phone,
        city: data.city,
        country: data.country,
        current_title: data.current_title,
        about_me: data.about_me,
        linkedin_url: data.linkedin_url,
        github_url: data.github_url,
      });
    } catch {
      toast.error("Failed to load profile.");
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchProfile();
  }, [fetchProfile]);

  function handleChange(field: string, value: string) {
    setForm((prev) => ({ ...prev, [field]: value }));
  }

  async function handleSave(e: React.FormEvent) {
    e.preventDefault();
    setSaving(true);
    try {
      await candidateApi.updateProfile(form);
      toast.success("Profile updated successfully!");
      fetchProfile();
    } catch {
      toast.error("Failed to save profile.");
    } finally {
      setSaving(false);
    }
  }

  const completion = calcCompletion({ ...profile, ...form });

  if (loading) {
    return (
      <div className="flex items-center justify-center h-full min-h-[400px]">
        <Loader2Icon className="w-8 h-8 text-blue-600 animate-spin" />
      </div>
    );
  }

  return (
    <div className="p-6 max-w-4xl mx-auto space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-slate-900">My Profile</h1>
        <p className="text-slate-500 text-sm mt-1">Keep your profile complete to improve match results.</p>
      </div>

      {/* Stats cards */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
        {[
          { label: "Skills", value: profile.skills?.length ?? 0, color: "text-blue-600" },
          { label: "Experiences", value: profile.work_experiences?.length ?? 0, color: "text-emerald-600" },
          { label: "Educations", value: profile.educations?.length ?? 0, color: "text-purple-600" },
          { label: "Certifications", value: profile.certifications?.length ?? 0, color: "text-amber-600" },
        ].map((stat) => (
          <Card key={stat.label} className="border-slate-200 bg-white shadow-sm">
            <CardContent className="p-4 text-center">
              <p className={`text-3xl font-bold ${stat.color}`}>{stat.value}</p>
              <p className="text-slate-500 text-xs mt-1">{stat.label}</p>
            </CardContent>
          </Card>
        ))}
      </div>

      {/* Profile completion */}
      <Card className="border-slate-200 bg-white shadow-sm">
        <CardHeader className="pb-3">
          <div className="flex items-center justify-between">
            <CardTitle className="text-base text-slate-800">Profile Completion</CardTitle>
            <div className="flex items-center gap-2">
              {completion === 100 && (
                <Badge className="bg-emerald-100 text-emerald-700 border-emerald-200">
                  <CheckCircleIcon className="w-3 h-3 mr-1" />
                  Complete
                </Badge>
              )}
              <span className="text-2xl font-bold text-blue-600">{completion}%</span>
            </div>
          </div>
        </CardHeader>
        <CardContent>
          <Progress value={completion} className="h-2" />
          {completion < 100 && (
            <p className="text-slate-500 text-xs mt-2">
              Complete your profile to appear in more search results.
            </p>
          )}
        </CardContent>
      </Card>

      {/* Profile form */}
      <Card className="border-slate-200 bg-white shadow-sm">
        <CardHeader>
          <CardTitle className="text-slate-800">Personal Information</CardTitle>
          <CardDescription>Your contact details and professional summary</CardDescription>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSave} className="space-y-5">
            {/* Name row */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div className="space-y-1.5">
                <Label htmlFor="first_name" className="text-slate-700 text-sm">
                  First name
                </Label>
                <div className="relative">
                  <UserIcon className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                  <Input
                    id="first_name"
                    value={form.first_name ?? ""}
                    onChange={(e) => handleChange("first_name", e.target.value)}
                    className="pl-9 border-slate-300"
                    placeholder="Jane"
                  />
                </div>
              </div>
              <div className="space-y-1.5">
                <Label htmlFor="last_name" className="text-slate-700 text-sm">
                  Last name
                </Label>
                <Input
                  id="last_name"
                  value={form.last_name ?? ""}
                  onChange={(e) => handleChange("last_name", e.target.value)}
                  className="border-slate-300"
                  placeholder="Doe"
                />
              </div>
            </div>

            {/* Email & phone */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div className="space-y-1.5">
                <Label htmlFor="email" className="text-slate-700 text-sm">
                  Email
                </Label>
                <Input
                  id="email"
                  type="email"
                  value={form.email ?? ""}
                  onChange={(e) => handleChange("email", e.target.value)}
                  className="border-slate-300"
                  placeholder="you@example.com"
                />
              </div>
              <div className="space-y-1.5">
                <Label htmlFor="phone" className="text-slate-700 text-sm">
                  Phone
                </Label>
                <div className="relative">
                  <PhoneIcon className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                  <Input
                    id="phone"
                    value={form.phone ?? ""}
                    onChange={(e) => handleChange("phone", e.target.value)}
                    className="pl-9 border-slate-300"
                    placeholder="+1 555 000 0000"
                  />
                </div>
              </div>
            </div>

            {/* City & country */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div className="space-y-1.5">
                <Label htmlFor="city" className="text-slate-700 text-sm">
                  City
                </Label>
                <div className="relative">
                  <MapPinIcon className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                  <Input
                    id="city"
                    value={form.city ?? ""}
                    onChange={(e) => handleChange("city", e.target.value)}
                    className="pl-9 border-slate-300"
                    placeholder="San Francisco"
                  />
                </div>
              </div>
              <div className="space-y-1.5">
                <Label htmlFor="country" className="text-slate-700 text-sm">
                  Country
                </Label>
                <Input
                  id="country"
                  value={form.country ?? ""}
                  onChange={(e) => handleChange("country", e.target.value)}
                  className="border-slate-300"
                  placeholder="United States"
                />
              </div>
            </div>

            {/* Current title */}
            <div className="space-y-1.5">
              <Label htmlFor="current_title" className="text-slate-700 text-sm">
                Current title / role
              </Label>
              <div className="relative">
                <BriefcaseIcon className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                <Input
                  id="current_title"
                  value={form.current_title ?? ""}
                  onChange={(e) => handleChange("current_title", e.target.value)}
                  className="pl-9 border-slate-300"
                  placeholder="Senior Software Engineer"
                />
              </div>
            </div>

            {/* About me */}
            <div className="space-y-1.5">
              <Label htmlFor="about_me" className="text-slate-700 text-sm">
                About me
              </Label>
              <Textarea
                id="about_me"
                rows={4}
                value={form.about_me ?? ""}
                onChange={(e) => handleChange("about_me", e.target.value)}
                className="border-slate-300 resize-none"
                placeholder="Brief professional summary…"
              />
            </div>

            <Separator className="bg-slate-100" />

            {/* Social links */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div className="space-y-1.5">
                <Label htmlFor="linkedin_url" className="text-slate-700 text-sm">
                  LinkedIn URL
                </Label>
                <div className="relative">
                  <Link2Icon className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                  <Input
                    id="linkedin_url"
                    type="url"
                    value={form.linkedin_url ?? ""}
                    onChange={(e) => handleChange("linkedin_url", e.target.value)}
                    className="pl-9 border-slate-300"
                    placeholder="https://linkedin.com/in/…"
                  />
                </div>
              </div>
              <div className="space-y-1.5">
                <Label htmlFor="github_url" className="text-slate-700 text-sm">
                  GitHub URL
                </Label>
                <div className="relative">
                  <Link2Icon className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                  <Input
                    id="github_url"
                    type="url"
                    value={form.github_url ?? ""}
                    onChange={(e) => handleChange("github_url", e.target.value)}
                    className="pl-9 border-slate-300"
                    placeholder="https://github.com/…"
                  />
                </div>
              </div>
            </div>

            <div className="flex justify-end pt-2">
              <Button
                type="submit"
                className="bg-blue-600 hover:bg-blue-500 text-white px-6"
                disabled={saving}
              >
                {saving ? (
                  <>
                    <Loader2Icon className="w-4 h-4 mr-2 animate-spin" />
                    Saving…
                  </>
                ) : (
                  <>
                    <SaveIcon className="w-4 h-4 mr-2" />
                    Save changes
                  </>
                )}
              </Button>
            </div>
          </form>
        </CardContent>
      </Card>
    </div>
  );
}
