import React from 'react';
import { ChevronLeft, ChevronRight } from 'lucide-react';

export default function Pagination({ page, pageSize, total, noun, onPageChange, onPageSizeChange }) {
  if (total === 0) return null;
  const totalPages = Math.ceil(total / pageSize) || 1;
  const navBtnStyle = { fontSize: '0.75rem', height: '30px', padding: '0 0.65rem', display: 'flex', alignItems: 'center', gap: '0.25rem' };

  return (
    <div style={{
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'space-between',
      flexWrap: 'wrap',
      gap: '0.75rem',
      marginTop: '1.5rem',
      padding: '0.85rem 1.15rem',
      backgroundColor: 'var(--bg-surface)',
      borderRadius: 'var(--radius-md)',
      border: '1px solid var(--border-subtle)',
      boxShadow: 'var(--shadow-xs)'
    }}>
      <div style={{ fontSize: '0.8rem', color: 'var(--text-secondary)' }}>
        Showing <strong>{((page - 1) * pageSize) + 1}</strong>–<strong>{Math.min(page * pageSize, total)}</strong> of <strong>{total.toLocaleString()}</strong> {noun}
      </div>

      <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', flexWrap: 'wrap' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', fontSize: '0.75rem', color: 'var(--text-muted)' }}>
          <span>Per page:</span>
          <select
            value={pageSize}
            onChange={(e) => onPageSizeChange(Number(e.target.value))}
            className="form-select"
            style={{ fontSize: '0.75rem', height: '30px', padding: '0.1rem 0.5rem' }}
          >
            <option value={25}>25</option>
            <option value={50}>50</option>
            <option value={100}>100</option>
          </select>
        </div>

        <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
          <button className="btn btn-secondary btn-sm" disabled={page <= 1} onClick={() => onPageChange(Math.max(1, page - 1))} style={navBtnStyle}>
            <ChevronLeft size={13} />
            <span>Prev</span>
          </button>
          <span style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--text-primary)', padding: '0 0.5rem' }}>
            Page {page} of {totalPages}
          </span>
          <button className="btn btn-secondary btn-sm" disabled={page >= totalPages} onClick={() => onPageChange(Math.min(totalPages, page + 1))} style={navBtnStyle}>
            <span>Next</span>
            <ChevronRight size={13} />
          </button>
        </div>
      </div>
    </div>
  );
}
