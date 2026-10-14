import React, { useState, useRef, useEffect } from 'react';
import { 
  Download, 
  ChevronDown, 
  FileSpreadsheet, 
  FileText, 
  ExternalLink 
} from 'lucide-react';
import { api } from '../services/api';

const MENU_WIDTH = 220;

export default function ExportDropdown({ onOpenModal, label = "Export", align = "right" }) {
  const [isOpen, setIsOpen] = useState(false);
  const [menuSide, setMenuSide] = useState(align === 'right' ? 'right' : 'left');
  const dropdownRef = useRef(null);

  // Close dropdown on click outside
  useEffect(() => {
    function handleClickOutside(event) {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
        setIsOpen(false);
      }
    }
    function handleKeyDown(event) {
      if (event.key === 'Escape') {
        setIsOpen(false);
      }
    }
    if (isOpen) {
      document.addEventListener('mousedown', handleClickOutside);
      document.addEventListener('keydown', handleKeyDown);
    }
    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
      document.removeEventListener('keydown', handleKeyDown);
    };
  }, [isOpen]);

  const handleDownload = (format) => {
    const url = api.getExportUrl(format);
    const link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', '');
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    setIsOpen(false);
  };

  return (
    <div style={{ position: 'relative', display: 'inline-block' }} ref={dropdownRef}>
      <button
        type="button"
        className="btn btn-secondary"
        onClick={() => {
          // Open toward whichever side has room for the menu (matters on narrow screens)
          const rect = dropdownRef.current?.getBoundingClientRect();
          if (rect) {
            const fitsRight = rect.right >= MENU_WIDTH + 8;
            const fitsLeft = window.innerWidth - rect.left >= MENU_WIDTH + 8;
            setMenuSide(align === 'right' ? (fitsRight || !fitsLeft ? 'right' : 'left') : (fitsLeft || !fitsRight ? 'left' : 'right'));
          }
          setIsOpen(prev => !prev);
        }}
        style={{
          display: 'flex',
          alignItems: 'center',
          gap: '0.4rem',
          fontSize: '0.8125rem',
          fontWeight: 500,
          padding: '0.4rem 0.75rem',
          height: '34px',
          borderColor: isOpen ? 'var(--primary)' : 'var(--border-subtle)',
          backgroundColor: isOpen ? 'var(--bg-hover)' : 'var(--bg-surface)'
        }}
        title="Export options (Excel, PDF, CSV)"
        aria-haspopup="true"
        aria-expanded={isOpen}
      >
        <Download size={14} color="var(--text-secondary)" />
        <span>{label}</span>
        <ChevronDown 
          size={13} 
          style={{ 
            transition: 'transform 0.15s ease', 
            transform: isOpen ? 'rotate(180deg)' : 'none',
            color: 'var(--text-muted)' 
          }} 
        />
      </button>

      {isOpen && (
        <div
          style={{
            position: 'absolute',
            top: 'calc(100% + 4px)',
            [menuSide]: 0,
            zIndex: 1050,
            minWidth: `${MENU_WIDTH}px`,
            backgroundColor: 'var(--bg-surface)',
            borderRadius: 'var(--radius-md)',
            border: '1px solid var(--border-subtle)',
            boxShadow: 'var(--shadow-lg)',
            padding: '0.35rem',
            animation: 'fadeIn 0.15s ease'
          }}
        >
          <div style={{ 
            padding: '0.35rem 0.6rem 0.25rem 0.6rem', 
            fontSize: '0.7rem', 
            fontWeight: 600, 
            textTransform: 'uppercase', 
            letterSpacing: '0.04em', 
            color: 'var(--text-muted)' 
          }}>
            Download As
          </div>

          {/* Excel Option */}
          <button
            type="button"
            onClick={() => handleDownload('excel')}
            style={{
              width: '100%',
              display: 'flex',
              alignItems: 'center',
              gap: '0.6rem',
              padding: '0.5rem 0.65rem',
              borderRadius: 'var(--radius-sm)',
              border: 'none',
              background: 'transparent',
              cursor: 'pointer',
              textAlign: 'left',
              transition: 'background-color 0.1s ease',
            }}
            onMouseEnter={(e) => e.currentTarget.style.backgroundColor = 'var(--bg-hover)'}
            onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
          >
            <div style={{
              width: '24px',
              height: '24px',
              borderRadius: '4px',
              backgroundColor: 'var(--lead-bg)',
              color: 'var(--lead-action)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              flexShrink: 0
            }}>
              <FileSpreadsheet size={14} />
            </div>
            <div style={{ flex: 1 }}>
              <div style={{ fontSize: '0.8rem', fontWeight: 600, color: 'var(--text-primary)' }}>
                Excel (.xlsx)
              </div>
              <div style={{ fontSize: '0.7rem', color: 'var(--text-muted)' }}>
                Multi-sheet report
              </div>
            </div>
          </button>

          {/* PDF Option */}
          <button
            type="button"
            onClick={() => handleDownload('pdf')}
            style={{
              width: '100%',
              display: 'flex',
              alignItems: 'center',
              gap: '0.6rem',
              padding: '0.5rem 0.65rem',
              borderRadius: 'var(--radius-sm)',
              border: 'none',
              background: 'transparent',
              cursor: 'pointer',
              textAlign: 'left',
              transition: 'background-color 0.1s ease',
            }}
            onMouseEnter={(e) => e.currentTarget.style.backgroundColor = 'var(--bg-hover)'}
            onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
          >
            <div style={{
              width: '24px',
              height: '24px',
              borderRadius: '4px',
              backgroundColor: 'var(--danger-bg)',
              color: 'var(--danger-btn)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              flexShrink: 0
            }}>
              <FileText size={14} />
            </div>
            <div style={{ flex: 1 }}>
              <div style={{ fontSize: '0.8rem', fontWeight: 600, color: 'var(--text-primary)' }}>
                PDF Document (.pdf)
              </div>
              <div style={{ fontSize: '0.7rem', color: 'var(--text-muted)' }}>
                Printable summary
              </div>
            </div>
          </button>

          {/* CSV Option */}
          <button
            type="button"
            onClick={() => handleDownload('csv')}
            style={{
              width: '100%',
              display: 'flex',
              alignItems: 'center',
              gap: '0.6rem',
              padding: '0.5rem 0.65rem',
              borderRadius: 'var(--radius-sm)',
              border: 'none',
              background: 'transparent',
              cursor: 'pointer',
              textAlign: 'left',
              transition: 'background-color 0.1s ease',
            }}
            onMouseEnter={(e) => e.currentTarget.style.backgroundColor = 'var(--bg-hover)'}
            onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
          >
            <div style={{
              width: '24px',
              height: '24px',
              borderRadius: '4px',
              backgroundColor: 'var(--bg-hover)',
              color: 'var(--text-secondary)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              flexShrink: 0
            }}>
              <FileText size={14} />
            </div>
            <div style={{ flex: 1 }}>
              <div style={{ fontSize: '0.8rem', fontWeight: 600, color: 'var(--text-primary)' }}>
                CSV Data (.csv)
              </div>
              <div style={{ fontSize: '0.7rem', color: 'var(--text-muted)' }}>
                Raw tabular data
              </div>
            </div>
          </button>

          {onOpenModal && (
            <>
              <div style={{ height: '1px', backgroundColor: 'var(--border-subtle)', margin: '0.3rem 0' }} />
              <button
                type="button"
                onClick={() => {
                  setIsOpen(false);
                  onOpenModal();
                }}
                style={{
                  width: '100%',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.5rem',
                  padding: '0.45rem 0.65rem',
                  borderRadius: 'var(--radius-sm)',
                  border: 'none',
                  background: 'transparent',
                  cursor: 'pointer',
                  textAlign: 'left',
                  fontSize: '0.76rem',
                  fontWeight: 500,
                  color: 'var(--primary)',
                  transition: 'background-color 0.1s ease',
                }}
                onMouseEnter={(e) => e.currentTarget.style.backgroundColor = 'var(--primary-subtle)'}
                onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
              >
                <ExternalLink size={13} />
                <span>Open Export Center...</span>
              </button>
            </>
          )}
        </div>
      )}
    </div>
  );
}
