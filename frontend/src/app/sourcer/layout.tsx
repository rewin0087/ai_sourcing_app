"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import {
  LayoutDashboardIcon,
  SearchIcon,
  UsersIcon,
  FileTextIcon,
  LogOutIcon,
  ZapIcon,
  MenuIcon,
  XIcon,
  WandSparklesIcon,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Separator } from "@/components/ui/separator";
import { authApi } from "@/lib/api";
import { getStoredUser, clearAuth } from "@/lib/auth";
import { toast } from "sonner";

const navItems = [
  { label: "Dashboard", href: "/sourcer", icon: LayoutDashboardIcon, exact: true },
  { label: "Refine JD", href: "/sourcer/refine", icon: WandSparklesIcon },
  { label: "Find Candidates", href: "/sourcer/search", icon: SearchIcon },
  { label: "Candidates DB", href: "/sourcer/candidates", icon: UsersIcon },
  { label: "Job Descriptions", href: "/sourcer/jobs", icon: FileTextIcon },
];

export default function SourcerLayout({ children }: { children: React.ReactNode }) {
  const router = useRouter();
  const pathname = usePathname();
  const [user, setUser] = useState<{ full_name: string; email: string } | null>(null);
  const [mobileOpen, setMobileOpen] = useState(false);

  useEffect(() => {
    const stored = getStoredUser();
    if (!stored) {
      router.replace("/login");
      return;
    }
    if (stored.role !== "sourcer" && stored.role !== "admin") {
      router.replace(stored.role === "candidate" ? "/candidate" : "/login");
      return;
    }
    setUser({ full_name: stored.full_name, email: stored.email });
  }, [router]);

  async function handleLogout() {
    try {
      await authApi.logout();
    } catch {
      // ignore
    }
    clearAuth();
    toast.success("Signed out successfully.");
    router.push("/login");
  }

  function isActive(item: { href: string; exact?: boolean }) {
    if (item.exact) return pathname === item.href;
    return pathname.startsWith(item.href);
  }

  const initials = user?.full_name
    ? user.full_name
        .split(" ")
        .slice(0, 2)
        .map((n) => n[0])
        .join("")
        .toUpperCase()
    : "?";

  if (!user) return null;

  const Sidebar = () => (
    <aside className="flex flex-col h-full bg-slate-900 text-white w-64 flex-shrink-0">
      {/* Brand */}
      <div className="flex items-center gap-2 px-5 py-5 border-b border-slate-700/50">
        <div className="w-8 h-8 rounded-lg bg-blue-500 flex items-center justify-center flex-shrink-0">
          <ZapIcon className="w-5 h-5 text-white" />
        </div>
        <span className="font-bold text-lg">TalentHub</span>
      </div>

      {/* User */}
      <div className="px-5 py-4 border-b border-slate-700/50">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-full bg-emerald-600 flex items-center justify-center text-white font-semibold text-sm flex-shrink-0">
            {initials}
          </div>
          <div className="min-w-0">
            <p className="text-white text-sm font-semibold truncate">{user.full_name}</p>
            <p className="text-slate-400 text-xs">Recruiter</p>
          </div>
        </div>
      </div>

      {/* Navigation */}
      <nav className="flex-1 px-3 py-4 space-y-1 overflow-y-auto">
        {navItems.map((item) => {
          const active = isActive(item);
          return (
            <Link
              key={item.href}
              href={item.href}
              onClick={() => setMobileOpen(false)}
              className={`flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium transition-all ${
                active
                  ? "bg-emerald-600 text-white"
                  : "text-slate-400 hover:text-white hover:bg-slate-800"
              }`}
            >
              <item.icon className="w-4 h-4 flex-shrink-0" />
              {item.label}
            </Link>
          );
        })}
      </nav>

      <Separator className="bg-slate-700/50" />

      <div className="px-3 py-4">
        <Button
          variant="ghost"
          className="w-full justify-start text-slate-400 hover:text-red-400 hover:bg-red-500/10 gap-3 text-sm"
          onClick={handleLogout}
        >
          <LogOutIcon className="w-4 h-4" />
          Sign out
        </Button>
      </div>
    </aside>
  );

  return (
    <div className="flex h-screen bg-slate-50">
      {/* Desktop sidebar */}
      <div className="hidden md:flex">
        <Sidebar />
      </div>

      {/* Mobile sidebar overlay */}
      {mobileOpen && (
        <div className="fixed inset-0 z-50 md:hidden">
          <div
            className="absolute inset-0 bg-black/60"
            onClick={() => setMobileOpen(false)}
          />
          <div className="relative w-64 h-full">
            <Sidebar />
          </div>
        </div>
      )}

      {/* Main */}
      <div className="flex-1 flex flex-col min-w-0 overflow-hidden">
        {/* Mobile topbar */}
        <div className="flex md:hidden items-center gap-3 px-4 py-3 bg-slate-900 border-b border-slate-700">
          <Button
            variant="ghost"
            size="icon"
            className="text-white hover:bg-slate-800"
            onClick={() => setMobileOpen(!mobileOpen)}
          >
            {mobileOpen ? <XIcon className="w-5 h-5" /> : <MenuIcon className="w-5 h-5" />}
          </Button>
          <span className="text-white font-semibold">Recruiter Portal</span>
        </div>

        <main className="flex-1 overflow-y-auto">{children}</main>
      </div>
    </div>
  );
}
