import React, { useState, useEffect } from 'react';
import { X, CheckCircle2, Sparkles, ThumbsUp } from 'lucide-react';
import confetti from 'canvas-confetti';

export default function CompleteFollowupModal({
  isOpen,
  onClose,
  followup,
  onComplete
}) {
  const [notes, setNotes] = useState('');
  const [isPositive, setIsPositive] = useState(false);
  const [convertToLead, setConvertToLead] = useState(false);
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (followup) {
      setNotes('');
      setIsPositive(followup.is_positive_result || false);
      setConvertToLead(!followup.client_is_lead);
    }
  }, [followup]);

  if (!isOpen || !followup) return null;

  const handleSubmit = async (e) => {
    e.preventDefault();
    setSubmitting(true);
    try {
      if (convertToLead) {
        confetti({
          particleCount: 80,
          spread: 70,
          origin: { y: 0.6 }
        });
      }
      await onComplete(followup.id, {
        isPositive,
        convertToLead: isPositive && convertToLead,
        notes
      });
      onClose();
    } catch (err) {
      alert('Error updating follow-up: ' + err.message);
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div 
        className="modal-card" 
        style={{ maxWidth: '480px' }} 
        onClick={(e) => e.stopPropagation()}
      >
        <div className="modal-header">
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
            <div style={{
              width: '32px',
              height: '32px',
              borderRadius: 'var(--radius-md)',
              backgroundColor: '#ECFDF5',
              color: '#059669',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center'
            }}>
              <CheckCircle2 size={16} />
            </div>
            <div>
              <h3 style={{ fontSize: '1.05rem', fontWeight: 700, color: 'var(--text-primary)' }}>Log Interaction Outcome</h3>
              <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                {followup.title} ({followup.client_name})
              </p>
            </div>
          </div>
          <button className="btn btn-secondary btn-icon" onClick={onClose} style={{ width: '28px', height: '28px' }}>
            <X size={14} />
          </button>
        </div>

        <form onSubmit={handleSubmit}>
          <div className="modal-body">
            <div className="form-group">
              <label className="form-label">Meeting Notes & Next Steps</label>
              <textarea
                className="form-textarea"
                rows={4}
                placeholder="Key talking points, deliverables promised, questions raised..."
                value={notes}
                onChange={(e) => setNotes(e.target.value)}
              />
            </div>

            {/* Positive Approach Checkbox */}
            <div style={{
              backgroundColor: isPositive ? 'var(--positive-bg)' : 'var(--bg-subtle)',
              border: `1px solid ${isPositive ? 'var(--positive-border)' : 'var(--border-subtle)'}`,
              borderRadius: 'var(--radius-md)',
              padding: '0.75rem 0.85rem',
              marginBottom: '0.85rem',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'space-between',
              cursor: 'pointer',
              transition: 'all 0.15s ease'
            }}
            onClick={() => setIsPositive(!isPositive)}
            >
              <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
                <ThumbsUp size={16} color={isPositive ? '#D97706' : '#9CA3AF'} />
                <div>
                  <div style={{ fontSize: '0.815rem', fontWeight: 600, color: isPositive ? 'var(--positive-color)' : 'var(--text-primary)' }}>
                    Positive Approach from Client
                  </div>
                  <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)' }}>
                    Client expressed clear interest, requested pricing, or confirmed next steps
                  </div>
                </div>
              </div>
              <input
                type="checkbox"
                checked={isPositive}
                onChange={(e) => setIsPositive(e.target.checked)}
                style={{ width: '16px', height: '16px', accentColor: '#D97706' }}
              />
            </div>

            {/* If positive approach, prompt to convert */}
            {isPositive && !followup.client_is_lead && (
              <div style={{
                backgroundColor: 'var(--lead-bg)',
                border: '1px solid var(--lead-border)',
                borderRadius: 'var(--radius-md)',
                padding: '0.75rem 0.85rem',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
              }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
                  <Sparkles size={16} color="#059669" />
                  <div>
                    <div style={{ fontSize: '0.815rem', fontWeight: 600, color: 'var(--lead-color)' }}>
                      Convert Client to Qualified Lead?
                    </div>
                    <div style={{ fontSize: '0.72rem', color: '#065F46' }}>
                      Promote {followup.client_name} to active high-priority Lead
                    </div>
                  </div>
                </div>
                <input
                  type="checkbox"
                  checked={convertToLead}
                  onChange={(e) => setConvertToLead(e.target.checked)}
                  style={{ width: '16px', height: '16px', accentColor: '#059669' }}
                />
              </div>
            )}
          </div>

          <div className="modal-footer">
            <button type="button" className="btn btn-secondary" onClick={onClose}>
              Cancel
            </button>
            <button 
              type="submit" 
              className={`btn ${convertToLead && isPositive ? 'btn-lead' : 'btn-primary'}`} 
              disabled={submitting}
            >
              {convertToLead && isPositive ? <Sparkles size={14} /> : <CheckCircle2 size={14} />}
              <span>{submitting ? 'Saving...' : convertToLead && isPositive ? 'Complete & Convert to Lead' : 'Complete Interaction'}</span>
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
