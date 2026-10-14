import React from 'react';
import { X, Bell, CheckCheck, Target, Clock, Calendar } from 'lucide-react';

export default function NotificationCenterModal({
  isOpen,
  onClose,
  notifications,
  onMarkRead,
  onMarkAllRead,
  onRequestPermission
}) {
  if (!isOpen) return null;

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div 
        className="modal-card" 
        style={{ maxWidth: '460px' }} 
        onClick={(e) => e.stopPropagation()}
      >
        <div className="modal-header">
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
            <div style={{
              width: '32px',
              height: '32px',
              borderRadius: 'var(--radius-md)',
              backgroundColor: 'var(--primary-subtle)',
              color: 'var(--primary)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center'
            }}>
              <Bell size={16} />
            </div>
            <h3 style={{ fontSize: '1.05rem', fontWeight: 700, color: 'var(--text-primary)' }}>Notifications & Alerts</h3>
          </div>
          <button className="btn btn-secondary btn-icon" onClick={onClose} style={{ width: '28px', height: '28px' }}>
            <X size={14} />
          </button>
        </div>

        <div style={{ padding: '0.65rem 1.15rem', backgroundColor: 'var(--bg-subtle)', borderBottom: '1px solid var(--border-subtle)', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <span style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
            {notifications.filter(n => !n.is_read).length} unread
          </span>
          <div style={{ display: 'flex', gap: '0.4rem' }}>
            <button 
              className="btn btn-secondary btn-sm" 
              onClick={onRequestPermission}
              style={{ fontSize: '0.7rem', padding: '0.2rem 0.45rem' }}
            >
              Desktop Alerts
            </button>
            <button 
              className="btn btn-secondary btn-sm" 
              onClick={onMarkAllRead}
              style={{ fontSize: '0.7rem', padding: '0.2rem 0.45rem' }}
            >
              <CheckCheck size={12} />
              <span>Mark all read</span>
            </button>
          </div>
        </div>

        <div className="modal-body" style={{ maxHeight: '400px', overflowY: 'auto', padding: '0.65rem' }}>
          {notifications.length === 0 ? (
            <div style={{ textAlign: 'center', padding: '2rem 1rem', color: 'var(--text-muted)' }}>
              <Bell size={28} style={{ margin: '0 auto 0.5rem auto', opacity: 0.3 }} />
              <p style={{ fontSize: '0.8rem' }}>No notifications yet</p>
            </div>
          ) : (
            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.4rem' }}>
              {notifications.map((n) => {
                const isLead = n.type === 'lead_promoted';
                const isToday = n.type === 'today_followup';
                return (
                  <div
                    key={n.id}
                    onClick={() => !n.is_read && onMarkRead(n.id)}
                    style={{
                      backgroundColor: n.is_read ? 'var(--bg-surface)' : 'var(--bg-subtle)',
                      border: `1px solid ${n.is_read ? 'var(--border-light)' : 'var(--border-subtle)'}`,
                      borderRadius: 'var(--radius-md)',
                      padding: '0.75rem 0.85rem',
                      display: 'flex',
                      gap: '0.65rem',
                      cursor: n.is_read ? 'default' : 'pointer',
                      transition: 'all 0.15s ease',
                      position: 'relative'
                    }}
                  >
                    {!n.is_read && (
                      <span style={{
                        position: 'absolute',
                        top: '10px',
                        right: '10px',
                        width: '6px',
                        height: '6px',
                        borderRadius: '50%',
                        backgroundColor: isLead ? 'var(--lead-color)' : 'var(--primary)'
                      }} />
                    )}

                    <div style={{
                      width: '28px',
                      height: '28px',
                      borderRadius: 'var(--radius-sm)',
                      backgroundColor: isLead ? 'var(--lead-bg)' : isToday ? 'var(--danger-bg)' : 'var(--primary-subtle)',
                      color: isLead ? 'var(--lead-color)' : isToday ? 'var(--danger-color)' : 'var(--primary)',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      flexShrink: 0
                    }}>
                      {isLead ? <Target size={14} /> : isToday ? <Clock size={14} /> : <Calendar size={14} />}
                    </div>

                    <div style={{ flex: 1, minWidth: 0 }}>
                      <div style={{ fontSize: '0.815rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '0.15rem' }}>
                        {n.title}
                      </div>
                      <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', lineHeight: '1.3', marginBottom: '0.25rem' }}>
                        {n.message}
                      </p>
                      <span style={{ fontSize: '0.68rem', color: 'var(--text-muted)' }}>
                        {n.created_at ? new Date(n.created_at).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) : 'Recently'}
                      </span>
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </div>

        <div className="modal-footer" style={{ justifyContent: 'center' }}>
          <button className="btn btn-secondary btn-sm" onClick={onClose} style={{ width: '100%' }}>
            Close
          </button>
        </div>
      </div>
    </div>
  );
}
