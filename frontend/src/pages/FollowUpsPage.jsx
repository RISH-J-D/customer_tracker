import React, { useState } from 'react';
import { 
  Calendar, 
  CalendarPlus, 
  Clock, 
  Video, 
  CheckCircle2, 
  Sparkles, 
  Trash2, 
  Filter,
  Check
} from 'lucide-react';
import confetti from 'canvas-confetti';
import ExportDropdown from '../components/ExportDropdown';

export default function FollowUpsPage({
  followups,
  onOpenNewFollowup,
  onOpenCompleteModal,
  onDeleteFollowup,
  onPromoteClientToLead,
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

  const triggerLeadPromotion = (clientId) => {
    confetti({
      particleCount: 80,
      spread: 70,
      origin: { y: 0.6 }
    });
    onPromoteClientToLead(clientId);
  };

  return (
    <div>
      <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', flexWrap: 'wrap', gap: '1rem', marginBottom: '1.25rem' }}>
        <div>
          <h2 style={{ fontSize: '1.25rem', fontWeight: 700, color: 'var(--text-primary)', letterSpacing: '-0.02em' }}>
            Meetups & Follow-up Logs
          </h2>
          <p style={{ fontSize: '0.815rem', color: 'var(--text-muted)', marginTop: '0.15rem' }}>
            Schedule and manage client meetups, demo sessions, check-in calls, and log outcomes.
          </p>
        </div>

        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
          <ExportDropdown onOpenModal={onOpenExportModal} />
          <button className="btn btn-primary" onClick={onOpenNewFollowup}>
            <CalendarPlus size={14} />
            <span>Schedule Interaction</span>
          </button>
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
                  borderColor: isToday && isPending ? '#FECACA' : 'var(--border-subtle)',
                  opacity: isPending ? 1 : 0.7
                }}
              >
                {/* Info */}
                <div style={{ flex: 1, minWidth: '260px' }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.4rem', marginBottom: '0.2rem', flexWrap: 'wrap' }}>
                    {isToday && (
                      <span style={{
                        backgroundColor: '#DC2626',
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

                  {f.notes && (
                    <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', marginTop: '0.25rem', lineHeight: '1.3' }}>
                      {f.notes}
                    </p>
                  )}
                </div>

                {/* Actions */}
                <div style={{ display: 'flex', alignItems: 'center', gap: '0.4rem', flexWrap: 'wrap' }}>
                  {f.meeting_link && (
                    <a
                      href={f.meeting_link}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="btn btn-secondary btn-sm"
                      style={{ color: '#0284C7', padding: '0.25rem 0.5rem', fontSize: '0.725rem' }}
                    >
                      <Video size={12} />
                      <span>Join Call</span>
                    </a>
                  )}

                  {!f.client_is_lead && (
                    <button
                      className="btn btn-lead btn-sm"
                      onClick={() => triggerLeadPromotion(f.client_id)}
                      title="Promote client to Lead"
                      style={{ padding: '0.25rem 0.5rem', fontSize: '0.725rem' }}
                    >
                      <Sparkles size={11} />
                      <span>Convert to Lead</span>
                    </button>
                  )}

                  {isPending ? (
                    <button
                      className="btn btn-primary btn-sm"
                      onClick={() => onOpenCompleteModal(f)}
                      style={{ padding: '0.25rem 0.55rem', fontSize: '0.725rem' }}
                    >
                      <CheckCircle2 size={12} />
                      <span>Complete</span>
                    </button>
                  ) : (
                    <div style={{ display: 'flex', alignItems: 'center', gap: '0.3rem', color: 'var(--lead-color)', fontSize: '0.75rem', fontWeight: 600 }}>
                      <Check size={14} />
                      <span>Completed</span>
                    </div>
                  )}

                  <button
                    className="btn btn-danger btn-sm"
                    onClick={() => onDeleteFollowup(f.id)}
                    title="Delete record"
                    style={{ padding: '0.25rem 0.45rem' }}
                  >
                    <Trash2 size={12} />
                  </button>
                </div>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}
