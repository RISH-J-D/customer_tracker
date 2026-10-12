import React, { useState, useEffect } from 'react';
import { X, UserPlus } from 'lucide-react';
import confetti from 'canvas-confetti';


export default function ClientModal({
  isOpen,
  onClose,
  client,
  onSave,
  isLeadMode = false
}) {
  const parseName = (fullName = '') => {
    const trimmed = (fullName || '').trim();
    if (!trimmed) return { first: '', last: '' };
    const parts = trimmed.split(/\s+/);
    if (parts.length === 1) return { first: parts[0], last: '' };
    return { first: parts[0], last: parts.slice(1).join(' ') };
  };

  const [formData, setFormData] = useState({
    first_name: '',
    last_name: '',
    name: '',
    company: '',
    email: '',
    phone: '',
    category: 'Steel Detailing',
    status: isLeadMode ? 'Lead' : 'Prospect',
    is_lead: isLeadMode,
    positive_approach: isLeadMode,
    deal_value: 0,
    notes: ''
  });
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (client) {
      const { first, last } = parseName(client.name);
      setFormData({
        first_name: first,
        last_name: last,
        name: client.name || '',
        company: client.company || '',
        email: client.email || '',
        phone: client.phone || '',
        category: 'Steel Detailing',
        status: client.status || (client.is_lead ? 'Lead' : 'Prospect'),
        is_lead: client.is_lead || false,
        positive_approach: client.positive_approach || false,
        deal_value: client.deal_value || 0,
        notes: client.notes || ''
      });
    } else {
      setFormData({
        first_name: '',
        last_name: '',
        name: '',
        company: '',
        email: '',
        phone: '',
        category: 'Steel Detailing',
        status: isLeadMode ? 'Lead' : 'Prospect',
        is_lead: isLeadMode,
        positive_approach: isLeadMode,
        deal_value: 0,
        notes: ''
      });
    }
  }, [client, isOpen, isLeadMode]);

  if (!isOpen) return null;

  const handleSubmit = async (e) => {
    e.preventDefault();
    const fullName = `${formData.first_name} ${formData.last_name}`.trim();
    if (!formData.first_name.trim() || !formData.last_name.trim()) {
      alert('Please enter both First Name and Last Name');
      return;
    }

    setSubmitting(true);
    try {
      if (formData.is_lead && (!client || !client.is_lead)) {
        confetti({
          particleCount: 80,
          spread: 70,
          origin: { y: 0.6 }
        });
      }
      await onSave({ ...formData, name: fullName }, client?.id);
      onClose();
    } catch (err) {
      alert('Error saving client: ' + err.message);
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div 
        className="modal-card" 
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
              <UserPlus size={16} />
            </div>
            <div>
              <h3 style={{ fontSize: '1.05rem', fontWeight: 700, color: 'var(--text-primary)' }}>
                {client ? 'Edit Client Profile' : 'Add New Client'}
              </h3>
              <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                Track contacts, meetups, and pipeline conversion
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
                <input
                  type="text"
                  required
                  placeholder="e.g. Alexander"
                  className="form-input"
                  value={formData.first_name}
                  onChange={(e) => {
                    const fn = e.target.value;
                    setFormData({ ...formData, first_name: fn, name: `${fn} ${formData.last_name}`.trim() });
                  }}
                />
              </div>

              <div className="form-group">
                <label className="form-label">Last Name *</label>
                <input
                  type="text"
                  required
                  placeholder="e.g. Wright"
                  className="form-input"
                  value={formData.last_name}
                  onChange={(e) => {
                    const ln = e.target.value;
                    setFormData({ ...formData, last_name: ln, name: `${formData.first_name} ${ln}`.trim() });
                  }}
                />
              </div>

              <div className="form-group">
                <label className="form-label">Company / Organization</label>
                <input
                  type="text"
                  placeholder="e.g. Apex Global Logistics"
                  className="form-input"
                  value={formData.company}
                  onChange={(e) => setFormData({ ...formData, company: e.target.value })}
                />
              </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))', gap: '0.85rem' }}>
              <div className="form-group">
                <label className="form-label">Email Address</label>
                <input
                  type="email"
                  placeholder="alexander@company.com"
                  className="form-input"
                  value={formData.email}
                  onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                />
              </div>

              <div className="form-group">
                <label className="form-label">Phone Number</label>
                <input
                  type="text"
                  placeholder="+1 (555) 234-8901"
                  className="form-input"
                  value={formData.phone}
                  onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
                />
              </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '0.85rem' }}>
              <div className="form-group">
                <label className="form-label">Estimated Steel Detailing Deal Value ($)</label>
                <input
                  type="number"
                  min="0"
                  step="500"
                  placeholder="25000"
                  className="form-input"
                  value={formData.deal_value}
                  onChange={(e) => setFormData({ ...formData, deal_value: parseFloat(e.target.value) || 0 })}
                />
              </div>

              <div className="form-group">
                <label className="form-label">Status Stage</label>
                <select
                  className="form-select"
                  value={formData.status}
                  onChange={(e) => {
                    const st = e.target.value;
                    const isL = st === 'Lead';
                    const isPos = isL || st === 'Positive Response';
                    setFormData({ ...formData, status: st, is_lead: isL, positive_approach: isPos });
                  }}
                >
                  <option value="Prospect">Prospect</option>
                  <option value="In Discussion">In Discussion</option>
                  <option value="Meeting Scheduled">Meeting Scheduled</option>
                  <option value="Positive Response">Positive Response</option>
                  <option value="Lead">Lead</option>
                  <option value="Closed Won">Closed Won</option>
                  <option value="Lost">Lost</option>
                </select>
              </div>
            </div>


            {/* Checkboxes: Positive Approach & Lead */}
            <div style={{
              backgroundColor: 'var(--bg-subtle)',
              border: '1px solid var(--border-subtle)',
              borderRadius: 'var(--radius-md)',
              padding: '0.75rem 0.85rem',
              marginBottom: '0.85rem',
              display: 'flex',
              flexDirection: 'column',
              gap: '0.65rem'
            }}>
              <label style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', cursor: 'pointer' }}>
                <span style={{ fontSize: '0.815rem', color: 'var(--text-primary)', fontWeight: 500 }}>
                  Client demonstrated Positive Approach
                </span>
                <input
                  type="checkbox"
                  checked={formData.positive_approach}
                  onChange={(e) => setFormData({ ...formData, positive_approach: e.target.checked })}
                  style={{ width: '16px', height: '16px', accentColor: '#D97706' }}
                />
              </label>

              <label style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', cursor: 'pointer' }}>
                <span style={{ fontSize: '0.815rem', color: formData.is_lead ? 'var(--lead-color)' : 'var(--text-primary)', fontWeight: formData.is_lead ? 600 : 500 }}>
                  Mark as Qualified Lead
                </span>
                <input
                  type="checkbox"
                  checked={formData.is_lead}
                  onChange={(e) => setFormData({ 
                    ...formData, 
                    is_lead: e.target.checked,
                    status: e.target.checked ? 'Lead' : formData.status,
                    positive_approach: e.target.checked ? true : formData.positive_approach
                  })}
                  style={{ width: '16px', height: '16px', accentColor: '#059669' }}
                />
              </label>
            </div>

            <div className="form-group">
              <label className="form-label">Client Notes & Requirements</label>
              <textarea
                className="form-textarea"
                rows={3}
                placeholder="Background, key decision makers, special interests..."
                value={formData.notes}
                onChange={(e) => setFormData({ ...formData, notes: e.target.value })}
              />
            </div>
          </div>

          <div className="modal-footer">
            <button type="button" className="btn btn-secondary" onClick={onClose}>
              Cancel
            </button>
            <button type="submit" className="btn btn-primary" disabled={submitting}>
              {submitting ? 'Saving...' : client ? 'Update Client' : 'Add Client'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
