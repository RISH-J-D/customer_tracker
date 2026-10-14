import React, { useState, useEffect } from 'react';
import {
  X,
  ChevronLeft,
  ChevronRight,
  CalendarDays,
  Calendar,
  Phone,
  Video,
  Mail,
  Users,
  MapPin,
  Link as LinkIcon
} from 'lucide-react';
import { formatTime } from './calendarUtils';

const WEEKDAYS = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
const MAX_CHIPS_PER_DAY = 2;

const getTypeIcon = (type, size = 11) => {
  switch (type) {
    case 'Call': return <Phone size={size} />;
    case 'Meetup': return <Video size={size} />;
    case 'Demo': return <Video size={size} />;
    case 'In-Person': return <Users size={size} />;
    case 'Email': return <Mail size={size} />;
    default: return <Calendar size={size} />;
  }
};

const sameDay = (a, b) =>
  a.getFullYear() === b.getFullYear() && a.getMonth() === b.getMonth() && a.getDate() === b.getDate();

// pending (future) / overdue / today / completed / other (rescheduled, cancelled…)
const followupState = (f, now) => {
  const d = new Date(f.scheduled_at);
  if (f.status === 'Completed') return 'completed';
  if (f.status !== 'Pending') return 'other';
  if (sameDay(d, now)) return 'today';
  return d < now ? 'overdue' : 'pending';
};

const STATE_LABEL = {
  pending: 'Upcoming',
  today: 'Today',
  overdue: 'Overdue',
  completed: 'Completed',
  other: null // falls back to the follow-up's own status
};

export default function LeadCalendarModal({ lead, onClose }) {
  const now = new Date();
  const [month, setMonth] = useState(() => new Date(now.getFullYear(), now.getMonth(), 1));
  const [selectedDay, setSelectedDay] = useState(null);

  useEffect(() => {
    const onKey = (e) => { if (e.key === 'Escape') onClose(); };
    document.addEventListener('keydown', onKey);
    return () => document.removeEventListener('keydown', onKey);
  }, [onClose]);

  if (!lead) return null;

  const followups = (lead.followups || [])
    .map(f => ({ ...f, date: new Date(f.scheduled_at) }))
    .filter(f => !isNaN(f.date.getTime()))
    .sort((a, b) => a.date - b.date);

  const monthFollowups = followups.filter(
    f => f.date.getFullYear() === month.getFullYear() && f.date.getMonth() === month.getMonth()
  );

  // Calendar grid: leading blanks for the first weekday, then each day of the month
  const daysInMonth = new Date(month.getFullYear(), month.getMonth() + 1, 0).getDate();
  const cells = [
    ...Array(month.getDay()).fill(null),
    ...Array.from({ length: daysInMonth }, (_, i) => new Date(month.getFullYear(), month.getMonth(), i + 1))
  ];
  while (cells.length % 7 !== 0) cells.push(null);

  const shiftMonth = (delta) => {
    setMonth(m => new Date(m.getFullYear(), m.getMonth() + delta, 1));
    setSelectedDay(null);
  };
  const goToToday = () => {
    setMonth(new Date(now.getFullYear(), now.getMonth(), 1));
    setSelectedDay(null);
  };

  const listed = selectedDay ? monthFollowups.filter(f => sameDay(f.date, selectedDay)) : monthFollowups;
  const monthLabel = month.toLocaleDateString([], { month: 'long', year: 'numeric' });
  const otherMonthsCount = followups.length - monthFollowups.length;

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-card lead-calendar-modal" onClick={(e) => e.stopPropagation()}>
        <div className="modal-header">
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem', minWidth: 0 }}>
            <div style={{
              width: '32px', height: '32px', borderRadius: 'var(--radius-md)', flexShrink: 0,
              backgroundColor: 'var(--lead-bg)', color: 'var(--lead-color)', border: '1px solid var(--lead-border)',
              display: 'flex', alignItems: 'center', justifyContent: 'center'
            }}>
              <CalendarDays size={16} />
            </div>
            <div style={{ minWidth: 0 }}>
              <h3 style={{ fontSize: '1.02rem', fontWeight: 700, color: 'var(--text-primary)' }}>
                {lead.company || lead.name}
              </h3>
              <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                {lead.company && lead.name !== `${lead.company} Contact` ? `${lead.name} • ` : ''}
                Follow-up calendar ({followups.length} total)
              </p>
            </div>
          </div>
          <button className="btn btn-secondary btn-icon" onClick={onClose} style={{ width: '28px', height: '28px', flexShrink: 0 }}>
            <X size={14} />
          </button>
        </div>

        <div className="modal-body" style={{ display: 'flex', flexDirection: 'column', gap: '0.85rem' }}>
          {/* Month navigation */}
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: '0.5rem' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
              <button className="btn btn-secondary btn-sm" onClick={() => shiftMonth(-1)} title="Previous month" style={{ padding: '0.3rem 0.45rem' }}>
                <ChevronLeft size={15} />
              </button>
              <button className="btn btn-secondary btn-sm" onClick={() => shiftMonth(1)} title="Next month" style={{ padding: '0.3rem 0.45rem' }}>
                <ChevronRight size={15} />
              </button>
              <h4 style={{ fontSize: '0.98rem', fontWeight: 700, color: 'var(--text-primary)', marginLeft: '0.35rem' }}>{monthLabel}</h4>
            </div>
            <button className="btn btn-secondary btn-sm" onClick={goToToday}>Today</button>
          </div>

          {/* Month grid */}
          <div className="lead-cal-grid">
            {WEEKDAYS.map(d => (
              <div key={d} className="lead-cal-weekday">{d}</div>
            ))}
            {cells.map((day, i) => {
              if (!day) return <div key={`blank-${i}`} className="lead-cal-cell is-blank" />;
              const dayItems = monthFollowups.filter(f => sameDay(f.date, day));
              const isSelected = selectedDay && sameDay(day, selectedDay);
              const classes = [
                'lead-cal-cell',
                sameDay(day, now) ? 'is-today' : '',
                isSelected ? 'is-selected' : '',
                dayItems.length ? 'has-items' : ''
              ].filter(Boolean).join(' ');
              return (
                <button
                  key={day.getDate()}
                  type="button"
                  className={classes}
                  onClick={() => setSelectedDay(isSelected ? null : day)}
                  title={dayItems.map(f => `${formatTime(f.date)} ${f.title}`).join('\n') || undefined}
                >
                  <span className="lead-cal-daynum">{day.getDate()}</span>
                  {dayItems.slice(0, MAX_CHIPS_PER_DAY).map(f => (
                    <span key={f.id} className={`lead-cal-chip state-${followupState(f, now)}`}>
                      <span className="lead-cal-chip-text">{formatTime(f.date)} {f.title}</span>
                    </span>
                  ))}
                  {dayItems.length > MAX_CHIPS_PER_DAY && (
                    <span className="lead-cal-more">+{dayItems.length - MAX_CHIPS_PER_DAY} more</span>
                  )}
                  {/* Compact dots replace chips on narrow screens */}
                  {dayItems.length > 0 && (
                    <span className="lead-cal-dots">
                      {dayItems.slice(0, 3).map(f => (
                        <span key={f.id} className={`lead-cal-dot state-${followupState(f, now)}`} />
                      ))}
                    </span>
                  )}
                </button>
              );
            })}
          </div>

          {/* Legend */}
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.75rem', fontSize: '0.7rem', color: 'var(--text-muted)' }}>
            {['pending', 'today', 'overdue', 'completed', 'other'].map(s => (
              <span key={s} style={{ display: 'inline-flex', alignItems: 'center', gap: '0.3rem' }}>
                <span className={`lead-cal-dot state-${s}`} />
                {STATE_LABEL[s] || 'Rescheduled / Cancelled'}
              </span>
            ))}
          </div>

          {/* Follow-up details for the month (or selected day) */}
          <div style={{ borderTop: '1px solid var(--border-light)', paddingTop: '0.75rem', display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: '0.5rem' }}>
              <span style={{ fontSize: '0.8rem', fontWeight: 700, color: 'var(--text-primary)' }}>
                {selectedDay
                  ? selectedDay.toLocaleDateString([], { weekday: 'long', month: 'long', day: 'numeric' })
                  : `All follow-ups in ${month.toLocaleDateString([], { month: 'long' })}`}
                <span style={{ color: 'var(--text-muted)', fontWeight: 500 }}> ({listed.length})</span>
              </span>
              {selectedDay && (
                <button type="button" className="btn btn-secondary btn-sm" onClick={() => setSelectedDay(null)} style={{ fontSize: '0.7rem' }}>
                  Show whole month
                </button>
              )}
            </div>

            {listed.length === 0 ? (
              <p style={{ fontSize: '0.78rem', color: 'var(--text-muted)', fontStyle: 'italic' }}>
                No follow-ups {selectedDay ? 'on this day' : 'this month'}.
                {!selectedDay && otherMonthsCount > 0 && ` ${otherMonthsCount} in other months — use the arrows to browse.`}
              </p>
            ) : (
              listed.map(f => {
                const state = followupState(f, now);
                return (
                  <div key={f.id} className={`lead-cal-detail state-${state}`}>
                    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: '0.5rem', flexWrap: 'wrap' }}>
                      <div style={{ display: 'flex', alignItems: 'center', gap: '0.4rem', minWidth: 0 }}>
                        <span style={{ display: 'flex', color: 'var(--primary)' }}>{getTypeIcon(f.type, 13)}</span>
                        <span style={{ fontWeight: 700, fontSize: '0.82rem', color: 'var(--text-primary)' }}>{f.title}</span>
                      </div>
                      <div style={{ display: 'flex', alignItems: 'center', gap: '0.3rem' }}>
                        {f.priority === 'High' && (
                          <span style={{ fontSize: '0.62rem', backgroundColor: 'var(--danger-btn)', color: '#fff', padding: '0.05rem 0.3rem', borderRadius: '3px', fontWeight: 600 }}>High</span>
                        )}
                        <span className={`lead-cal-status state-${state}`}>{STATE_LABEL[state] || f.status}</span>
                      </div>
                    </div>
                    <div style={{ fontSize: '0.74rem', color: 'var(--text-secondary)', marginTop: '0.2rem' }}>
                      {f.date.toLocaleDateString([], { weekday: 'short', month: 'short', day: 'numeric' })}, {formatTime(f.date)} • {f.type}
                    </div>
                    {(f.location || f.meeting_link) && (
                      <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.75rem', fontSize: '0.72rem', color: 'var(--text-muted)', marginTop: '0.2rem' }}>
                        {f.location && (
                          <span style={{ display: 'inline-flex', alignItems: 'center', gap: '0.25rem' }}><MapPin size={11} />{f.location}</span>
                        )}
                        {f.meeting_link && (
                          <a href={f.meeting_link} target="_blank" rel="noreferrer" style={{ display: 'inline-flex', alignItems: 'center', gap: '0.25rem', color: 'var(--primary)' }}>
                            <LinkIcon size={11} />Meeting link
                          </a>
                        )}
                      </div>
                    )}
                    {f.notes && (
                      <div style={{ fontSize: '0.75rem', color: 'var(--text-secondary)', marginTop: '0.35rem', whiteSpace: 'pre-wrap', wordBreak: 'break-word' }}>
                        {f.notes}
                      </div>
                    )}
                  </div>
                );
              })
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
