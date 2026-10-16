import React, { useState, useEffect } from 'react';
import { X, Users } from 'lucide-react';

// Asked when a lead moves to Contacts: who at the company we're now working with
export default function RepresentativeModal({ lead, onClose, onConfirm }) {
  const [formData, setFormData] = useState({ first_name: '', last_name: '', position: '', email: '', phone: '' });
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (!lead) return;
    // A lead imported without a contact person carries the company name as its name
    const knownName = lead.name && lead.name !== lead.company ? lead.name.trim() : '';
    const parts = knownName ? knownName.split(/\s+/) : [];
    setFormData({
      first_name: parts[0] || '',
      last_name: parts.slice(1).join(' '),
      position: lead.position || '',
      email: lead.email || '',
      phone: lead.phone || ''
    });
  }, [lead]);

  if (!lead) return null;

  const set = (field) => (e) => setFormData({ ...formData, [field]: e.target.value });

  const handleSubmit = async (e) => {
    e.preventDefault();
    setSubmitting(true);
    try {
      await onConfirm(lead.id, {
        name: `${formData.first_name} ${formData.last_name}`.trim(),
        position: formData.position.trim() || null,
        email: formData.email.trim() || null,
        phone: formData.phone.trim() || null
      });
      onClose();
    } catch (err) {
      alert('Error moving lead to contacts: ' + err.message);
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-card" onClick={(e) => e.stopPropagation()}>
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
              <Users size={16} />
            </div>
            <div>
              <h3 style={{ fontSize: '1.05rem', fontWeight: 700, color: 'var(--text-primary)' }}>
                Move to Contacts
              </h3>
              <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                Client representative at {lead.company || lead.name}
              </p>
            </div>
          </div>
          <button className="btn btn-secondary btn-icon" onClick={onClose} style={{ width: '28px', height: '28px' }}>
            <X size={14} />
          </button>
        </div>

        <form onSubmit={handleSubmit}>
          <div className="modal-body">
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(180px, 1fr))', gap: '0.85rem' }}>
              <div className="form-group">
                <label className="form-label">First Name *</label>
                <input type="text" required autoFocus className="form-input" value={formData.first_name} onChange={set('first_name')} />
              </div>
              <div className="form-group">
                <label className="form-label">Last Name</label>
                <input type="text" className="form-input" value={formData.last_name} onChange={set('last_name')} />
              </div>
            </div>

            <div className="form-group">
              <label className="form-label">Position / Job Title</label>
              <input
                type="text"
                placeholder="e.g. Project Manager, Estimator"
                className="form-input"
                value={formData.position}
                onChange={set('position')}
              />
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))', gap: '0.85rem' }}>
              <div className="form-group">
                <label className="form-label">Representative Email</label>
                <input type="email" className="form-input" value={formData.email} onChange={set('email')} />
              </div>
              <div className="form-group">
                <label className="form-label">Representative Phone</label>
                <input type="text" className="form-input" value={formData.phone} onChange={set('phone')} />
              </div>
            </div>
          </div>

          <div className="modal-footer">
            <button type="button" className="btn btn-secondary" onClick={onClose}>
              Cancel
            </button>
            <button type="submit" className="btn btn-primary" disabled={submitting}>
              {submitting ? 'Moving...' : 'Move to Contacts'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
