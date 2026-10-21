import React, { useState } from 'react';
import { Plus, Edit3, Trash2, Check, X } from 'lucide-react';
import {
  parseServerUtc,
  groupByDay,
  formatTime,
  relativeDayLabel,
  linkButtonStyle,
  sectionLabelStyle
} from './calendarUtils';
import { CalendarDayGroup } from './CalendarDay';

const VISIBLE_DAYS = 3;
const LEGACY_ID = 'legacy';

const iconButtonStyle = {
  border: 'none',
  background: 'transparent',
  color: 'var(--text-muted)',
  cursor: 'pointer',
  padding: '2px',
  borderRadius: '3px',
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'center',
  flexShrink: 0
};

const pad = (n) => String(n).padStart(2, '0');
const toInputDate = (d) => `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}`;

// The picked day, keeping the time of day from `timeFrom` so notes stay in order within a day
const onDay = (inputDate, timeFrom) => {
  const [y, m, d] = inputDate.split('-').map(Number);
  return new Date(y, m - 1, d, timeFrom.getHours(), timeFrom.getMinutes(), timeFrom.getSeconds());
};

// `initialDate` null hides the date picker (the legacy free-text note has no editable date).
// onSave gets (content, isoDate) — isoDate is null when the date was left unchanged.
function NoteEditor({ initialValue = '', initialDate = new Date(), placeholder, onSave, onCancel }) {
  const [draft, setDraft] = useState(initialValue);
  const [day, setDay] = useState(initialDate ? toInputDate(initialDate) : '');
  const [isSaving, setIsSaving] = useState(false);

  const save = async () => {
    const content = draft.trim();
    if (!content) return;
    setIsSaving(true);
    try {
      const changedDay = initialDate && day && day !== toInputDate(initialDate);
      await onSave(content, changedDay ? onDay(day, initialDate).toISOString() : null);
    } catch (err) {
      console.error('Failed to save note:', err);
      setIsSaving(false);
    }
  };

  return (
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
        value={draft}
        onChange={(e) => setDraft(e.target.value)}
        placeholder={placeholder}
        className="form-input"
        style={{ width: '100%', fontSize: '0.74rem', padding: '0.35rem', resize: 'vertical', minHeight: '44px', border: '1px solid var(--border-subtle)' }}
        onKeyDown={(e) => {
          if (e.key === 'Enter' && (e.ctrlKey || e.metaKey)) save();
          else if (e.key === 'Escape') onCancel();
        }}
      />
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'flex-end', flexWrap: 'wrap', gap: '0.35rem' }}>
        {initialDate && (
          <input
            type="date"
            className="form-input"
            title="Date of this note"
            style={{ marginRight: 'auto', width: 'auto', height: '24px', fontSize: '0.7rem', padding: '0 0.3rem' }}
            value={day}
            onChange={(e) => setDay(e.target.value)}
          />
        )}
        <button type="button" className="btn btn-secondary btn-sm" style={{ fontSize: '0.68rem', padding: '0.15rem 0.4rem' }} onClick={onCancel} disabled={isSaving}>
          <X size={10} />
          <span>Cancel</span>
        </button>
        <button type="button" className="btn btn-primary btn-sm" style={{ fontSize: '0.68rem', padding: '0.15rem 0.5rem' }} onClick={save} disabled={isSaving || !draft.trim()}>
          <Check size={10} />
          <span>{isSaving ? 'Saving...' : 'Save'}</span>
        </button>
      </div>
    </div>
  );
}

// `compact` shows only the latest note until "All notes" is opened
export default function NotesCell({ client, onAddNote, onEditNote, onDeleteNote, onUpdateNotes, compact = false }) {
  const [isAdding, setIsAdding] = useState(false);
  const [editingId, setEditingId] = useState(null);
  const [showAll, setShowAll] = useState(false);
  const [expanded, setExpanded] = useState(false);

  // Dated note entries, plus the client's original free-text note (dated when the client was added).
  const entries = (client.note_entries || []).map(n => ({ ...n, date: parseServerUtc(n.created_at) }));
  if (client.notes) {
    entries.push({ id: LEGACY_ID, content: client.notes, date: parseServerUtc(client.created_at), isLegacy: true });
  }
  entries.sort((a, b) => (b.date?.getTime() || 0) - (a.date?.getTime() || 0));

  const days = groupByDay(entries, n => n.date);
  const visibleDays = showAll ? days : days.slice(0, VISIBLE_DAYS);
  const canAdd = Boolean(onAddNote);

  const saveEdit = async (note, content, createdAt) => {
    if (note.isLegacy) await onUpdateNotes(client.id, content);
    else await onEditNote(client.id, note.id, content, createdAt);
    setEditingId(null);
  };

  const deleteNote = async (note) => {
    if (note.isLegacy) {
      if (window.confirm('Delete this note?')) await onUpdateNotes(client.id, '');
    } else {
      await onDeleteNote(client.id, note.id);
    }
  };

  const renderNote = (note) => {
    if (editingId === note.id) {
      return (
        <NoteEditor
          key={note.id}
          initialValue={note.content}
          initialDate={note.isLegacy ? null : note.date}
          onSave={(content, createdAt) => saveEdit(note, content, createdAt)}
          onCancel={() => setEditingId(null)}
        />
      );
    }
    const canEdit = note.isLegacy ? Boolean(onUpdateNotes) : Boolean(onEditNote);
    const canDelete = note.isLegacy ? Boolean(onUpdateNotes) : Boolean(onDeleteNote);
    return (
      <div
        key={note.id}
        className="table-lead-note-box"
        style={{
          fontSize: '0.73rem',
          lineHeight: '1.35',
          color: 'var(--text-primary)',
          backgroundColor: 'var(--bg-subtle)',
          border: '1px solid var(--border-subtle)',
          borderRadius: 'var(--radius-sm)',
          padding: '0.3rem 0.45rem',
          display: 'flex',
          alignItems: 'flex-start',
          justifyContent: 'space-between',
          gap: '0.3rem'
        }}
      >
        <div style={{ minWidth: 0 }}>
          <div style={{ fontSize: '0.63rem', color: 'var(--text-muted)', marginBottom: '0.1rem' }}>
            {note.isLegacy ? 'Original note' : formatTime(note.date)}
            {note.author && ` • ${note.author}`}
          </div>
          <span
            style={{ wordBreak: 'break-word', display: '-webkit-box', WebkitLineClamp: 3, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}
            title={note.content}
          >
            {note.content}
          </span>
        </div>
        <div style={{ display: 'flex', gap: '1px' }}>
          {canEdit && (
            <button type="button" style={iconButtonStyle} onClick={() => setEditingId(note.id)} title="Edit note">
              <Edit3 size={11} />
            </button>
          )}
          {canDelete && (
            <button type="button" style={iconButtonStyle} onClick={() => deleteNote(note)} title="Delete note">
              <Trash2 size={11} />
            </button>
          )}
        </div>
      </div>
    );
  };

  const addEditor = isAdding && (
    <NoteEditor
      placeholder="Type a note... (Ctrl+Enter to save)"
      onSave={async (content, createdAt) => {
        await onAddNote(client.id, content, createdAt);
        setIsAdding(false);
      }}
      onCancel={() => setIsAdding(false)}
    />
  );

  if (compact && !expanded) {
    const latest = entries[0];
    return (
      <div className="note-cell">
        {addEditor}
        {latest ? (
          <>
            <div className="note-cell-meta">
              {latest.date ? relativeDayLabel(latest.date) : 'Note'}
              {latest.author && ` · ${latest.author}`}
            </div>
            <div className="note-cell-text" title={latest.content}>{latest.content}</div>
          </>
        ) : !isAdding && (
          <span className="note-cell-empty">No notes yet</span>
        )}
        {!isAdding && (
          <div className="note-cell-links">
            {canAdd && (
              <button type="button" style={linkButtonStyle} onClick={() => setIsAdding(true)} title="Add a dated note">
                <Plus size={11} />
                <span>Add note</span>
              </button>
            )}
            {entries.length > 0 && (
              <button type="button" style={{ ...linkButtonStyle, color: 'var(--text-muted)' }} onClick={() => setExpanded(true)}>
                {entries.length > 1 ? `All ${entries.length} notes` : 'Edit'}
              </button>
            )}
          </div>
        )}
      </div>
    );
  }

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.4rem', minWidth: '160px' }}>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: '0.35rem' }}>
        <span style={sectionLabelStyle}>Notes{entries.length > 0 ? ` (${entries.length})` : ''}</span>
        {canAdd && !isAdding && (
          <button type="button" style={linkButtonStyle} onClick={() => setIsAdding(true)} title="Add a dated note">
            <Plus size={11} />
            <span>Add note</span>
          </button>
        )}
      </div>

      {addEditor}

      {entries.length === 0 && !isAdding && (
        <span style={{ fontSize: '0.7rem', color: 'var(--text-muted)', fontStyle: 'italic' }}>No notes recorded</span>
      )}

      {visibleDays.map(g => (
        <CalendarDayGroup key={g.key} date={g.date}>
          {g.items.map(renderNote)}
        </CalendarDayGroup>
      ))}

      {days.length > VISIBLE_DAYS && (
        <button type="button" style={linkButtonStyle} onClick={() => setShowAll(v => !v)}>
          {showAll ? 'Show less' : `+${days.length - VISIBLE_DAYS} more days`}
        </button>
      )}

      {compact && (
        <button type="button" style={{ ...linkButtonStyle, color: 'var(--text-muted)' }} onClick={() => { setExpanded(false); setShowAll(false); }}>
          Collapse
        </button>
      )}
    </div>
  );
}
