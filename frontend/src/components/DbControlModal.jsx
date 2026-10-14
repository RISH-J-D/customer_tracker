import React from 'react';
import { X, Database, CheckCircle2, Server, Terminal, ExternalLink, ShieldCheck, Copy } from 'lucide-react';

export default function DbControlModal({ isOpen, onClose, dbInfo }) {
  if (!isOpen) return null;

  const isPostgres = dbInfo?.is_postgres || dbInfo?.engine === 'postgresql';

  const copyToClipboard = (text) => {
    navigator.clipboard?.writeText(text);
    alert('Copied to clipboard: ' + text);
  };

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div 
        className="modal-card" 
        style={{ maxWidth: '580px' }} 
        onClick={(e) => e.stopPropagation()}
      >
        <div className="modal-header">
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
            <div style={{
              width: '34px',
              height: '34px',
              borderRadius: 'var(--radius-md)',
              backgroundColor: isPostgres ? 'var(--lead-bg)' : 'var(--primary-subtle)',
              color: isPostgres ? 'var(--lead-color)' : 'var(--primary)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center'
            }}>
              <Database size={18} />
            </div>
            <div>
              <h3 style={{ fontSize: '1.05rem', fontWeight: 700, color: 'var(--text-primary)' }}>
                Database Controls & pgAdmin Setup
              </h3>
              <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                Connect PostgreSQL with pgAdmin 4 to inspect tables, clients, and follow-ups
              </p>
            </div>
          </div>
          <button className="btn btn-secondary btn-icon" onClick={onClose} style={{ width: '28px', height: '28px' }}>
            <X size={14} />
          </button>
        </div>

        <div className="modal-body" style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
          {/* Status Card */}
          <div style={{
            padding: '1rem',
            borderRadius: 'var(--radius-md)',
            backgroundColor: isPostgres ? 'var(--lead-bg)' : 'var(--bg-subtle)',
            border: `1px solid ${isPostgres ? 'var(--lead-border)' : 'var(--border-subtle)'}`,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            gap: '1rem'
          }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
              <div style={{
                width: '10px',
                height: '10px',
                borderRadius: '50%',
                backgroundColor: isPostgres ? 'var(--lead-action)' : 'var(--warning-strong)'
              }}></div>
              <div>
                <div style={{ fontWeight: 600, fontSize: '0.85rem', color: 'var(--text-primary)' }}>
                  Active Engine: {isPostgres ? 'PostgreSQL (Connected)' : 'SQLite (Local Database)'}
                </div>
                <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', fontFamily: 'var(--font-mono)', marginTop: '0.1rem' }}>
                  {dbInfo?.url_masked || 'sqlite:///backend/app/tracker.db'}
                </div>
              </div>
            </div>
            <span style={{
              fontSize: '0.7rem',
              fontWeight: 600,
              padding: '0.2rem 0.5rem',
              borderRadius: 'var(--radius-full)',
              backgroundColor: isPostgres ? 'var(--lead-action)' : 'var(--border-subtle)',
              color: isPostgres ? 'var(--bg-surface)' : 'var(--text-secondary)'
            }}>
              {isPostgres ? 'Postgres Active' : 'Ready to Switch'}
            </span>
          </div>

          {/* Quick pgAdmin Connection Parameters */}
          <div className="card" style={{ padding: '1rem' }}>
            <h4 style={{ fontSize: '0.825rem', fontWeight: 700, color: 'var(--text-primary)', marginBottom: '0.65rem' }}>
              pgAdmin 4 Connection Parameters
            </h4>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(2, 1fr)', gap: '0.65rem', fontSize: '0.785rem' }}>
              <div style={{ padding: '0.45rem 0.65rem', backgroundColor: 'var(--bg-subtle)', borderRadius: 'var(--radius-sm)', border: '1px solid var(--border-light)' }}>
                <span style={{ color: 'var(--text-muted)', fontSize: '0.7rem', display: 'block' }}>Host / Server</span>
                <strong style={{ fontFamily: 'var(--font-mono)' }}>localhost</strong> (or 127.0.0.1)
              </div>
              <div style={{ padding: '0.45rem 0.65rem', backgroundColor: 'var(--bg-subtle)', borderRadius: 'var(--radius-sm)', border: '1px solid var(--border-light)' }}>
                <span style={{ color: 'var(--text-muted)', fontSize: '0.7rem', display: 'block' }}>Port</span>
                <strong style={{ fontFamily: 'var(--font-mono)' }}>5433</strong> (PostgreSQL 18)
              </div>

              <div style={{ padding: '0.45rem 0.65rem', backgroundColor: 'var(--bg-subtle)', borderRadius: 'var(--radius-sm)', border: '1px solid var(--border-light)' }}>
                <span style={{ color: 'var(--text-muted)', fontSize: '0.7rem', display: 'block' }}>Database Name</span>
                <strong style={{ fontFamily: 'var(--font-mono)' }}>tracker_db</strong>
              </div>
              <div style={{ padding: '0.45rem 0.65rem', backgroundColor: 'var(--bg-subtle)', borderRadius: 'var(--radius-sm)', border: '1px solid var(--border-light)' }}>
                <span style={{ color: 'var(--text-muted)', fontSize: '0.7rem', display: 'block' }}>Username</span>
                <strong style={{ fontFamily: 'var(--font-mono)' }}>postgres</strong>
              </div>
            </div>
          </div>

          {/* How to activate PostgreSQL in backend */}
          <div>
            <h4 style={{ fontSize: '0.825rem', fontWeight: 700, color: 'var(--text-primary)', marginBottom: '0.45rem' }}>
              How to Connect PostgreSQL via Environment Variable:
            </h4>
            <ol style={{ paddingLeft: '1.25rem', fontSize: '0.775rem', color: 'var(--text-secondary)', lineHeight: '1.6' }}>
              <li>
                Create a database in pgAdmin named <code style={{ fontFamily: 'var(--font-mono)' }}>tracker_db</code>.
              </li>
              <li>
                In your terminal or <code style={{ fontFamily: 'var(--font-mono)' }}>.env</code> file, set:
                <div style={{
                  margin: '0.35rem 0',
                  padding: '0.5rem 0.75rem',
                  backgroundColor: 'var(--bg-subtle)',
                  borderRadius: 'var(--radius-sm)',
                  border: '1px solid var(--border-subtle)',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'space-between',
                  fontFamily: 'var(--font-mono)',
                  fontSize: '0.72rem'
                }}>
                  <span>DATABASE_URL=postgresql://postgres:password@localhost:5432/tracker_db</span>
                  <button 
                    type="button" 
                    className="btn btn-secondary btn-sm"
                    onClick={() => copyToClipboard('DATABASE_URL=postgresql://postgres:password@localhost:5432/tracker_db')}
                    style={{ padding: '0.15rem 0.4rem', fontSize: '0.68rem' }}
                  >
                    <Copy size={11} /> Copy
                  </button>
                </div>
              </li>
              <li>
                Restart the backend with <code style={{ fontFamily: 'var(--font-mono)' }}>./start.sh</code>. Tables (<code style={{ fontFamily: 'var(--font-mono)' }}>clients</code>, <code style={{ fontFamily: 'var(--font-mono)' }}>followups</code>, <code style={{ fontFamily: 'var(--font-mono)' }}>notifications</code>) are generated automatically!
              </li>
            </ol>
          </div>
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
