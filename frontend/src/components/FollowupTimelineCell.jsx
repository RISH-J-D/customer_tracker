import React, { useState } from 'react';
import { 
  Calendar, 
  Clock, 
  Plus, 
  FileText, 
  Edit3, 
  Check, 
  X, 
  Phone, 
  Video, 
  Mail, 
  Users, 
  CalendarClock,
  CheckCircle2,
  AlertCircle
} from 'lucide-react';

export default function FollowupTimelineCell({
  client,
  onScheduleFollowup,
  onUpdateNotes
}) {
  const [isEditingNote, setIsEditingNote] = useState(false);
  const [noteDraft, setNoteDraft] = useState(client.notes || '');
  const [isSavingNote, setIsSavingNote] = useState(false);

  const followups = client.followups || [];

  // 1. Next scheduled (Pending) follow-up
  const pendingFollowups = followups
    .filter(f => f.status === 'Pending')
    .sort((a, b) => new Date(a.scheduled_at) - new Date(b.scheduled_at));
  const nextFollowup = pendingFollowups[0];

  // 2. Last completed/past follow-up
  const pastFollowups = followups
    .filter(f => f.status === 'Completed' || (f.status !== 'Pending' && f.status !== 'Cancelled'))
    .sort((a, b) => new Date(b.scheduled_at) - new Date(a.scheduled_at));
  const lastFollowup = pastFollowups[0];

  const touchpointCount = client.total_followups ?? followups.length;

  const formatDateLabel = (dateStr) => {
    if (!dateStr) return '';
    const d = new Date(dateStr);
    if (isNaN(d.getTime())) return '';
    const today = new Date();
    const isToday = d.toDateString() === today.toDateString();
    
    const tomorrow = new Date();
    tomorrow.setDate(today.getDate() + 1);
    const isTomorrow = d.toDateString() === tomorrow.toDateString();

    const yesterday = new Date();
    yesterday.setDate(today.getDate() - 1);
    const isYesterday = d.toDateString() === yesterday.toDateString();

    const timeStr = d.toLocaleTimeString([], { hour: 'numeric', minute: '2-digit' });

    if (isToday) return `Today, ${timeStr}`;
    if (isTomorrow) return `Tomorrow, ${timeStr}`;
    if (isYesterday) return `Yesterday, ${timeStr}`;
    return `${d.toLocaleDateString([], { month: 'short', day: 'numeric' })}, ${timeStr}`;
  };

  const getTypeIcon = (type) => {
    switch (type) {
      case 'Call': return <Phone size={10} />;
      case 'Meetup': return <Video size={10} />;
      case 'Demo': return <Video size={10} />;
      case 'In-Person': return <Users size={10} />;
      case 'Email': return <Mail size={10} />;
      default: return <Calendar size={10} />;
    }
  };

  const handleSaveNote = async () => {
    if (!onUpdateNotes) return;
    setIsSavingNote(true);
    try {
      await onUpdateNotes(client.id, noteDraft.trim());
      setIsEditingNote(false);
    } catch (err) {
      console.error('Failed to update notes:', err);
    } finally {
      setIsSavingNote(false);
    }
  };

  const isNextToday = nextFollowup && new Date(nextFollowup.scheduled_at).toDateString() === new Date().toDateString();
  const isNextOverdue = nextFollowup && new Date(nextFollowup.scheduled_at) < new Date() && !isNextToday;

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.35rem', minWidth: '220px' }}>
      {/* Follow-up Timeline Section */}
      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.25rem' }}>
        {/* Next Follow-up */}
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: '0.35rem' }}>
          {nextFollowup ? (
            <div style={{
              display: 'inline-flex',
              alignItems: 'center',
              gap: '0.3rem',
              fontSize: '0.73rem',
              fontWeight: 600,
              padding: '0.15rem 0.45rem',
              borderRadius: 'var(--radius-sm)',
              backgroundColor: isNextToday ? '#FEF2F2' : isNextOverdue ? '#FFFBEB' : 'rgba(37, 99, 235, 0.08)',
              color: isNextToday ? '#DC2626' : isNextOverdue ? '#D97706' : 'var(--primary)',
              border: `1px solid ${isNextToday ? '#FECACA' : isNextOverdue ? '#FDE68A' : 'var(--primary-border)'}`,
              maxWidth: '100%'
            }}
            title={`Scheduled: ${new Date(nextFollowup.scheduled_at).toLocaleString()}`}
            >
              {getTypeIcon(nextFollowup.type)}
              <span>Next: {formatDateLabel(nextFollowup.scheduled_at)}</span>
              {nextFollowup.priority === 'High' && (
                <span style={{ fontSize: '0.62rem', backgroundColor: '#DC2626', color: '#fff', padding: '0 3px', borderRadius: '3px' }}>
                  High
                </span>
              )}
            </div>
          ) : (
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.3rem' }}>
              <span style={{ fontSize: '0.71rem', color: 'var(--text-muted)' }}>
                No upcoming follow-up
              </span>
              {onScheduleFollowup && (
                <button
                  type="button"
                  onClick={() => onScheduleFollowup(client.id)}
                  style={{
                    border: 'none',
                    background: 'transparent',
                    color: 'var(--primary)',
                    fontSize: '0.71rem',
                    fontWeight: 600,
                    cursor: 'pointer',
                    padding: '0',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '2px'
                  }}
                  title="Schedule a follow-up for this lead"
                >
                  <Plus size={11} />
                  <span>Schedule</span>
                </button>
              )}
            </div>
          )}

          {/* Touchpoint badge */}
          <span style={{
            fontSize: '0.66rem',
            color: 'var(--text-muted)',
            flexShrink: 0
          }}>
            {touchpointCount} touchpoint{touchpointCount === 1 ? '' : 's'}
          </span>
        </div>

        {/* Last Follow-up if exists */}
        {lastFollowup && (
          <div style={{
            display: 'flex',
            alignItems: 'center',
            gap: '0.3rem',
            fontSize: '0.69rem',
            color: 'var(--text-secondary)'
          }}
          title={`Completed on: ${new Date(lastFollowup.scheduled_at).toLocaleString()}`}
          >
            <Clock size={10} color="var(--text-muted)" />
            <span style={{ color: 'var(--text-muted)' }}>Last:</span>
            <span>{formatDateLabel(lastFollowup.scheduled_at)}</span>
            <span style={{ fontSize: '0.65rem', color: 'var(--lead-action)', fontWeight: 600 }}>✓ Done</span>
            {lastFollowup.notes && (
              <span style={{
                color: 'var(--text-muted)',
                fontStyle: 'italic',
                overflow: 'hidden',
                textOverflow: 'ellipsis',
                whiteSpace: 'nowrap',
                maxWidth: '120px'
              }}
              title={lastFollowup.notes}
              >
                — "{lastFollowup.notes}"
              </span>
            )}
          </div>
        )}
      </div>

      {/* Notes Section - Visible directly in the table row */}
      {isEditingNote ? (
        <div style={{
          display: 'flex',
          flexDirection: 'column',
          gap: '0.35rem',
          backgroundColor: 'var(--bg-surface)',
          border: '1px solid var(--primary)',
          borderRadius: 'var(--radius-sm)',
          padding: '0.4rem',
          boxShadow: 'var(--shadow-sm)'
        }}>
          <textarea
            autoFocus
            rows={2}
            value={noteDraft}
            onChange={(e) => setNoteDraft(e.target.value)}
            placeholder="Type follow-up notes here..."
            className="form-input"
            style={{
              width: '100%',
              fontSize: '0.74rem',
              padding: '0.35rem',
              resize: 'vertical',
              minHeight: '44px',
              border: '1px solid var(--border-subtle)'
            }}
            onKeyDown={(e) => {
              if (e.key === 'Enter' && (e.ctrlKey || e.metaKey)) {
                handleSaveNote();
              } else if (e.key === 'Escape') {
                setIsEditingNote(false);
                setNoteDraft(client.notes || '');
              }
            }}
          />
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'flex-end', gap: '0.35rem' }}>
            <button
              type="button"
              className="btn btn-secondary btn-sm"
              style={{ fontSize: '0.68rem', padding: '0.15rem 0.4rem' }}
              onClick={() => {
                setIsEditingNote(false);
                setNoteDraft(client.notes || '');
              }}
              disabled={isSavingNote}
            >
              <X size={10} />
              <span>Cancel</span>
            </button>
            <button
              type="button"
              className="btn btn-primary btn-sm"
              style={{ fontSize: '0.68rem', padding: '0.15rem 0.5rem' }}
              onClick={handleSaveNote}
              disabled={isSavingNote}
            >
              <Check size={10} />
              <span>{isSavingNote ? 'Saving...' : 'Save Note'}</span>
            </button>
          </div>
        </div>
      ) : client.notes ? (
        <div 
          style={{
            fontSize: '0.735rem',
            lineHeight: '1.35',
            color: 'var(--text-primary)',
            backgroundColor: 'var(--bg-subtle)',
            border: '1px solid var(--border-subtle)',
            borderRadius: 'var(--radius-sm)',
            padding: '0.35rem 0.5rem',
            display: 'flex',
            alignItems: 'flex-start',
            justifyContent: 'space-between',
            gap: '0.35rem',
            position: 'relative'
          }}
          className="table-lead-note-box"
        >
          <div style={{ display: 'flex', alignItems: 'flex-start', gap: '0.35rem', minWidth: 0 }}>
            <FileText size={11} color="var(--primary)" style={{ flexShrink: 0, marginTop: '2px' }} />
            <span 
              style={{ 
                wordBreak: 'break-word',
                display: '-webkit-box',
                WebkitLineClamp: 3,
                WebkitBoxOrient: 'vertical',
                overflow: 'hidden'
              }}
              title={client.notes}
            >
              {client.notes}
            </span>
          </div>
          {onUpdateNotes && (
            <button
              type="button"
              onClick={() => {
                setNoteDraft(client.notes || '');
                setIsEditingNote(true);
              }}
              style={{
                border: 'none',
                background: 'transparent',
                color: 'var(--text-muted)',
                cursor: 'pointer',
                padding: '2px',
                borderRadius: '3px',
                flexShrink: 0,
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center'
              }}
              title="Edit note directly in table"
            >
              <Edit3 size={11} />
            </button>
          )}
        </div>
      ) : (
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', marginTop: '0.1rem' }}>
          <span style={{ fontSize: '0.71rem', color: 'var(--text-muted)', fontStyle: 'italic' }}>
            No notes recorded
          </span>
          {onUpdateNotes && (
            <button
              type="button"
              onClick={() => {
                setNoteDraft('');
                setIsEditingNote(true);
              }}
              style={{
                border: 'none',
                background: 'transparent',
                color: 'var(--primary)',
                fontSize: '0.71rem',
                fontWeight: 600,
                cursor: 'pointer',
                padding: '0',
                display: 'flex',
                alignItems: 'center',
                gap: '2px'
              }}
              title="Add a note to this record"
            >
              <Plus size={10} />
              <span>Add Note</span>
            </button>
          )}
        </div>
      )}
    </div>
  );
}
