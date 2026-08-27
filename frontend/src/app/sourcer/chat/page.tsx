"use client";

import { useState, useEffect, useRef, useCallback } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import Link from "next/link";
import { toast } from "sonner";
import {
  BotIcon,
  SendIcon,
  PlusIcon,
  Loader2Icon,
  Trash2Icon,
  UserIcon,
  ExternalLinkIcon,
  BriefcaseIcon,
  MapPinIcon,
  ZapIcon,
  SearchIcon,
  BarChart3Icon,
  MessageSquareIcon,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Badge } from "@/components/ui/badge";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Separator } from "@/components/ui/separator";
import {
  sourcingApi,
  ChatMessage,
  ChatSession,
  ChatCandidateSummary,
  ChatStats,
} from "@/lib/api";

// ── HTML response renderer ────────────────────────────────────────────────────

function extractSuggestionsFromHtml(html: string): { cleanHtml: string; suggestions: string[] } {
  const match = html.match(/<!--\s*suggestions:\s*(\[[\s\S]*?\])\s*-->/);
  if (!match) return { cleanHtml: html, suggestions: [] };

  let suggestions: string[] = [];
  try {
    suggestions = JSON.parse(match[1]);
  } catch {
    // ignore malformed comment
  }

  const cleanHtml = html.replace(/<!--\s*suggestions:[\s\S]*?-->/g, "").trim();
  return { cleanHtml, suggestions };
}

// ── Candidate mini-card ──────────────────────────────────────────────────────

function CandidateCard({ candidate }: { candidate: ChatCandidateSummary }) {
  return (
    <div className="bg-white border border-slate-200 rounded-lg p-3 space-y-2 hover:border-blue-300 transition-colors">
      <div className="flex items-start justify-between gap-2">
        <div className="min-w-0">
          <p className="font-semibold text-slate-900 text-sm truncate">{candidate.full_name}</p>
          {candidate.current_title && (
            <div className="flex items-center gap-1 text-slate-500 text-xs mt-0.5">
              <BriefcaseIcon className="w-3 h-3 flex-shrink-0" />
              <span className="truncate">{candidate.current_title}</span>
            </div>
          )}
          {candidate.location && (
            <div className="flex items-center gap-1 text-slate-400 text-xs">
              <MapPinIcon className="w-3 h-3 flex-shrink-0" />
              <span className="truncate">{candidate.location}</span>
            </div>
          )}
        </div>
        <div className="text-right flex-shrink-0">
          <p className="text-xs font-semibold text-blue-700">{candidate.total_experience_years}yr</p>
          <p className="text-xs text-slate-400">exp</p>
        </div>
      </div>
      {candidate.skills.length > 0 && (
        <div className="flex flex-wrap gap-1">
          {candidate.skills.slice(0, 5).map((s) => (
            <Badge key={s.name} variant="outline" className="bg-blue-50 text-blue-700 border-blue-200 text-xs px-1.5 py-0">
              {s.name}
            </Badge>
          ))}
          {candidate.skills.length > 5 && (
            <Badge variant="outline" className="bg-slate-50 text-slate-500 border-slate-200 text-xs px-1.5 py-0">
              +{candidate.skills.length - 5}
            </Badge>
          )}
        </div>
      )}
      <Link href={`/sourcer/candidates/${candidate.id}`} target="_blank">
        <Button variant="ghost" size="sm" className="text-xs text-blue-600 hover:text-blue-700 p-0 h-auto gap-1 mt-1">
          <ExternalLinkIcon className="w-3 h-3" />
          Full profile
        </Button>
      </Link>
    </div>
  );
}

// ── Stats card ───────────────────────────────────────────────────────────────

function StatsCard({ stats }: { stats: ChatStats }) {
  const data = stats.data as Record<string, unknown>;

  const renderTable = (obj: Record<string, unknown>, title: string) => {
    const entries = Object.entries(obj).filter(([, v]) => v !== null);
    if (!entries.length) return null;
    return (
      <div key={title} className="mb-3">
        <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1.5">{title}</p>
        <div className="space-y-1">
          {entries.map(([k, v]) => (
            <div key={k} className="flex items-center justify-between text-sm">
              <span className="text-slate-700 truncate max-w-[60%]">{k}</span>
              <span className="font-semibold text-slate-900 ml-2">{String(v)}</span>
            </div>
          ))}
        </div>
      </div>
    );
  };

  const title: Record<ChatStats["type"], string> = {
    database_summary: "Database Overview",
    experience_report: "Experience Levels",
    role_distribution: "Role Distribution",
    skill_report: "Skill Report",
    top_skills_by_category: "Skills by Category",
  };

  return (
    <div className="bg-slate-50 border border-slate-200 rounded-lg p-3 mt-2">
      <div className="flex items-center gap-1.5 mb-3">
        <BarChart3Icon className="w-4 h-4 text-violet-600" />
        <p className="text-sm font-semibold text-slate-800">{title[stats.type]}</p>
      </div>

      {stats.type === "database_summary" && (
        <>
          {data.total_candidates !== undefined && (
            <p className="text-2xl font-bold text-slate-900 mb-3">{String(data.total_candidates)} <span className="text-sm font-normal text-slate-500">candidates total</span></p>
          )}
          {renderTable(data.experience_levels as Record<string, unknown> || {}, "Experience Levels")}
          {renderTable(data.role_distribution as Record<string, unknown> || {}, "Top Roles")}
        </>
      )}

      {stats.type === "experience_report" && (
        <>
          {data.average_years !== undefined && (
            <p className="text-sm text-slate-600 mb-2">Average: <strong>{String(data.average_years)} years</strong></p>
          )}
          {renderTable(data.levels as Record<string, unknown> || {}, "By Level")}
        </>
      )}

      {stats.type === "role_distribution" && renderTable(data as Record<string, unknown>, "Roles")}

      {stats.type === "skill_report" && (
        <>
          <div className="grid grid-cols-2 gap-2 mb-3">
            {[
              ["Candidates", data.total_candidates_with_skill],
              ["Avg experience", `${Math.round((data.avg_months_experience as number || 0) / 12 * 10) / 10}yr`],
              ["With certification", data.with_certification],
            ].map(([label, value]) => (
              <div key={String(label)} className="bg-white border border-slate-200 rounded p-2">
                <p className="text-xs text-slate-500">{label}</p>
                <p className="font-bold text-slate-900">{String(value)}</p>
              </div>
            ))}
          </div>
          {renderTable(data.by_proficiency as Record<string, unknown> || {}, "By Proficiency")}
        </>
      )}

      {stats.type === "top_skills_by_category" && (
        <div className="space-y-3">
          {Object.entries(data).map(([cat, skills]) =>
            renderTable(skills as Record<string, unknown>, cat)
          )}
        </div>
      )}
    </div>
  );
}

// ── Message bubble ────────────────────────────────────────────────────────────

function MessageBubble({ msg }: { msg: ChatMessage }) {
  const isUser = msg.role === "user";

  const { cleanHtml, suggestions } = !isUser
    ? extractSuggestionsFromHtml(msg.content)
    : { cleanHtml: msg.content, suggestions: [] };

  return (
    <div className={`flex gap-3 ${isUser ? "flex-row-reverse" : "flex-row"}`}>
      {/* Avatar */}
      <div className={`w-7 h-7 rounded-full flex items-center justify-center flex-shrink-0 mt-0.5 ${isUser ? "bg-blue-600" : "bg-violet-600"}`}>
        {isUser ? <UserIcon className="w-4 h-4 text-white" /> : <BotIcon className="w-4 h-4 text-white" />}
      </div>

      <div className={`max-w-[85%] space-y-2 ${isUser ? "items-end" : "items-start"} flex flex-col`}>
        {/* Content bubble */}
        <div className={`px-4 py-3 rounded-2xl ${isUser ? "bg-blue-600 text-white rounded-tr-sm" : "bg-white border border-slate-200 rounded-tl-sm shadow-sm"}`}>
          {isUser ? (
            <p className="text-sm text-white">{msg.content}</p>
          ) : (
            <div
              className="chat-response"
              dangerouslySetInnerHTML={{ __html: cleanHtml }}
            />
          )}
        </div>

        {/* Candidate cards */}
        {!isUser && msg.candidates && msg.candidates.length > 0 && (
          <div className="w-full space-y-2">
            <p className="text-xs text-slate-400 font-medium px-1">
              {msg.candidates.length} candidate{msg.candidates.length !== 1 ? "s" : ""}
            </p>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
              {msg.candidates.map((c) => (
                <CandidateCard key={c.id} candidate={c} />
              ))}
            </div>
          </div>
        )}

        {/* Stats card */}
        {!isUser && msg.stats && <StatsCard stats={msg.stats} />}

        {/* Suggestion chips */}
        {!isUser && suggestions.length > 0 && (
          <div className="flex flex-wrap gap-1.5 pt-1">
            {suggestions.map((s, i) => (
              <SuggestionChip key={i} text={s} />
            ))}
          </div>
        )}
      </div>
    </div>
  );
}

// ── Suggestion chip (click to send) ─────────────────────────────────────────

function SuggestionChip({ text }: { text: string }) {
  return (
    <button
      onClick={() => {
        // Dispatch a custom event that the input listens to
        window.dispatchEvent(new CustomEvent("chat:suggest", { detail: text }));
      }}
      className="text-xs bg-violet-50 text-violet-700 border border-violet-200 rounded-full px-3 py-1 hover:bg-violet-100 transition-colors text-left"
    >
      {text}
    </button>
  );
}

// ── Welcome screen ────────────────────────────────────────────────────────────

const STARTER_PROMPTS = [
  { icon: BarChart3Icon, text: "Give me an overview of all candidates in the database" },
  { icon: SearchIcon, text: "Find me senior React developers with fintech experience" },
  { icon: ZapIcon, text: "How many backend engineers do we have and what are their top skills?" },
  { icon: MessageSquareIcon, text: "Show me the experience level breakdown of all candidates" },
];

function WelcomeScreen({ onPrompt }: { onPrompt: (text: string) => void }) {
  return (
    <div className="flex flex-col items-center justify-center h-full py-16 px-6 text-center">
      <div className="w-14 h-14 bg-violet-600 rounded-2xl flex items-center justify-center mb-4">
        <BotIcon className="w-8 h-8 text-white" />
      </div>
      <h2 className="text-xl font-bold text-slate-900 mb-2">TalentBot</h2>
      <p className="text-slate-500 text-sm mb-8 max-w-sm">
        Your AI recruiting assistant. Ask me about candidates, generate talent pool reports, or find the perfect hire.
      </p>
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 w-full max-w-lg">
        {STARTER_PROMPTS.map((p) => (
          <button
            key={p.text}
            onClick={() => onPrompt(p.text)}
            className="flex items-start gap-3 bg-white border border-slate-200 rounded-xl p-4 hover:border-violet-300 hover:shadow-sm transition-all text-left group"
          >
            <p.icon className="w-4 h-4 text-violet-500 mt-0.5 flex-shrink-0 group-hover:text-violet-600" />
            <span className="text-sm text-slate-700">{p.text}</span>
          </button>
        ))}
      </div>
    </div>
  );
}

// ── Main page ─────────────────────────────────────────────────────────────────

export default function ChatPage() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const initialSessionId = searchParams.get("session");

  const [sessions, setSessions] = useState<ChatSession[]>([]);
  const [activeSessionId, setActiveSessionId] = useState<number | null>(
    initialSessionId ? Number(initialSessionId) : null
  );
  const [messages, setMessages] = useState<ChatMessage[]>([]);
  const [input, setInput] = useState("");
  const [sending, setSending] = useState(false);
  const [loadingSession, setLoadingSession] = useState(false);

  const bottomRef = useRef<HTMLDivElement>(null);
  const textareaRef = useRef<HTMLTextAreaElement>(null);

  // Load sessions list
  const loadSessions = useCallback(async () => {
    try {
      const res = await sourcingApi.getChatSessions();
      setSessions(res.data.data ?? []);
    } catch {
      // silently ignore
    }
  }, []);

  useEffect(() => {
    loadSessions();
  }, [loadSessions]);

  // Load a session's messages
  useEffect(() => {
    if (!activeSessionId) return;
    setLoadingSession(true);
    sourcingApi.getChatSession(activeSessionId)
      .then((res) => {
        setMessages(res.data.data?.messages ?? []);
      })
      .catch(() => toast.error("Failed to load conversation."))
      .finally(() => setLoadingSession(false));
  }, [activeSessionId]);

  // Scroll to bottom when messages change
  useEffect(() => {
    bottomRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages, sending]);

  // Listen for suggestion chip clicks
  useEffect(() => {
    const handler = (e: Event) => {
      const text = (e as CustomEvent<string>).detail;
      setInput(text);
      textareaRef.current?.focus();
    };
    window.addEventListener("chat:suggest", handler);
    return () => window.removeEventListener("chat:suggest", handler);
  }, []);

  async function sendMessage(text?: string) {
    const messageText = (text ?? input).trim();
    if (!messageText || sending) return;

    setInput("");
    setSending(true);

    // Optimistically add user message
    const tempUserMsg: ChatMessage = {
      id: `temp-${Date.now()}`,
      role: "user",
      content: messageText,
      timestamp: new Date().toISOString(),
    };
    setMessages((prev) => [...prev, tempUserMsg]);

    try {
      const res = await sourcingApi.sendChatMessage(messageText, activeSessionId ?? undefined);
      const { session_id, message } = res.data.data;

      if (!activeSessionId) {
        setActiveSessionId(session_id);
        router.replace(`/sourcer/chat?session=${session_id}`, { scroll: false });
      }

      setMessages((prev) => [...prev.filter((m) => m.id !== tempUserMsg.id), tempUserMsg, message]);
      loadSessions();
    } catch {
      toast.error("Failed to send message. Please try again.");
      setMessages((prev) => prev.filter((m) => m.id !== tempUserMsg.id));
      setInput(messageText);
    } finally {
      setSending(false);
    }
  }

  async function startNewChat() {
    setActiveSessionId(null);
    setMessages([]);
    router.replace("/sourcer/chat", { scroll: false });
  }

  async function deleteSession(id: number) {
    try {
      await sourcingApi.deleteChatSession(id);
      setSessions((prev) => prev.filter((s) => s.id !== id));
      if (activeSessionId === id) {
        setActiveSessionId(null);
        setMessages([]);
        router.replace("/sourcer/chat", { scroll: false });
      }
      toast.success("Conversation deleted.");
    } catch {
      toast.error("Failed to delete conversation.");
    }
  }

  function handleKeyDown(e: React.KeyboardEvent<HTMLTextAreaElement>) {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault();
      sendMessage();
    }
  }

  return (
    <div className="flex h-full">
      {/* ── Sidebar ── */}
      <div className="w-60 flex-shrink-0 bg-slate-950 flex flex-col border-r border-slate-800">
        <div className="p-3">
          <Button
            onClick={startNewChat}
            className="w-full bg-slate-800 hover:bg-slate-700 text-white border border-slate-700 gap-2 justify-start text-sm"
            variant="ghost"
          >
            <PlusIcon className="w-4 h-4" />
            New conversation
          </Button>
        </div>

        <Separator className="bg-slate-800" />

        <ScrollArea className="flex-1 p-2">
          {sessions.length === 0 ? (
            <p className="text-slate-500 text-xs text-center mt-4 px-3">No conversations yet</p>
          ) : (
            <div className="space-y-0.5">
              {sessions.map((s) => (
                <div
                  key={s.id}
                  className={`group relative flex items-center gap-2 px-3 py-2 rounded-lg cursor-pointer transition-colors ${
                    activeSessionId === s.id
                      ? "bg-slate-700 text-white"
                      : "text-slate-400 hover:bg-slate-800 hover:text-white"
                  }`}
                  onClick={() => {
                    setActiveSessionId(s.id);
                    router.replace(`/sourcer/chat?session=${s.id}`, { scroll: false });
                  }}
                >
                  <MessageSquareIcon className="w-3.5 h-3.5 flex-shrink-0" />
                  <div className="flex-1 min-w-0">
                    <p className="text-xs font-medium truncate">{s.title}</p>
                    {s.last_message && (
                      <p className="text-xs text-slate-500 truncate">{s.last_message}</p>
                    )}
                  </div>
                  <button
                    onClick={(e) => { e.stopPropagation(); deleteSession(s.id); }}
                    className="opacity-0 group-hover:opacity-100 text-slate-500 hover:text-red-400 transition-opacity flex-shrink-0"
                  >
                    <Trash2Icon className="w-3.5 h-3.5" />
                  </button>
                </div>
              ))}
            </div>
          )}
        </ScrollArea>
      </div>

      {/* ── Chat area ── */}
      <div className="flex-1 flex flex-col min-w-0 bg-slate-50">
        {/* Header */}
        <div className="bg-white border-b border-slate-200 px-6 py-3 flex items-center gap-3">
          <div className="w-7 h-7 bg-violet-600 rounded-lg flex items-center justify-center">
            <BotIcon className="w-4 h-4 text-white" />
          </div>
          <div>
            <p className="font-semibold text-slate-900 text-sm">TalentBot</p>
            <p className="text-xs text-slate-400">AI Recruiting Assistant</p>
          </div>
        </div>

        {/* Messages */}
        <div className="flex-1 overflow-y-auto">
          {loadingSession ? (
            <div className="flex items-center justify-center h-full">
              <Loader2Icon className="w-6 h-6 text-violet-600 animate-spin" />
            </div>
          ) : messages.length === 0 ? (
            <WelcomeScreen onPrompt={(text) => sendMessage(text)} />
          ) : (
            <div className="px-4 py-6 space-y-6 max-w-3xl mx-auto">
              {messages.map((msg) => (
                <MessageBubble key={msg.id} msg={msg} />
              ))}

              {sending && (
                <div className="flex gap-3">
                  <div className="w-7 h-7 rounded-full bg-violet-600 flex items-center justify-center flex-shrink-0 mt-0.5">
                    <BotIcon className="w-4 h-4 text-white" />
                  </div>
                  <div className="bg-white border border-slate-200 rounded-2xl rounded-tl-sm px-4 py-3 shadow-sm">
                    <div className="flex items-center gap-1.5">
                      <span className="w-2 h-2 bg-violet-400 rounded-full animate-bounce" style={{ animationDelay: "0ms" }} />
                      <span className="w-2 h-2 bg-violet-400 rounded-full animate-bounce" style={{ animationDelay: "150ms" }} />
                      <span className="w-2 h-2 bg-violet-400 rounded-full animate-bounce" style={{ animationDelay: "300ms" }} />
                    </div>
                  </div>
                </div>
              )}

              <div ref={bottomRef} />
            </div>
          )}
        </div>

        {/* Input */}
        <div className="bg-white border-t border-slate-200 px-4 py-3">
          <div className="max-w-3xl mx-auto">
            <div className="flex gap-2 items-end bg-slate-50 border border-slate-300 rounded-2xl p-2 focus-within:border-violet-400 focus-within:ring-1 focus-within:ring-violet-100 transition-all">
              <Textarea
                ref={textareaRef}
                rows={1}
                value={input}
                onChange={(e) => setInput(e.target.value)}
                onKeyDown={handleKeyDown}
                placeholder="Ask about candidates, request reports, or find talent…"
                className="flex-1 border-0 bg-transparent resize-none focus-visible:ring-0 text-sm placeholder:text-slate-400 max-h-40 min-h-[36px] py-1.5"
                disabled={sending}
              />
              <Button
                onClick={() => sendMessage()}
                disabled={!input.trim() || sending}
                size="sm"
                className="bg-violet-600 hover:bg-violet-500 text-white rounded-xl flex-shrink-0"
              >
                {sending ? (
                  <Loader2Icon className="w-4 h-4 animate-spin" />
                ) : (
                  <SendIcon className="w-4 h-4" />
                )}
              </Button>
            </div>
            <p className="text-xs text-slate-400 text-center mt-2">
              Press Enter to send · Shift+Enter for new line
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
