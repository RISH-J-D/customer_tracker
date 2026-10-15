import React from 'react';
import { Table as TableIcon, LayoutGrid } from 'lucide-react';

const MODES = [
  { id: 'table', label: 'Table', icon: TableIcon, title: 'Table view' },
  { id: 'grid', label: 'Cards', icon: LayoutGrid, title: 'Cards grid view' }
];

export default function ViewModeToggle({ viewMode, onChange }) {
  return (
    <div style={{
      display: 'flex',
      backgroundColor: 'var(--bg-subtle)',
      border: '1px solid var(--border-subtle)',
      borderRadius: 'var(--radius-md)',
      padding: '2px',
    }}>
      {MODES.map(({ id, label, icon: Icon, title }) => {
        const active = viewMode === id;
        return (
          <button
            key={id}
            onClick={() => onChange(id)}
            style={{
              border: 'none',
              background: active ? 'var(--bg-surface)' : 'transparent',
              color: active ? 'var(--text-primary)' : 'var(--text-muted)',
              padding: '0.3rem 0.55rem',
              borderRadius: 'var(--radius-sm)',
              cursor: 'pointer',
              display: 'flex',
              alignItems: 'center',
              gap: '0.3rem',
              fontSize: '0.75rem',
              fontWeight: active ? 600 : 500,
              boxShadow: active ? 'var(--shadow-xs)' : 'none'
            }}
            title={title}
          >
            <Icon size={14} />
            <span>{label}</span>
          </button>
        );
      })}
    </div>
  );
}
