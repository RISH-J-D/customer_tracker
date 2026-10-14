import React, { useState, useEffect } from 'react';
import { X, CalendarPlus, Clock, Video, MapPin } from 'lucide-react';

export default function FollowUpModal({
  isOpen,
  onClose,
  clients,
  preselectedClientId,
  onSave
}) {
  const [formData, setFormData] = useState({
    client_id: '',
    title: '',
    type: 'Meetup',
    scheduled_at: '',
    priority: 'High',
    status: 'Pending',
    location: 'Google Meet',
    meeting_link: '',
    notes: '',
    is_positive_result: false
  });
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    const d = new Date();
    d.setHours(d.getHours() + 2);
    d.setMinutes(0);
    const tzOffset = d.getTimezoneOffset() * 60000;
    const localISOTime = new Date(d.getTime() - tzOffset).toISOString().slice(0, 16);

    setFormData({
      client_id: preselectedClientId || (clients[0]?.id ? String(clients[0].id) : ''),
      title: '',
      type: 'Meetup',
      scheduled_at: localISOTime,
      priority: 'High',
      status: 'Pending',
      location: 'Google Meet',
      meeting_link: 'https://meet.google.com/new',
      notes: '',
      is_positive_result: false
    });
  }, [isOpen, preselectedClientId, clients]);

  if (!isOpen) return null;

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!formData.client_id) {
      alert('Please select a client');
      return;
    }
    if (!formData.title.trim()) {
      alert('Please enter a title');
      return;
    }
    if (!formData.scheduled_at) {
      alert('Please choose scheduled date and time');
      return;
    }

    setSubmitting(true);
    try {
      await onSave({
        ...formData,
        client_id: parseInt(formData.client_id),
        scheduled_at: new Date(formData.scheduled_at).toISOString()
      });
      onClose();
    } catch (err) {
      alert('Error scheduling follow-up: ' + err.message);
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
              backgroundColor: 'var(--primary-subtle)',
              color: 'var(--primary)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center'
            }}>
              <CalendarPlus size={16} />
            </div>
            <div>
              <h3 style={{ fontSize: '1.05rem', fontWeight: 700, color: 'var(--text-primary)' }}>Schedule Follow-up / Meetup</h3>
              <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                Set reminder date, meeting link, and priority
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
              <label className="form-label">Client *</label>
              <select
                className="form-select"
                required
                value={formData.client_id}
                onChange={(e) => setFormData({ ...formData, client_id: e.target.value })}
              >
                <option value="">Select a client to follow up...</option>
                {clients.map((c) => (
                  <option key={c.id} value={c.id}>
                    {c.name} {c.company ? `(${c.company})` : ''} {c.is_lead ? '★ LEAD' : ''}
                  </option>
                ))}
              </select>
            </div>

            <div className="form-group">
              <label className="form-label">Meeting / Follow-up Title *</label>
              <input
                type="text"
                required
                placeholder="e.g. Q4 Contract Discussion & Demo"
                className="form-input"
                value={formData.title}
                onChange={(e) => setFormData({ ...formData, title: e.target.value })}
              />
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(180px, 1fr))', gap: '0.85rem' }}>
              <div className="form-group">
                <label className="form-label">Interaction Type</label>
                <select
                  className="form-select"
                  value={formData.type}
                  onChange={(e) => {
                    const t = e.target.value;
                    let loc = formData.location;
                    let link = formData.meeting_link;
                    if (t === 'Meetup' || t === 'Demo') {
                      loc = 'Google Meet';
                      link = 'https://meet.google.com/new';
                    } else if (t === 'In-Person') {
                      loc = 'Client Office / Coffee';
                      link = '';
                    } else if (t === 'Call') {
                      loc = 'Phone Call';
                      link = '';
                    }
                    setFormData({ ...formData, type: t, location: loc, meeting_link: link });
                  }}
                >
                  <option value="Meetup">Meetup (Online Video)</option>
                  <option value="In-Person">In-Person Meeting</option>
                  <option value="Demo">Product Demo</option>
                  <option value="Call">Phone Call</option>
                  <option value="Email">Email Follow-up</option>
                </select>
              </div>

              <div className="form-group">
                <label className="form-label">Priority</label>
                <select
                  className="form-select"
                  value={formData.priority}
                  onChange={(e) => setFormData({ ...formData, priority: e.target.value })}
                >
                  <option value="High">High Priority</option>
                  <option value="Medium">Medium Priority</option>
                  <option value="Low">Low Priority</option>
                </select>
              </div>
            </div>

            <div className="form-group">
              <label className="form-label">Scheduled Date & Time *</label>
              <input
                type="datetime-local"
                required
                className="form-input"
                value={formData.scheduled_at}
                onChange={(e) => setFormData({ ...formData, scheduled_at: e.target.value })}
              />
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '0.85rem' }}>
              <div className="form-group">
                <label className="form-label">Location / Platform</label>
                <input
                  type="text"
                  placeholder="Google Meet, Zoom, Downtown Office..."
                  className="form-input"
                  value={formData.location}
                  onChange={(e) => setFormData({ ...formData, location: e.target.value })}
                />
              </div>

              <div className="form-group">
                <label className="form-label">Meeting Link (optional)</label>
                <input
                  type="url"
                  placeholder="https://meet.google.com/..."
                  className="form-input"
                  value={formData.meeting_link}
                  onChange={(e) => setFormData({ ...formData, meeting_link: e.target.value })}
                />
              </div>
            </div>

            <div className="form-group">
              <label className="form-label">Agenda & Preparation Notes</label>
              <textarea
                className="form-textarea"
                rows={3}
                placeholder="Key questions to ask, deliverables to present, pricing constraints..."
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
              {submitting ? 'Scheduling...' : 'Schedule Interaction'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
