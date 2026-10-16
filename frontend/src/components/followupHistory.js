import { parseServerUtc } from './calendarUtils';

// When a follow-up was actually done (older rows only have updated_at)
export const completedDate = (f) => parseServerUtc(f.completed_at || f.updated_at || f.scheduled_at);

// Completed follow-ups, oldest first, each numbered per contact: number 1 is the first follow-up
export const numberedHistory = (followups) => {
  const counts = new Map();
  return (followups || [])
    .filter(f => f.status === 'Completed')
    .map(f => ({ ...f, doneAt: completedDate(f) }))
    .filter(f => f.doneAt)
    .sort((a, b) => a.doneAt - b.doneAt)
    .map(f => {
      const number = (counts.get(f.client_id) || 0) + 1;
      counts.set(f.client_id, number);
      return { ...f, number };
    });
};

export const ordinal = (n) => {
  const tens = n % 100;
  if (tens >= 11 && tens <= 13) return `${n}th`;
  return `${n}${{ 1: 'st', 2: 'nd', 3: 'rd' }[n % 10] || 'th'}`;
};

// Notes hold the pre-planned agenda, then "[Completed Outcome]: …" for what was discussed
export const splitFollowupNotes = (notes) => {
  const [plan, ...outcomes] = (notes || '').split('[Completed Outcome]:');
  return {
    plan: plan.trim(),
    outcome: outcomes.map(o => o.trim()).filter(Boolean).join('\n')
  };
};

// Imported rows without a named contact were saved as "<Company> Contact"
export const contactNames = (f) => ({
  company: f.client_company || f.client_name || 'Unknown contact',
  rep: f.client_name && f.client_company && f.client_name !== `${f.client_company} Contact` ? f.client_name : null
});

export const startOfDay = (d) => new Date(d.getFullYear(), d.getMonth(), d.getDate());

export const longDayLabel = (d) => d.toLocaleDateString([], {
  weekday: 'short',
  month: 'short',
  day: 'numeric',
  ...(d.getFullYear() === new Date().getFullYear() ? {} : { year: 'numeric' })
});
