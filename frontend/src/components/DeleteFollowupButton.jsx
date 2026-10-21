import React from 'react';
import { Trash2 } from 'lucide-react';

// Small trash icon shown on follow-up rows (History, Agenda)
export default function DeleteFollowupButton({ followupId, onDelete }) {
  if (!onDelete) return null;
  return (
    <button type="button" className="fu-delete" onClick={() => onDelete(followupId)} title="Delete this follow-up">
      <Trash2 size={14} />
    </button>
  );
}
