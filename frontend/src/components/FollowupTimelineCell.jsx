import React, { useState } from 'react';
import {
  Calendar,
  Plus,
  Phone,
  Video,
  Mail,
  Users,
  CheckCircle2,
  AlertCircle
} from 'lucide-react';
import {
  groupByDay,
  formatTime,
  linkButtonStyle,
  sectionLabelStyle
} from './calendarUtils';
import { CalendarDayGroup } from './CalendarDay';

const VISIBLE_DAYS = 2;

const getTypeIcon = (type) => {
  switch (type) {
    case 'Call': return <Phone size={10} />;
    case 'Meetup': return <Video size={10} />;
    case 'Demo': return <Video size={10} />;
    case 'In-Person': return <Users size={10} />;
    case 'Email': return <Mail size={10} />;
    default: return <Calendar size={10} />;
  }
};

const followupDate = (f) => {
  const d = new Date(f.scheduled_at);
  return isNaN(d.getTime()) ? null : d;
};

export default function FollowupTimelineCell({ client, onScheduleFollowup }) {
  const [showAllUpcoming, setShowAllUpcoming] = useState(false);
  const [showAllHistory, setShowAllHistory] = useState(false);

  const followups = client.followups || [];

  // Upcoming = still pending, soonest first. History = done/rescheduled etc., most recent first.
  const upcomingDays = groupByDay(
    followups
      .filter(f => f.status === 'Pending')
      .sort((a, b) => new Date(a.scheduled_at) - new Date(b.scheduled_at)),
    followupDate
  );
  const historyDays = groupByDay(
    followups
      .filter(f => f.status !== 'Pending' && f.status !== 'Cancelled')
      .sort((a, b) => new Date(b.scheduled_at) - new Date(a.scheduled_at)),
    followupDate
  );
  const upcomingCount = upcomingDays.reduce((n, g) => n + g.items.length, 0);
  const historyCount = historyDays.reduce((n, g) => n + g.items.length, 0);

  const todayStr = new Date().toDateString();
  const upcomingTone = (date) => {
    if (date.toDateString() === todayStr) return 'today';
    return date < new Date() ? 'overdue' : 'primary';
  };

  const renderUpcoming = (f, tone) => (
    <div
      key={f.id}
      style={{ display: 'flex', alignItems: 'center', gap: '0.3rem', fontSize: '0.71rem', color: 'var(--text-secondary)', minWidth: 0 }}
      title={`${f.title} • ${f.type} • ${new Date(f.scheduled_at).toLocaleString()}${f.notes ? `\n${f.notes}` : ''}`}
    >
      <span style={{ display: 'flex', flexShrink: 0, color: 'var(--primary)' }}>{getTypeIcon(f.type)}</span>
      <span style={{ fontWeight: 600, flexShrink: 0, color: 'var(--text-primary)' }}>{formatTime(new Date(f.scheduled_at))}</span>
      <span style={{ overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', minWidth: 0 }}>{f.title}</span>
      {tone === 'overdue' && (
        <span style={{ fontSize: '0.6rem', fontWeight: 700, color: 'var(--positive-color)', flexShrink: 0 }}>Overdue</span>
      )}
      {f.priority === 'High' && (
        <span style={{ fontSize: '0.6rem', backgroundColor: 'var(--danger-btn)', color: '#fff', padding: '0 3px', borderRadius: '3px', flexShrink: 0 }}>
          High
        </span>
      )}
    </div>
  );

  const renderHistory = (f) => (
    <div
      key={f.id}
      style={{ display: 'flex', alignItems: 'flex-start', gap: '0.3rem', fontSize: '0.7rem', color: 'var(--text-secondary)', minWidth: 0 }}
      title={`${f.title} • ${f.type} • ${new Date(f.scheduled_at).toLocaleString()} • ${f.status}${f.notes ? `\n${f.notes}` : ''}`}
    >
      <span style={{ display: 'flex', flexShrink: 0, marginTop: '2px', color: f.status === 'Completed' ? 'var(--lead-action)' : 'var(--text-muted)' }}>
        {f.status === 'Completed' ? <CheckCircle2 size={10} /> : <AlertCircle size={10} />}
      </span>
      <div style={{ minWidth: 0 }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.3rem' }}>
          <span style={{ fontWeight: 600, flexShrink: 0 }}>{formatTime(new Date(f.scheduled_at))}</span>
          <span style={{ overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', minWidth: 0 }}>{f.title}</span>
          {f.status !== 'Completed' && (
            <span style={{ fontSize: '0.6rem', color: 'var(--text-muted)', flexShrink: 0 }}>({f.status})</span>
          )}
        </div>
        {f.notes && (
          <div style={{ color: 'var(--text-muted)', fontStyle: 'italic', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
            "{f.notes}"
          </div>
        )}
      </div>
    </div>
  );

  const visibleUpcoming = showAllUpcoming ? upcomingDays : upcomingDays.slice(0, VISIBLE_DAYS);
  const visibleHistory = showAllHistory ? historyDays : historyDays.slice(0, VISIBLE_DAYS);

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem', minWidth: '160px' }}>
      {/* Upcoming */}
      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.35rem' }}>
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: '0.35rem' }}>
          <span style={sectionLabelStyle}>Upcoming{upcomingCount > 0 ? ` (${upcomingCount})` : ''}</span>
          {onScheduleFollowup && (
            <button type="button" onClick={() => onScheduleFollowup(client.id)} style={linkButtonStyle} title="Schedule a follow-up">
              <Plus size={11} />
              <span>Schedule</span>
            </button>
          )}
        </div>
        {upcomingDays.length === 0 ? (
          <span style={{ fontSize: '0.7rem', color: 'var(--text-muted)', fontStyle: 'italic' }}>Nothing scheduled</span>
        ) : (
          visibleUpcoming.map(g => {
            const tone = upcomingTone(g.date);
            return (
              <CalendarDayGroup key={g.key} date={g.date} tone={tone}>
                {g.items.map(f => renderUpcoming(f, tone))}
              </CalendarDayGroup>
            );
          })
        )}
        {upcomingDays.length > VISIBLE_DAYS && (
          <button type="button" style={linkButtonStyle} onClick={() => setShowAllUpcoming(v => !v)}>
            {showAllUpcoming ? 'Show less' : `+${upcomingDays.length - VISIBLE_DAYS} more days`}
          </button>
        )}
      </div>

      {/* History */}
      {historyDays.length > 0 && (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.35rem', borderTop: '1px dashed var(--border-light)', paddingTop: '0.4rem' }}>
          <span style={sectionLabelStyle}>History ({historyCount})</span>
          {visibleHistory.map(g => (
            <CalendarDayGroup key={g.key} date={g.date}>
              {g.items.map(renderHistory)}
            </CalendarDayGroup>
          ))}
          {historyDays.length > VISIBLE_DAYS && (
            <button type="button" style={linkButtonStyle} onClick={() => setShowAllHistory(v => !v)}>
              {showAllHistory ? 'Show less' : `+${historyDays.length - VISIBLE_DAYS} more days`}
            </button>
          )}
        </div>
      )}
    </div>
  );
}
