import React from 'react';
import { X, FileSpreadsheet, FileText, Download } from 'lucide-react';
import { api } from '../services/api';

export default function ExportModal({
  isOpen,
  onClose,
  stats
}) {
  if (!isOpen) return null;

  const handleDownload = (format) => {
    const url = api.getExportUrl(format);
    const link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', '');
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div 
        className="modal-card" 
        style={{ maxWidth: '520px' }} 
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
              <Download size={16} />
            </div>
            <div>
              <h3 style={{ fontSize: '1.05rem', fontWeight: 700, color: 'var(--text-primary)' }}>Export Client Reports</h3>
              <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                Download client dataset, leads, and meetup logs in standard formats
              </p>
            </div>
          </div>
          <button className="btn btn-secondary btn-icon" onClick={onClose} style={{ width: '28px', height: '28px' }}>
            <X size={14} />
          </button>
        </div>

        <div className="modal-body" style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
          {/* Format 1: Excel .xlsx */}
          <div 
            onClick={() => handleDownload('excel')}
            style={{
              backgroundColor: 'var(--bg-surface)',
              border: '1px solid var(--border-subtle)',
              borderRadius: 'var(--radius-lg)',
              padding: '1rem',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'space-between',
              cursor: 'pointer',
              transition: 'all 0.15s ease',
            }}
            className="card"
          >
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.85rem' }}>
              <div style={{
                width: '36px',
                height: '36px',
                borderRadius: 'var(--radius-md)',
                backgroundColor: 'var(--lead-bg)',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                color: 'var(--lead-color)'
              }}>
                <FileSpreadsheet size={20} />
              </div>
              <div>
                <div style={{ display: 'flex', alignItems: 'center', gap: '0.4rem' }}>
                  <h4 style={{ fontSize: '0.9rem', fontWeight: 600, color: 'var(--text-primary)' }}>
                    Microsoft Excel (.xlsx)
                  </h4>
                  <span style={{
                    fontSize: '0.65rem',
                    fontWeight: 600,
                    padding: '0.1rem 0.4rem',
                    borderRadius: '999px',
                    backgroundColor: 'var(--lead-bg)',
                    color: 'var(--lead-color)',
                    border: '1px solid var(--lead-border)'
                  }}>
                    Recommended
                  </span>
                </div>
                <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', marginTop: '0.15rem' }}>
                  Multi-sheet workbook with styled headers, lead status, and meetup schedules.
                </p>
              </div>
            </div>
            <button className="btn btn-lead btn-sm">
              <Download size={12} />
              <span>Download</span>
            </button>
          </div>

          {/* Format 2: PDF Document */}
          <div 
            onClick={() => handleDownload('pdf')}
            style={{
              backgroundColor: 'var(--bg-surface)',
              border: '1px solid var(--border-subtle)',
              borderRadius: 'var(--radius-lg)',
              padding: '1rem',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'space-between',
              cursor: 'pointer',
              transition: 'all 0.15s ease',
            }}
            className="card"
          >
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.85rem' }}>
              <div style={{
                width: '36px',
                height: '36px',
                borderRadius: 'var(--radius-md)',
                backgroundColor: 'var(--danger-bg)',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                color: 'var(--danger-color)'
              }}>
                <FileText size={20} />
              </div>
              <div>
                <h4 style={{ fontSize: '0.9rem', fontWeight: 600, color: 'var(--text-primary)' }}>
                  Printable Executive PDF (.pdf)
                </h4>
                <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', marginTop: '0.15rem' }}>
                  Landscape summary report with KPI stat cards, contacts, and deal values.
                </p>
              </div>
            </div>
            <button className="btn btn-secondary btn-sm">
              <Download size={12} />
              <span>Download</span>
            </button>
          </div>

          {/* Format 3: CSV File */}
          <div 
            onClick={() => handleDownload('csv')}
            style={{
              backgroundColor: 'var(--bg-surface)',
              border: '1px solid var(--border-subtle)',
              borderRadius: 'var(--radius-lg)',
              padding: '1rem',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'space-between',
              cursor: 'pointer',
              transition: 'all 0.15s ease',
            }}
            className="card"
          >
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.85rem' }}>
              <div style={{
                width: '36px',
                height: '36px',
                borderRadius: 'var(--radius-md)',
                backgroundColor: '#F3F4F6',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                color: 'var(--text-secondary)'
              }}>
                <FileText size={20} />
              </div>
              <div>
                <h4 style={{ fontSize: '0.9rem', fontWeight: 600, color: 'var(--text-primary)' }}>
                  Standard CSV File (.csv)
                </h4>
                <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', marginTop: '0.15rem' }}>
                  Raw comma-separated dataset compatible with Google Sheets & CRM imports.
                </p>
              </div>
            </div>
            <button className="btn btn-secondary btn-sm">
              <Download size={12} />
              <span>Download</span>
            </button>
          </div>
        </div>

        <div className="modal-footer">
          <button className="btn btn-secondary" onClick={onClose}>
            Close
          </button>
        </div>
      </div>
    </div>
  );
}
