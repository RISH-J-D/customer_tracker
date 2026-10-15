import React, { useState } from 'react';
import { X, CheckCircle2, CalendarDays } from 'lucide-react';
import { lastConversation, relativeDayLabel, sectionLabelStyle } from './calendarUtils';

const QUICK_PICKS = [
  { id: '1', label: 'Tomorrow', days: 1 },
  { id: '3', label: '+3 days', days: 3 },
  { id: '5', label: '+5 days', days: 5 },
  { id: '7', label: '+1 week', days: 7 },
  { id: '14', label: '+2 weeks', days: 14 }
];

const pad = (n) => String(n).padStart(2, '0');
const toInputDate = (d) => `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}`;
const addDays = (days) => {
  const d = new Date();
  d.setDate(d.getDate() + days);
  return d;
};
// Follow-ups are scheduled for 10:00 local time on the chosen day
const atTenAm = (inputDate) => {
  const [y, m, d] = inputDate.split('-').map(Number);
  return new Date(y, m - 1, d, 10, 0, 0);
};

export default function FollowUpLogModal({ client, onClose, onSave }) {
  const [note, setNote] = useState('');
  const [pick, setPick] = useState('3');
  const [customDate, setCustomDate] = useState(toInputDate(addDays(3)));
  const [saving, setSaving] = useState(false);

  const last = lastConversation(client);
  const quick = QUICK_PICKS.find(q => q.id === pick);
  const nextDate = pick === 'none' ? null : quick ? toInputDate(addDays(quick.days)) : customDate;

  const handleSave = async () => {
    setSaving(true);
    try {
      await onSave(client.id, {
        note: note.trim(),
        nextFollowupAt: nextDate ? atTenAm(nextDate).toISOString() : null
      });
      onClose();
    } catch (err) {
      alert('Could not save follow-up: ' + err.message);
      setSaving(false);
    }
  };

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-card" style={{ maxWidth: '520px' }} onClick={(e) => e.stopPropagation()}>
        <div className="modal-header">
          <div>
            <h3 style={{ fontSize: '1.05rem', fontWeight: 700, color: 'var(--text-primary)' }}>
              Followed up with {client.company || client.name}
            </h3>
            <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
              Save what you talked about and pick the next follow-up date
            </p>
          </div>
          <button className="btn btn-secondary btn-icon" onClick={onClose} style={{ width: '28px', height: '28px', flexShrink: 0 }}>
            <X size={14} />
          </button>
        </div>

        <div className="modal-body" style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
          {last && (
            <div style={{ backgroundColor: 'var(--bg-subtle)', border: '1px solid var(--border-subtle)', borderRadius: 'var(--radius-md)', padding: '0.6rem 0.75rem' }}>
              <div style={{ ...sectionLabelStyle, marginBottom: '0.3rem' }}>
                Last conversation — {relativeDayLabel(last.date)}
              </div>
              {last.items.map(n => (
                <div key={n.id} style={{ fontSize: '0.78rem', color: 'var(--text-primary)', whiteSpace: 'pre-wrap', marginTop: '0.15rem' }}>
                  {n.content}
                </div>
              ))}
            </div>
          )}

          <div className="form-group" style={{ marginBottom: 0 }}>
            <label className="form-label">What did you talk about today?</label>
            <textarea
              autoFocus
              className="form-textarea"
              rows={4}
              placeholder="e.g. Spoke to John, they have 2 projects coming in March — send rates next week"
              value={note}
              onChange={(e) => setNote(e.target.value)}
            />
          </div>

          <div className="form-group" style={{ marginBottom: 0 }}>
            <label className="form-label">Next follow-up</label>
            <div className="followup-picks">
              {QUICK_PICKS.map(q => (
                <button
                  key={q.id}
                  type="button"
                  className={`followup-pick${pick === q.id ? ' active' : ''}`}
                  onClick={() => setPick(q.id)}
                >
                  {q.label}
                </button>
              ))}
              <button
                type="button"
                className={`followup-pick${pick === 'custom' ? ' active' : ''}`}
                onClick={() => setPick('custom')}
              >
                <CalendarDays size={12} />
                <span>Pick date</span>
              </button>
              <button
                type="button"
                className={`followup-pick${pick === 'none' ? ' active' : ''}`}
                onClick={() => setPick('none')}
              >
                No follow-up
              </button>
            </div>

            {pick === 'custom' && (
              <input
                type="date"
                className="form-input"
                style={{ marginTop: '0.5rem', maxWidth: '200px' }}
                min={toInputDate(new Date())}
                value={customDate}
                onChange={(e) => setCustomDate(e.target.value)}
              />
            )}

            <div style={{ fontSize: '0.78rem', color: 'var(--text-secondary)', marginTop: '0.5rem' }}>
              {nextDate
                ? <>Next follow-up: <strong>{atTenAm(nextDate).toLocaleDateString([], { weekday: 'long', month: 'short', day: 'numeric' })}</strong></>
                : 'No next follow-up will be scheduled.'}
            </div>
          </div>
        </div>

        <div className="modal-footer">
          <button type="button" className="btn btn-secondary" onClick={onClose}>Cancel</button>
          <button
            type="button"
            className="btn btn-primary"
            onClick={handleSave}
            disabled={saving || (pick === 'custom' && !customDate)}
          >
            <CheckCircle2 size={14} />
            <span>{saving ? 'Saving...' : 'Save follow-up'}</span>
          </button>
        </div>
      </div>
    </div>
  );
}
