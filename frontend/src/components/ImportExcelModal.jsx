import React, { useState, useRef } from 'react';
import { 
  X, 
  UploadCloud, 
  FileSpreadsheet, 
  Download, 
  CheckCircle2, 
  AlertCircle, 
  Loader2, 
  Target,
  Info
} from 'lucide-react';

import { api } from '../services/api';

export default function ImportExcelModal({
  isOpen,
  onClose,
  onImportSuccess
}) {
  const [file, setFile] = useState(null);
  const [isDragging, setIsDragging] = useState(false);
  const [isUploading, setIsUploading] = useState(false);
  const [importResult, setImportResult] = useState(null);
  const [errorMessage, setErrorMessage] = useState('');
  const fileInputRef = useRef(null);

  if (!isOpen) return null;

  const handleReset = () => {
    setFile(null);
    setImportResult(null);
    setErrorMessage('');
    setIsUploading(false);
  };

  const handleClose = () => {
    handleReset();
    onClose();
  };

  const handleFileSelect = (selectedFile) => {
    if (!selectedFile) return;
    const name = selectedFile.name.toLowerCase();
    if (!name.endsWith('.xlsx') && !name.endsWith('.xls') && !name.endsWith('.csv')) {
      setErrorMessage('Please select a valid Excel (.xlsx, .xls) or CSV file.');
      return;
    }
    setFile(selectedFile);
    setErrorMessage('');
    setImportResult(null);
  };

  const handleDragOver = (e) => {
    e.preventDefault();
    setIsDragging(true);
  };

  const handleDragLeave = () => {
    setIsDragging(false);
  };

  const handleDrop = (e) => {
    e.preventDefault();
    setIsDragging(false);
    if (e.dataTransfer.files && e.dataTransfer.files.length > 0) {
      handleFileSelect(e.dataTransfer.files[0]);
    }
  };

  const handleUpload = async () => {
    if (!file) return;
    setIsUploading(true);
    setErrorMessage('');

    try {
      const result = await api.importExcel(file);
      setImportResult(result);
      if (onImportSuccess) {
        onImportSuccess(result);
      }
    } catch (err) {
      setErrorMessage(err.message || 'Error importing Excel file');
    } finally {
      setIsUploading(false);
    }
  };

  const handleDownloadTemplate = () => {
    const url = api.getImportTemplateUrl();
    const filename = 'Client_Import_Template.xlsx';
    const link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', filename);
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  return (
    <div className="modal-overlay" onClick={handleClose}>
      <div 
        className="modal-card" 
        style={{ maxWidth: '560px' }} 
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="modal-header">
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
            <div style={{
              width: '34px',
              height: '34px',
              borderRadius: 'var(--radius-md)',
              backgroundColor: 'var(--lead-bg)',
              color: 'var(--lead-color)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center'
            }}>
              <FileSpreadsheet size={18} />
            </div>
            <div>
              <h3 style={{ fontSize: '1.05rem', fontWeight: 700, color: 'var(--text-primary)' }}>
                Import Clients from Excel
              </h3>
              <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                Upload an Excel or CSV file to populate the client and leads table
              </p>
            </div>
          </div>
          <button className="btn btn-secondary btn-icon" onClick={handleClose} style={{ width: '28px', height: '28px' }}>
            <X size={14} />
          </button>
        </div>

        {/* Body */}
        <div className="modal-body" style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
          {/* Download Template Bar */}
          <div style={{
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            padding: '0.75rem 0.9rem',
            backgroundColor: 'var(--bg-subtle)',
            border: '1px solid var(--border-subtle)',
            borderRadius: 'var(--radius-md)',
            gap: '0.75rem'
          }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
              <Info size={15} color="var(--primary)" />
              <div style={{ fontSize: '0.75rem', color: 'var(--text-secondary)' }}>
                Need the standard layout? Use our formatted Excel template.
              </div>
            </div>
            <button 
              type="button" 
              className="btn btn-secondary btn-sm"
              onClick={handleDownloadTemplate}
              style={{ flexShrink: 0 }}
            >
              <Download size={12} />
              <span>Get Template</span>
            </button>
          </div>

          {/* Success State */}
          {importResult && (
            <div style={{
              backgroundColor: 'var(--lead-bg)',
              border: '1px solid var(--lead-border)',
              borderRadius: 'var(--radius-md)',
              padding: '1rem',
              textAlign: 'center'
            }}>
              <CheckCircle2 size={32} color="var(--lead-color)" style={{ margin: '0 auto 0.5rem auto' }} />
              <h4 style={{ fontSize: '0.95rem', fontWeight: 700, color: 'var(--lead-color)', marginBottom: '0.25rem' }}>
                Import Complete!
              </h4>
              <p style={{ fontSize: '0.825rem', color: 'var(--text-primary)' }}>
                {importResult.message}
              </p>
              {(importResult.skipped > 0 || importResult.skipped_count > 0) && (
                <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', marginTop: '0.25rem' }}>
                  ({importResult.skipped || importResult.skipped_count} row(s) without required names were skipped)
                </p>
              )}
            </div>
          )}

          {/* Error Message */}
          {errorMessage && (
            <div style={{
              backgroundColor: 'var(--danger-bg)',
              border: '1px solid var(--danger-border)',
              borderRadius: 'var(--radius-md)',
              padding: '0.75rem 0.9rem',
              display: 'flex',
              alignItems: 'center',
              gap: '0.5rem',
              color: 'var(--danger-color)',
              fontSize: '0.8rem'
            }}>
              <AlertCircle size={16} style={{ flexShrink: 0 }} />
              <span>{errorMessage}</span>
            </div>
          )}

          {/* Dropzone */}
          {!importResult && (
            <div
              onDragOver={handleDragOver}
              onDragLeave={handleDragLeave}
              onDrop={handleDrop}
              onClick={() => fileInputRef.current?.click()}
              style={{
                border: `2px dashed ${isDragging ? 'var(--primary)' : 'var(--border-subtle)'}`,
                backgroundColor: isDragging ? 'var(--primary-subtle)' : 'var(--bg-subtle)',
                borderRadius: 'var(--radius-lg)',
                padding: '2rem 1.5rem',
                textAlign: 'center',
                cursor: 'pointer',
                transition: 'all 0.15s ease'
              }}
            >
              <input 
                type="file" 
                ref={fileInputRef} 
                style={{ display: 'none' }} 
                accept=".xlsx, .xls, .csv"
                onChange={(e) => handleFileSelect(e.target.files?.[0])}
              />
              
              <div style={{
                width: '44px',
                height: '44px',
                borderRadius: '50%',
                backgroundColor: 'var(--bg-surface)',
                border: '1px solid var(--border-subtle)',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                margin: '0 auto 0.75rem auto',
                color: 'var(--primary)'
              }}>
                <UploadCloud size={22} />
              </div>

              {file ? (
                <div>
                  <div style={{ fontWeight: 600, color: 'var(--text-primary)', fontSize: '0.875rem' }}>
                    {file.name}
                  </div>
                  <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)', marginTop: '0.2rem' }}>
                    {(file.size / 1024).toFixed(1)} KB • Click or drop another file to replace
                  </div>
                </div>
              ) : (
                <div>
                  <div style={{ fontWeight: 600, color: 'var(--text-primary)', fontSize: '0.875rem' }}>
                    Click to browse or drag & drop spreadsheet
                  </div>
                  <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)', marginTop: '0.25rem' }}>
                    Supports Microsoft Excel (.xlsx, .xls) and CSV (.csv)
                  </div>
                </div>
              )}
            </div>
          )}

            <div style={{
              fontSize: '0.72rem',
              color: 'var(--text-muted)',
              lineHeight: '1.5',
              padding: '0.5rem 0.75rem',
              backgroundColor: 'var(--bg-subtle)',
              borderRadius: 'var(--radius-sm)',
              border: '1px solid var(--border-light)'
            }}>
              <strong style={{ color: 'var(--text-secondary)' }}>
                Supported Column Headers (Steel Detailing):
              </strong><br />
                <>
                  <span style={{ fontFamily: 'var(--font-mono)' }}>Name</span> (Required),{' '}
                  <span style={{ fontFamily: 'var(--font-mono)' }}>Company</span> (Fabricator / Contractor),{' '}
                  <span style={{ fontFamily: 'var(--font-mono)' }}>Email</span>,{' '}
                  <span style={{ fontFamily: 'var(--font-mono)' }}>Phone</span>,{' '}
                  <span style={{ fontFamily: 'var(--font-mono)' }}>Status</span>,{' '}
                  <span style={{ fontFamily: 'var(--font-mono)' }}>Is Lead? (YES/NO)</span>,{' '}
                  <span style={{ fontFamily: 'var(--font-mono)' }}>Positive Approach? (YES/NO)</span>,{' '}
                  <span style={{ fontFamily: 'var(--font-mono)' }}>Notes</span>
                </>
            </div>

        </div>

        {/* Footer */}
        <div className="modal-footer">
          {importResult ? (
            <button className="btn btn-primary" onClick={handleClose}>
              Done & View Clients Table
            </button>
          ) : (
            <>
              <button className="btn btn-secondary" onClick={handleClose} disabled={isUploading}>
                Cancel
              </button>
              <button 
                className="btn btn-lead" 
                onClick={handleUpload} 
                disabled={!file || isUploading}
                style={{ minWidth: '120px' }}
              >
                {isUploading ? (
                  <>
                    <Loader2 size={14} className="spin-animation" />
                    <span>Importing...</span>
                  </>
                ) : (
                  <>
                    <Target size={14} />
                    <span>Import to Table</span>
                  </>
                )}
              </button>
            </>
          )}
        </div>
      </div>
    </div>
  );
}
