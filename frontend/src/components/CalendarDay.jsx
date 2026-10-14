import React from 'react';

import { relativeDayLabel } from './calendarUtils';

// Small calendar-page tile (month on top, day number below) used as a date separator.
export function CalendarTile({ date, tone = 'default' }) {
  const tones = {
    default: { head: 'var(--text-muted)', border: 'var(--border-subtle)' },
    primary: { head: 'var(--primary)', border: 'var(--primary-border)' },
    today: { head: 'var(--danger-btn)', border: 'var(--danger-border)' },
    overdue: { head: 'var(--warning-strong)', border: 'var(--positive-border)' }
  };
  const t = tones[tone] || tones.default;
  return (
    <div style={{
      width: '30px',
      flexShrink: 0,
      borderRadius: '5px',
      border: `1px solid ${t.border}`,
      backgroundColor: 'var(--bg-surface)',
      overflow: 'hidden',
      textAlign: 'center',
      lineHeight: 1
    }}>
      <div style={{ backgroundColor: t.head, color: '#fff', fontSize: '0.52rem', fontWeight: 700, padding: '2px 0', textTransform: 'uppercase' }}>
        {date.toLocaleDateString([], { month: 'short' })}
      </div>
      <div style={{ fontSize: '0.8rem', fontWeight: 800, color: 'var(--text-primary)', padding: '3px 0 2px' }}>
        {date.getDate()}
      </div>
    </div>
  );
}

// A calendar tile beside a day label and that day's entries.
export function CalendarDayGroup({ date, tone, children }) {
  return (
    <div style={{ display: 'flex', alignItems: 'flex-start', gap: '0.45rem' }}>
      <CalendarTile date={date} tone={tone} />
      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.2rem', minWidth: 0, flex: 1 }}>
        <span style={{ fontSize: '0.64rem', fontWeight: 700, color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '0.03em' }}>
          {relativeDayLabel(date)}
        </span>
        {children}
      </div>
    </div>
  );
}
