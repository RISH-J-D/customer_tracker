import React from 'react';
import { CheckCircle2, CalendarDays } from 'lucide-react';
import { parseServerUtc, relativeDayLabel } from './calendarUtils';
import { numberedHistory, ordinal, startOfDay } from './followupHistory';

// Next pending follow-up, how many have been done, and a "Followed up" button
export default function NextFollowUpCell({ client, onFollowedUp }) {
  const next = (client.followups || [])
    .filter(f => f.status === 'Pending')
    .map(f => ({ ...f, date: parseServerUtc(f.scheduled_at) }))
    .filter(f => f.date)
    .sort((a, b) => a.date - b.date)[0];

  const today = startOfDay(new Date()).getTime();
  const tone = !next ? 'none'
    : startOfDay(next.date).getTime() < today ? 'overdue'
    : startOfDay(next.date).getTime() === today ? 'today'
    : 'upcoming';

  const history = numberedHistory(client.followups);
  const lastDone = history[history.length - 1];

  return (
    <div className="fu-cell">
      <div className={`fu-cell-next is-${tone}`}>
        <CalendarDays size={13} />
        <span>{next ? relativeDayLabel(next.date) : 'Not scheduled'}</span>
        {tone === 'overdue' && <span className="followup-overdue-tag">Overdue</span>}
      </div>
      <div className="fu-cell-sub">
        {lastDone
          ? `${history.length} done · last ${relativeDayLabel(lastDone.doneAt).toLowerCase()}`
          : 'No follow-ups yet'}
      </div>
      {onFollowedUp && (
        <button
          type="button"
          className="btn btn-sm btn-soft"
          onClick={() => onFollowedUp(client)}
          title={`Log your ${ordinal(history.length + 1)} follow-up and pick the next date`}
        >
          <CheckCircle2 size={13} />
          <span>Followed up</span>
        </button>
      )}
    </div>
  );
}
