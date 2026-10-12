import React from 'react';
import { X, CalendarCheck, Clock, Video, CheckCircle2, Sparkles, ExternalLink, ArrowRight } from 'lucide-react';
import confetti from 'canvas-confetti';

export default function TodayReminderModal({
  isOpen,
  onClose,
  todayFollowups,
  onOpenCompleteModal,
  onPromoteClientToLead,
  onSelectClient
}) {
  if (!isOpen) return null;

  const pendingItems = todayFollowups.filter(f => f.status === 'Pending');
  const completedItems = todayFollowups.filter(f => f.status === 'Completed');

  const triggerLeadCelebration = (clientId) => {
    confetti({
      particleCount: 80,
      spread: 70,
      origin: { y: 0.6 }
    });
    onPromoteClientToLead(clientId);
  };

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div 
        className="modal-card" 
        style={{ maxWidth: '640px' }} 
        onClick={(e) => e.stopPropagation()}
      >
        <div className="modal-header">
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
            <div style={{
              width: '32px',
              height: '32px',
              borderRadius: 'var(--radius-md)',
              backgroundColor: '#EFF6FF',
              color: 'var(--primary)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center'
            }}>
              <CalendarCheck size={16} />
            </div>
            <div>
              <h3 style={{ fontSize: '1.05rem', fontWeight: 700, color: 'var(--text-primary)' }}>Today's Agenda</h3>
              <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                {pendingItems.length} interactions requiring follow-up today
              </p>
            </div>
          </div>
          <button className="btn btn-secondary btn-icon" onClick={onClose} style={{ width: '28px', height: '28px' }}>
            <X size={14} />
          </button>
        </div>

        <div className="modal-body" style={{ maxHeight: '500px', overflowY: 'auto' }}>
          {todayFollowups.length === 0 ? (
            <div style={{ textAlign: 'center', padding: '2.5rem 1rem', color: 'var(--text-muted)' }}>
              <CalendarCheck size={36} style={{ margin: '0 auto 0.75rem auto', opacity: 0.3 }} />
              <h4 style={{ color: 'var(--text-primary)', marginBottom: '0.2rem', fontSize: '0.9rem' }}>No Follow-ups Due Today</h4>
              <p style={{ fontSize: '0.785rem' }}>All client follow-ups for today are up to date.</p>
            </div>
          ) : (
            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
              {pendingItems.map((f) => {
                const timeStr = new Date(f.scheduled_at).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
                return (
                  <div
                    key={f.id}
                    className="card"
                    style={{
                      padding: '0.95rem',
                      border: '1px solid var(--border-subtle)',
                      boxShadow: 'var(--shadow-xs)'
                    }}
                  >
                    <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', marginBottom: '0.4rem' }}>
                      <div>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '0.4rem', marginBottom: '0.2rem' }}>
                          <span className={`badge-status badge-${f.priority.toLowerCase()}`}>
                            {f.priority}
                          </span>
                          <span style={{ fontSize: '0.72rem', fontWeight: 600, color: 'var(--primary)' }}>
                            {f.type}
                          </span>
                          <span style={{ display: 'flex', alignItems: 'center', gap: '0.2rem', fontSize: '0.72rem', color: 'var(--text-muted)' }}>
                            <Clock size={11} />
                            {timeStr}
                          </span>
                        </div>
                        <h4 style={{ fontSize: '0.925rem', fontWeight: 600, color: 'var(--text-primary)' }}>
                          {f.title}
                        </h4>
                      </div>

                      {/* Convert to Lead Button */}
                      {!f.client_is_lead ? (
                        <button
                          className="btn btn-lead btn-sm"
                          onClick={() => triggerLeadCelebration(f.client_id)}
                          title="Convert to Lead"
                          style={{ fontSize: '0.7rem', padding: '0.2rem 0.5rem' }}
                        >
                          <Sparkles size={11} />
                          <span>Convert to Lead</span>
                        </button>
                      ) : (
                        <span className="badge-status badge-lead" style={{ fontSize: '0.68rem' }}>
                          <Sparkles size={10} />
                          <span>Active Lead</span>
                        </span>
                      )}
                    </div>

                    {/* Client info bar */}
                    <div style={{
                      backgroundColor: 'var(--bg-subtle)',
                      borderRadius: 'var(--radius-sm)',
                      padding: '0.45rem 0.65rem',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'space-between',
                      marginBottom: '0.6rem'
                    }}>
                      <div style={{ fontSize: '0.785rem' }}>
                        <span style={{ color: 'var(--text-muted)' }}>Client: </span>
                        <strong style={{ color: 'var(--text-primary)' }}>{f.client_name}</strong>
                        {f.client_company && (
                          <span style={{ color: 'var(--text-muted)' }}> • {f.client_company}</span>
                        )}
                      </div>
                      <button
                        className="btn btn-secondary btn-sm"
                        onClick={() => {
                          onClose();
                          onSelectClient(f.client_id);
                        }}
                        style={{ fontSize: '0.68rem', padding: '0.15rem 0.4rem' }}
                      >
                        View Client <ArrowRight size={10} />
                      </button>
                    </div>

                    {f.notes && (
                      <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', marginBottom: '0.6rem', lineHeight: '1.3' }}>
                        {f.notes}
                      </p>
                    )}

                    {/* Action buttons */}
                    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '0.4rem' }}>
                      <div>
                        {f.meeting_link && (
                          <a
                            href={f.meeting_link}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="btn btn-secondary btn-sm"
                            style={{ fontSize: '0.725rem', color: '#0284C7', padding: '0.2rem 0.5rem' }}
                          >
                            <Video size={12} />
                            <span>Join Meeting</span>
                          </a>
                        )}
                        {f.location && !f.meeting_link && (
                          <span style={{ fontSize: '0.72rem', color: 'var(--text-muted)' }}>
                            📍 {f.location}
                          </span>
                        )}
                      </div>

                      <button
                        className="btn btn-primary btn-sm"
                        onClick={() => onOpenCompleteModal(f)}
                        style={{ fontSize: '0.725rem', padding: '0.25rem 0.55rem' }}
                      >
                        <CheckCircle2 size={12} />
                        <span>Log Outcome / Complete</span>
                      </button>
                    </div>
                  </div>
                );
              })}

              {/* Completed Today section */}
              {completedItems.length > 0 && (
                <div style={{ marginTop: '0.75rem', borderTop: '1px solid var(--border-light)', paddingTop: '0.75rem' }}>
                  <div style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--text-muted)', marginBottom: '0.5rem' }}>
                    Completed Today ({completedItems.length})
                  </div>
                  <div style={{ display: 'flex', flexDirection: 'column', gap: '0.4rem' }}>
                    {completedItems.map((cf) => (
                      <div
                        key={cf.id}
                        style={{
                          backgroundColor: 'var(--bg-subtle)',
                          border: '1px solid var(--border-light)',
                          borderRadius: 'var(--radius-sm)',
                          padding: '0.5rem 0.75rem',
                          display: 'flex',
                          alignItems: 'center',
                          justifyContent: 'space-between'
                        }}
                      >
                        <div style={{ display: 'flex', alignItems: 'center', gap: '0.4rem' }}>
                          <CheckCircle2 size={14} color="#059669" />
                          <span style={{ fontSize: '0.785rem', textDecoration: 'line-through', color: 'var(--text-muted)' }}>
                            {cf.title} ({cf.client_name})
                          </span>
                        </div>
                        {cf.is_positive_result && (
                          <span className="badge-status badge-positive" style={{ fontSize: '0.65rem' }}>
                            Positive Outcome
                          </span>
                        )}
                      </div>
                    ))}
                  </div>
                </div>
              )}
            </div>
          )}
        </div>

        <div className="modal-footer">
          <button className="btn btn-secondary" onClick={onClose}>
            Close
          </button>
        </div>
      </div>
    </div>
  );
}
