import React, { useState } from 'react';
import { 
  Calendar, 
  Clock, 
  Filter,
  MapPin,
  Link as LinkIcon
} from 'lucide-react';
import ExportDropdown from '../components/ExportDropdown';

// Read-only status label shown on each follow-up
const getStatusLabel = (f, isToday, isPast) => {
  if (f.status === 'Pending') {
    if (isToday) return { text: 'Due Today', color: 'var(--danger-color)', bg: 'var(--danger-bg)' };
    if (isPast) return { text: 'Overdue', color: 'var(--positive-color)', bg: 'var(--positive-bg)' };
    return { text: 'Upcoming', color: 'var(--primary)', bg: 'var(--primary-subtle)' };
  }
  if (f.status === 'Completed') return { text: 'Completed', color: 'var(--lead-color)', bg: 'var(--lead-bg)' };
  return { text: f.status, color: 'var(--text-muted)', bg: 'var(--bg-hover)' };
};

export default function FollowUpsPage({
  followups,
  onOpenExportModal
}) {
  const [filterType, setFilterType] = useState('all');
  const [filterStatus, setFilterStatus] = useState('all'); // all, Pending, Completed
  const [filterPriority, setFilterPriority] = useState('all');

  const filtered = followups.filter(f => {
    if (filterType !== 'all' && f.type !== filterType) return false;
    if (filterStatus !== 'all' && f.status !== filterStatus) return false;
    if (filterPriority !== 'all' && f.priority !== filterPriority) return false;
    return true;
  });

  return (
    <div>
      <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'flex-end', flexWrap: 'wrap', gap: '1rem', marginBottom: '1.25rem' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
          <ExportDropdown onOpenModal={onOpenExportModal} />
        </div>
      </div>

      {/* Filter controls */}
      <div className="card" style={{ padding: '0.65rem 0.85rem', marginBottom: '1.25rem' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem', flexWrap: 'wrap' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.4rem', color: 'var(--text-muted)' }}>
            <Filter size={13} />
            <span style={{ fontSize: '0.75rem', fontWeight: 600 }}>Filter:</span>
          </div>

          <select
            className="form-select"
            style={{ width: 'auto', height: '32px', padding: '0.2rem 0.6rem', fontSize: '0.785rem' }}
            value={filterStatus}
            onChange={(e) => setFilterStatus(e.target.value)}
          >
            <option value="all">All Statuses</option>
            <option value="Pending">Pending Only</option>
            <option value="Completed">Completed Only</option>
          </select>

          <select
            className="form-select"
            style={{ width: 'auto', height: '32px', padding: '0.2rem 0.6rem', fontSize: '0.785rem' }}
            value={filterType}
            onChange={(e) => setFilterType(e.target.value)}
          >
            <option value="all">All Interaction Types</option>
            <option value="Meetup">Meetup (Online Video)</option>
            <option value="In-Person">In-Person Meeting</option>
            <option value="Demo">Product Demo</option>
            <option value="Call">Phone Call</option>
            <option value="Email">Email</option>
          </select>

          <select
            className="form-select"
            style={{ width: 'auto', height: '32px', padding: '0.2rem 0.6rem', fontSize: '0.785rem' }}
            value={filterPriority}
            onChange={(e) => setFilterPriority(e.target.value)}
          >
            <option value="all">All Priorities</option>
            <option value="High">High Priority</option>
            <option value="Medium">Medium Priority</option>
            <option value="Low">Low Priority</option>
          </select>

          <span style={{ marginLeft: 'auto', fontSize: '0.75rem', color: 'var(--text-muted)' }}>
            Showing {filtered.length} records
          </span>
        </div>
      </div>

      {/* Followups List */}
      {filtered.length === 0 ? (
        <div className="card" style={{ textAlign: 'center', padding: '3rem 1rem', color: 'var(--text-muted)' }}>
          <Calendar size={36} style={{ margin: '0 auto 0.75rem auto', opacity: 0.3 }} />
          <h3 style={{ fontSize: '0.95rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '0.25rem' }}>No Follow-ups Found</h3>
          <p style={{ fontSize: '0.8rem' }}>No items match your filter selection.</p>
        </div>
      ) : (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.65rem' }}>
          {filtered.map((f) => {
            const isPending = f.status === 'Pending';
            const dateObj = new Date(f.scheduled_at);
            const dateStr = dateObj.toLocaleDateString([], { weekday: 'short', month: 'short', day: 'numeric', year: 'numeric' });
            const timeStr = dateObj.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
            const isToday = new Date().toDateString() === dateObj.toDateString();
            const status = getStatusLabel(f, isToday, dateObj < new Date());

            return (
              <div
                key={f.id}
                className="card"
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'space-between',
                  gap: '1rem',
                  flexWrap: 'wrap',
                  padding: '0.85rem 1.15rem',
                  backgroundColor: isPending ? 'var(--bg-surface)' : 'var(--bg-subtle)',
                  borderColor: isToday && isPending ? 'var(--danger-border)' : 'var(--border-subtle)',
                  opacity: isPending ? 1 : 0.7
                }}
              >
                {/* Info */}
                <div style={{ flex: 1, minWidth: '260px' }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.4rem', marginBottom: '0.2rem', flexWrap: 'wrap' }}>
                    {isToday && (
                      <span style={{
                        backgroundColor: 'var(--danger-btn)',
                        color: 'white',
                        fontSize: '0.65rem',
                        fontWeight: 700,
                        padding: '0.05rem 0.35rem',
                        borderRadius: '999px',
                        textTransform: 'uppercase'
                      }}>
                        Today
                      </span>
                    )}
                    <span className={`badge-status badge-${f.priority.toLowerCase()}`}>
                      {f.priority}
                    </span>
                    <span style={{
                      fontSize: '0.72rem',
                      fontWeight: 600,
                      color: 'var(--primary)'
                    }}>
                      {f.type}
                    </span>
                    <span style={{ fontSize: '0.75rem', color: 'var(--text-muted)', display: 'flex', alignItems: 'center', gap: '0.25rem' }}>
                      <Clock size={11} />
                      {dateStr} at {timeStr}
                    </span>
                  </div>

                  <div style={{ fontSize: '0.9rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '0.15rem' }}>
                    {f.title}
                  </div>

                  <div style={{ fontSize: '0.785rem', color: 'var(--text-muted)' }}>
                    Client: <strong style={{ color: 'var(--text-primary)' }}>{f.client_name}</strong>
                    {f.client_company ? ` (${f.client_company})` : ''}
                  </div>

                  {(f.location || f.meeting_link) && (
                    <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.85rem', fontSize: '0.74rem', color: 'var(--text-muted)', marginTop: '0.25rem' }}>
                      {f.location && (
                        <span style={{ display: 'inline-flex', alignItems: 'center', gap: '0.25rem' }}>
                          <MapPin size={11} />
                          {f.location}
                        </span>
                      )}
                      {f.meeting_link && (
                        <span style={{ display: 'inline-flex', alignItems: 'center', gap: '0.25rem', minWidth: 0, wordBreak: 'break-all' }}>
                          <LinkIcon size={11} style={{ flexShrink: 0 }} />
                          {f.meeting_link}
                        </span>
                      )}
                    </div>
                  )}

                  {f.notes && (
                    <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', marginTop: '0.25rem', lineHeight: '1.3' }}>
                      {f.notes}
                    </p>
                  )}
                </div>

                {/* Status (read-only) */}
                <span style={{
                  fontSize: '0.72rem',
                  fontWeight: 700,
                  padding: '0.2rem 0.6rem',
                  borderRadius: '999px',
                  color: status.color,
                  backgroundColor: status.bg,
                  whiteSpace: 'nowrap'
                }}>
                  {status.text}
                </span>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}
