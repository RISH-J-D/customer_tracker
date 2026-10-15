import React from 'react';
import { CheckCircle2 } from 'lucide-react';
import { parseServerUtc, relativeDayLabel, sectionLabelStyle, lastConversation } from './calendarUtils';
import { CalendarTile } from './CalendarDay';

const startOfDay = (d) => new Date(d.getFullYear(), d.getMonth(), d.getDate());

// Next pending follow-up, the last conversation's notes, and a "Followed up" button
export default function NextFollowUpCell({ client, onFollowedUp }) {
  const next = (client.followups || [])
    .filter(f => f.status === 'Pending')
    .map(f => ({ ...f, date: parseServerUtc(f.scheduled_at) }))
    .filter(f => f.date)
    .sort((a, b) => a.date - b.date)[0];

  const today = startOfDay(new Date());
  const tone = !next ? null
    : startOfDay(next.date) < today ? 'overdue'
    : startOfDay(next.date).getTime() === today.getTime() ? 'today'
    : 'primary';

  const last = lastConversation(client);

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.45rem', minWidth: '170px' }}>
      <div>
        <div style={sectionLabelStyle}>Next follow-up</div>
        {next ? (
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.45rem', marginTop: '0.25rem' }}>
            <CalendarTile date={next.date} tone={tone} />
            <div style={{ fontSize: '0.78rem', fontWeight: 600, color: tone === 'primary' ? 'var(--text-primary)' : tone === 'today' ? 'var(--danger-btn)' : 'var(--warning-strong)' }}>
              {relativeDayLabel(next.date)}
              {tone === 'overdue' && <span className="followup-overdue-tag">Overdue</span>}
            </div>
          </div>
        ) : (
          <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', fontStyle: 'italic', marginTop: '0.15rem' }}>Not scheduled</div>
        )}
      </div>

      {last && (
        <div className="followup-last-talk">
          <div style={sectionLabelStyle}>Last talked — {relativeDayLabel(last.date)}</div>
          {last.items.map(n => (
            <div key={n.id} className="followup-last-talk-text" title={n.content}>{n.content}</div>
          ))}
        </div>
      )}

      {onFollowedUp && (
        <button
          type="button"
          className="btn btn-primary btn-sm"
          style={{ alignSelf: 'flex-start' }}
          onClick={() => onFollowedUp(client)}
          title="Log today's conversation and pick the next follow-up date"
        >
          <CheckCircle2 size={13} />
          <span>Followed up</span>
        </button>
      )}
    </div>
  );
}
