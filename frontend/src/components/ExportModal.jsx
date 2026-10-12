import React, { useState, useEffect } from 'react';
import { X, FileSpreadsheet, FileText, Download, Building2, Users } from 'lucide-react';
import { api } from '../services/api';

export default function ExportModal({
  isOpen,
  onClose,
  stats,
  defaultType = 'clients'
}) {
  const [dataset, setDataset] = useState(defaultType || 'clients');

  useEffect(() => {
    if (defaultType) {
      setDataset(defaultType);
    }
  }, [defaultType, isOpen]);

  if (!isOpen) return null;

  const isAccounts = dataset === 'accounts';

  const handleDownload = (format) => {
    const url = isAccounts ? api.getAccountsExportUrl(format) : api.getExportUrl(format);
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
        style={{ maxWidth: '540px' }} 
        onClick={(e) => e.stopPropagation()}
      >
        <div className="modal-header">
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
            <div style={{
              width: '32px',
              height: '32px',
              borderRadius: 'var(--radius-md)',
              backgroundColor: isAccounts ? 'var(--lead-surface)' : '#EFF6FF',
              color: isAccounts ? 'var(--lead-action)' : 'var(--primary)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              border: isAccounts ? '1px solid var(--lead-border)' : 'none'
            }}>
              <Download size={16} />
            </div>
            <div>
              <h3 style={{ fontSize: '1.05rem', fontWeight: 700, color: 'var(--text-primary)' }}>
                {isAccounts ? 'Export Accounts & Projects' : 'Export Client Reports'}
              </h3>
              <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                {isAccounts
                  ? 'Download corporate accounts, multi-rep project details, contract values & tonnage'
                  : 'Download client dataset, pipeline leads, and meetup logs in standard formats'}
              </p>
            </div>
          </div>
          <button className="btn btn-secondary btn-icon" onClick={onClose} style={{ width: '28px', height: '28px' }}>
            <X size={14} />
          </button>
        </div>

        {/* Dataset Switcher Tabs */}
        <div style={{
          padding: '0 1.25rem 0.75rem 1.25rem',
          display: 'flex',
          gap: '0.5rem'
        }}>
          <button
            type="button"
            onClick={() => setDataset('clients')}
            style={{
              flex: 1,
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              gap: '0.45rem',
              padding: '0.5rem 0.75rem',
              borderRadius: 'var(--radius-md)',
              fontSize: '0.8rem',
              fontWeight: 600,
              border: dataset === 'clients' ? '1px solid var(--primary)' : '1px solid var(--border-subtle)',
              backgroundColor: dataset === 'clients' ? '#EFF6FF' : 'var(--bg-surface)',
              color: dataset === 'clients' ? 'var(--primary)' : 'var(--text-secondary)',
              cursor: 'pointer',
              transition: 'all 0.15s ease'
            }}
          >
            <Users size={14} />
            <span>Clients & Leads</span>
          </button>

          <button
            type="button"
            onClick={() => setDataset('accounts')}
            style={{
              flex: 1,
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              gap: '0.45rem',
              padding: '0.5rem 0.75rem',
              borderRadius: 'var(--radius-md)',
              fontSize: '0.8rem',
              fontWeight: 600,
              border: dataset === 'accounts' ? '1px solid var(--lead-action)' : '1px solid var(--border-subtle)',
              backgroundColor: dataset === 'accounts' ? 'var(--lead-surface)' : 'var(--bg-surface)',
              color: dataset === 'accounts' ? 'var(--lead-action)' : 'var(--text-secondary)',
              cursor: 'pointer',
              transition: 'all 0.15s ease'
            }}
          >
            <Building2 size={14} />
            <span>Accounts & Projects</span>
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
                  {isAccounts
                    ? 'Structured workbook with accounts, representatives, project values, and tonnage.'
                    : 'Multi-sheet workbook with styled headers, lead status, and meetup schedules.'}
                </p>
              </div>
            </div>
            <button className={isAccounts ? "btn btn-primary btn-sm" : "btn btn-lead btn-sm"} style={isAccounts ? { backgroundColor: 'var(--lead-action)', borderColor: 'var(--lead-action)', color: 'white' } : {}}>
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
                  {isAccounts
                    ? 'Executive accounts summary with KPI totals, client reps, and detailing scope.'
                    : 'Landscape summary report with KPI stat cards, contacts, and deal values.'}
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
                  {isAccounts
                    ? 'Raw comma-separated dataset with accounts, reps, positions, values, and tonnages.'
                    : 'Raw comma-separated dataset compatible with Google Sheets & CRM imports.'}
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
