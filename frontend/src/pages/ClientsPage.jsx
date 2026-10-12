import React, { useState, useMemo, useEffect } from 'react';
import { 
  Users, 
  Search, 
  Plus, 
  Sparkles, 
  ThumbsUp, 
  CalendarPlus, 
  Mail, 
  Phone, 
  Building, 
  Trash2, 
  Edit3, 
  Table as TableIcon, 
  LayoutGrid, 
  Clock, 
  UploadCloud,
  ChevronLeft,
  ChevronRight
} from 'lucide-react';

import confetti from 'canvas-confetti';
import ExportDropdown from '../components/ExportDropdown';

export default function ClientsPage({
  clients,
  onOpenNewClient,
  onEditClient,
  onDeleteClient,
  onPromoteClientToLead,
  onTogglePositive,
  onScheduleFollowupForClient,
  onOpenExportModal,
  onOpenImportModal
}) {
  const [activeFilter, setActiveFilter] = useState('all'); // all, positive, pending_followup
  const [searchQuery, setSearchQuery] = useState('');
  const [viewMode, setViewMode] = useState('table'); // 'table' or 'grid'
  const [page, setPage] = useState(1);
  const [pageSize, setPageSize] = useState(25);

  useEffect(() => {
    setPage(1);
  }, [searchQuery, activeFilter, viewMode]);

  // Only non-converted clients/prospects appear on the Clients page
  const clientProspects = clients.filter(c => !c.is_lead);

  const filteredClients = useMemo(() => {
    return clientProspects.filter(c => {
      // Filters
      if (activeFilter === 'positive' && !c.positive_approach) return false;
      if (activeFilter === 'pending_followup' && !(c.pending_followups > 0)) return false;

      // Search query
      if (searchQuery.trim()) {
        const q = searchQuery.toLowerCase();
        const matchName = c.name?.toLowerCase().includes(q);
        const matchComp = c.company?.toLowerCase().includes(q);
        const matchEmail = c.email?.toLowerCase().includes(q);
        const matchPhone = c.phone?.toLowerCase().includes(q);
        const matchNotes = c.notes?.toLowerCase().includes(q);
        if (!matchName && !matchComp && !matchEmail && !matchPhone && !matchNotes) return false;
      }

      return true;
    });
  }, [clientProspects, activeFilter, searchQuery]);

  const totalPages = Math.ceil(filteredClients.length / pageSize) || 1;
  const paginatedClients = useMemo(() => {
    return filteredClients.slice((page - 1) * pageSize, page * pageSize);
  }, [filteredClients, page, pageSize]);

  const handlePromote = (clientId, e) => {
    if (e) e.stopPropagation();
    confetti({
      particleCount: 80,
      spread: 70,
      origin: { y: 0.6 }
    });
    onPromoteClientToLead(clientId);
  };

  const handleTogglePositive = (clientId, e) => {
    if (e) e.stopPropagation();
    onTogglePositive(clientId);
  };

  return (
    <div>
      {/* Page Header */}
      <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', flexWrap: 'wrap', gap: '1rem', marginBottom: '1.25rem' }}>
        <div>
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
            <h2 style={{ fontSize: '1.25rem', fontWeight: 700, color: 'var(--text-primary)', letterSpacing: '-0.02em' }}>
              Steel Detailing Clients
            </h2>
            <span style={{
              backgroundColor: 'var(--bg-subtle)',
              color: 'var(--text-secondary)',
              border: '1px solid var(--border-subtle)',
              fontSize: '0.72rem',
              fontWeight: 600,
              padding: '0.15rem 0.5rem',
              borderRadius: 'var(--radius-full)'
            }}>
              Outreach & Prospects
            </span>
          </div>
          <p style={{ fontSize: '0.815rem', color: 'var(--text-muted)', marginTop: '0.15rem' }}>
            Track prospective steel fabricators and contractors. Converting a client promotes them to the Leads page.
          </p>
        </div>
        
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', flexWrap: 'wrap' }}>
          {/* Table vs Grid Switcher */}
          <div style={{
            display: 'flex',
            backgroundColor: 'var(--bg-subtle)',
            border: '1px solid var(--border-subtle)',
            borderRadius: 'var(--radius-md)',
            padding: '2px',
          }}>
            <button
              onClick={() => setViewMode('table')}
              style={{
                border: 'none',
                background: viewMode === 'table' ? 'var(--bg-surface)' : 'transparent',
                color: viewMode === 'table' ? 'var(--text-primary)' : 'var(--text-muted)',
                padding: '0.3rem 0.55rem',
                borderRadius: 'var(--radius-sm)',
                cursor: 'pointer',
                display: 'flex',
                alignItems: 'center',
                gap: '0.3rem',
                fontSize: '0.75rem',
                fontWeight: viewMode === 'table' ? 600 : 500,
                boxShadow: viewMode === 'table' ? 'var(--shadow-xs)' : 'none'
              }}
              title="Table view"
            >
              <TableIcon size={14} />
              <span>Table</span>
            </button>
            <button
              onClick={() => setViewMode('grid')}
              style={{
                border: 'none',
                background: viewMode === 'grid' ? 'var(--bg-surface)' : 'transparent',
                color: viewMode === 'grid' ? 'var(--text-primary)' : 'var(--text-muted)',
                padding: '0.3rem 0.55rem',
                borderRadius: 'var(--radius-sm)',
                cursor: 'pointer',
                display: 'flex',
                alignItems: 'center',
                gap: '0.3rem',
                fontSize: '0.75rem',
                fontWeight: viewMode === 'grid' ? 600 : 500,
                boxShadow: viewMode === 'grid' ? 'var(--shadow-xs)' : 'none'
              }}
              title="Cards grid view"
            >
              <LayoutGrid size={14} />
              <span>Cards</span>
            </button>
          </div>

          {/* Import Excel Button for Clients */}
          {onOpenImportModal && (
            <button 
              className="btn btn-secondary" 
              onClick={onOpenImportModal}
              title="Import clients from Excel (.xlsx) or CSV"
            >
              <UploadCloud size={14} />
              <span>Import Excel</span>
            </button>
          )}

          <ExportDropdown onOpenModal={onOpenExportModal} />

          <button className="btn btn-primary" onClick={onOpenNewClient}>
            <Plus size={15} />
            <span>Add Client</span>
          </button>
        </div>
      </div>

      {/* Filter and Search Bar */}
      <div className="card" style={{ padding: '0.65rem 0.85rem', marginBottom: '1.25rem' }}>
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '0.75rem' }}>
          {/* Segmented Filter Pills */}
          <div className="segmented-control">
            <button
              className={`segmented-btn ${activeFilter === 'all' ? 'active' : ''}`}
              onClick={() => setActiveFilter('all')}
            >
              All Clients ({clientProspects.length})
            </button>
            <button
              className={`segmented-btn ${activeFilter === 'positive' ? 'active' : ''}`}
              onClick={() => setActiveFilter('positive')}
            >
              <ThumbsUp size={12} color="#D97706" />
              <span>Positive ({clientProspects.filter(c => c.positive_approach).length})</span>
            </button>
            <button
              className={`segmented-btn ${activeFilter === 'pending_followup' ? 'active' : ''}`}
              onClick={() => setActiveFilter('pending_followup')}
            >
              <Clock size={12} color="var(--primary)" />
              <span>Due Follow-up ({clientProspects.filter(c => c.pending_followups > 0).length})</span>
            </button>
          </div>

          {/* Search Input (No Industry selection required) */}
          <div style={{ position: 'relative', width: '100%', maxWidth: '280px' }}>
            <Search size={14} color="var(--text-muted)" style={{ position: 'absolute', left: '9px', top: '9px' }} />
            <input
              type="text"
              placeholder="Search clients..."
              className="form-input"
              style={{ paddingLeft: '2rem', height: '32px', fontSize: '0.785rem' }}
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
          </div>
        </div>
      </div>

      {filteredClients.length === 0 ? (
        <div className="card" style={{ textAlign: 'center', padding: '3rem 1.5rem', color: 'var(--text-muted)' }}>
          <Users size={36} style={{ margin: '0 auto 0.75rem auto', opacity: 0.3 }} />
          <h3 style={{ fontSize: '1rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '0.25rem' }}>
            {clientProspects.length === 0 ? 'All Prospects Converted to Leads!' : 'No Clients Found'}
          </h3>
          <p style={{ fontSize: '0.8rem', maxWidth: '380px', margin: '0 auto 1.25rem auto' }}>
            {clientProspects.length === 0 
              ? 'Great work! All your clients have been converted into active leads on the Leads page. Add new prospects or import an Excel spreadsheet.'
              : 'No prospective clients match the current search filters.'}
          </p>
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.65rem' }}>
            {onOpenImportModal && (
              <button className="btn btn-secondary" onClick={onOpenImportModal}>
                <UploadCloud size={14} />
                <span>Import from Excel</span>
              </button>
            )}
            <button className="btn btn-primary" onClick={onOpenNewClient}>
              <Plus size={14} />
              <span>Add Client</span>
            </button>
          </div>
        </div>
      ) : viewMode === 'table' ? (
        /* TABLE LIST VIEW */
        <div className="table-responsive">
          <table className="custom-table">
            <thead>
              <tr>
                <th style={{ width: '28%' }}>Fabricator / Company</th>
                <th style={{ width: '14%' }}>Outreach Stage</th>
                <th style={{ width: '15%' }}>Approach Reaction</th>
                <th style={{ width: '18%' }}>Contact Details</th>
                <th style={{ width: '15%' }}>Role & Location</th>
                <th style={{ width: '15%' }}>Convert / Action</th>
              </tr>
            </thead>
            <tbody>
              {paginatedClients.map((c) => {
                const initials = c.name ? c.name.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase() : 'CL';
                return (
                  <tr key={c.id}>
                    {/* Client & Company */}
                    <td>
                      <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
                        <div style={{
                          width: '32px',
                          height: '32px',
                          borderRadius: 'var(--radius-md)',
                          backgroundColor: 'var(--bg-subtle)',
                          color: 'var(--text-secondary)',
                          border: '1px solid var(--border-subtle)',
                          display: 'flex',
                          alignItems: 'center',
                          justifyContent: 'center',
                          fontWeight: 600,
                          fontSize: '0.785rem',
                          flexShrink: 0
                        }}>
                          {initials}
                        </div>
                        <div>
                          <div style={{ fontWeight: 600, color: 'var(--text-primary)', fontSize: '0.85rem' }}>
                            {c.name}
                          </div>
                          <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', color: 'var(--text-muted)', fontSize: '0.75rem', marginTop: '0.1rem' }}>
                            <span>{c.company || 'Fabricator / Contractor'}</span>
                            <span>•</span>
                            <span style={{ color: 'var(--text-secondary)' }}>Steel Detailing</span>
                          </div>
                        </div>
                      </div>
                    </td>

                    {/* Status */}
                    <td>
                      <div>
                        <span className="badge-status badge-prospect">
                          {c.status}
                        </span>
                        {c.pending_followups > 0 && (
                          <div style={{ display: 'flex', alignItems: 'center', gap: '0.25rem', color: 'var(--danger-color)', fontSize: '0.7rem', fontWeight: 500, marginTop: '0.2rem' }}>
                            <span style={{ width: '5px', height: '5px', borderRadius: '50%', backgroundColor: 'var(--danger-btn)' }}></span>
                            <span>{c.pending_followups} follow-up pending</span>
                          </div>
                        )}
                      </div>
                    </td>

                    {/* Positive Approach Toggle Button */}
                    <td>
                      <button
                        onClick={(e) => handleTogglePositive(c.id, e)}
                        className="btn btn-sm"
                        style={{
                          padding: '0.2rem 0.5rem',
                          fontSize: '0.725rem',
                          backgroundColor: c.positive_approach ? 'var(--positive-bg)' : 'transparent',
                          color: c.positive_approach ? 'var(--positive-color)' : 'var(--text-muted)',
                          border: `1px solid ${c.positive_approach ? 'var(--positive-border)' : 'var(--border-subtle)'}`,
                          fontWeight: 500
                        }}
                        title="Click to toggle positive approach reaction"
                      >
                        <ThumbsUp size={11} color={c.positive_approach ? '#D97706' : '#9CA3AF'} />
                        <span>{c.positive_approach ? 'Positive' : 'Standard'}</span>
                      </button>
                    </td>

                    {/* Contact */}
                    <td>
                      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.15rem', fontSize: '0.75rem', color: 'var(--text-secondary)' }}>
                        {c.email ? (
                          <a href={`mailto:${c.email}`} style={{ color: 'inherit', textDecoration: 'none', display: 'flex', alignItems: 'center', gap: '0.3rem' }} title={c.email}>
                            <Mail size={11} color="#9CA3AF" />
                            <span style={{ overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', maxWidth: '160px' }}>{c.email}</span>
                          </a>
                        ) : (
                          <span style={{ color: 'var(--text-muted)' }}>-</span>
                        )}
                        {c.phone && (
                          <div style={{ display: 'flex', alignItems: 'center', gap: '0.3rem', color: 'var(--text-muted)' }}>
                            <Phone size={11} />
                            <span>{c.phone}</span>
                          </div>
                        )}
                      </div>
                    </td>

                    {/* Role & Location (Estimated value is only for leads!) */}
                    <td>
                      <div style={{ fontWeight: 600, color: 'var(--text-primary)', fontSize: '0.825rem' }}>
                        {c.position || 'Client Contact'}
                      </div>
                      <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', marginTop: '0.1rem' }}>
                        {[c.city, c.state].filter(Boolean).join(', ') || c.country || 'Outreach'}
                      </div>
                    </td>

                    {/* Pipeline Action & Row Buttons */}
                    <td>
                      <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
                        {/* 1-Click Convert to Lead */}
                        <button
                          className="btn btn-lead btn-sm"
                          onClick={(e) => handlePromote(c.id, e)}
                          title="Convert this client to Lead (moves to Leads page)"
                          style={{ padding: '0.25rem 0.55rem', fontSize: '0.725rem' }}
                        >
                          <Sparkles size={11} />
                          <span>To Lead</span>
                        </button>

                        <button
                          className="btn btn-secondary btn-sm"
                          onClick={() => onScheduleFollowupForClient(c.id)}
                          title="Schedule follow-up"
                          style={{ padding: '0.25rem 0.4rem' }}
                        >
                          <CalendarPlus size={12} />
                        </button>

                        <button
                          className="btn btn-secondary btn-sm"
                          onClick={() => onEditClient(c)}
                          title="Edit client"
                          style={{ padding: '0.25rem 0.4rem' }}
                        >
                          <Edit3 size={12} />
                        </button>

                        <button
                          className="btn btn-danger btn-sm"
                          onClick={() => onDeleteClient(c.id)}
                          title="Delete client"
                          style={{ padding: '0.25rem 0.4rem' }}
                        >
                          <Trash2 size={12} />
                        </button>
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      ) : (
        /* CARDS GRID VIEW */
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(320px, 1fr))', gap: '1rem' }}>
          {paginatedClients.map((c) => (
            <div
              key={c.id}
              className="card"
              style={{
                display: 'flex',
                flexDirection: 'column',
                border: '1px solid var(--border-subtle)',
                backgroundColor: 'var(--bg-surface)'
              }}
            >
              <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', marginBottom: '0.65rem' }}>
                <div>
                  <h3 style={{ fontSize: '0.95rem', fontWeight: 700, color: 'var(--text-primary)' }}>
                    {c.name}
                  </h3>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', color: 'var(--text-muted)', fontSize: '0.785rem', marginTop: '0.1rem' }}>
                    <Building size={12} />
                    <span>{c.company || 'Fabricator / Contractor'}</span>
                  </div>
                </div>

                <span className="badge-status badge-prospect">
                  {c.status}
                </span>
              </div>

              {/* Reaction bar */}
              <div style={{
                backgroundColor: c.positive_approach ? 'var(--positive-bg)' : 'var(--bg-subtle)',
                border: `1px solid ${c.positive_approach ? 'var(--positive-border)' : 'var(--border-light)'}`,
                borderRadius: 'var(--radius-sm)',
                padding: '0.4rem 0.6rem',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
                marginBottom: '0.65rem'
              }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
                  <ThumbsUp size={12} color={c.positive_approach ? '#D97706' : '#9CA3AF'} />
                  <span style={{ fontSize: '0.725rem', fontWeight: 500, color: c.positive_approach ? 'var(--positive-color)' : 'var(--text-muted)' }}>
                    {c.positive_approach ? 'Positive Approach' : 'Standard Response'}
                  </span>
                </div>
                <button
                  className="btn btn-secondary btn-sm"
                  onClick={(e) => handleTogglePositive(c.id, e)}
                  style={{ fontSize: '0.68rem', padding: '0.15rem 0.35rem' }}
                >
                  {c.positive_approach ? 'Clear' : 'Mark Positive'}
                </button>
              </div>

              {/* Contact info */}
              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.25rem', marginBottom: '0.65rem', fontSize: '0.75rem', color: 'var(--text-secondary)' }}>
                {c.email && (
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
                    <Mail size={12} color="#9CA3AF" />
                    <span>{c.email}</span>
                  </div>
                )}
                {c.phone && (
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
                    <Phone size={12} color="#9CA3AF" />
                    <span>{c.phone}</span>
                  </div>
                )}
                {c.position && (
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', color: 'var(--text-secondary)' }}>
                    <Building size={12} color="#9CA3AF" />
                    <span>{c.position}</span>
                  </div>
                )}
                {(c.city || c.state || c.country) && (
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', color: 'var(--text-muted)', fontSize: '0.72rem' }}>
                    <span>📍 {[c.city, c.state, c.country].filter(Boolean).join(', ')}</span>
                  </div>
                )}
              </div>

              {/* Card Footer Actions */}
              <div style={{ marginTop: 'auto', display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: '0.4rem', borderTop: '1px solid var(--border-light)', paddingTop: '0.65rem' }}>
                <button
                  className="btn btn-lead btn-sm"
                  onClick={(e) => handlePromote(c.id, e)}
                  style={{ flex: 1 }}
                  title="Promote to lead (moves client to Leads page)"
                >
                  <Sparkles size={12} />
                  <span>Convert to Lead</span>
                </button>

                <button
                  className="btn btn-secondary btn-sm"
                  onClick={() => onScheduleFollowupForClient(c.id)}
                  title="Schedule follow-up"
                >
                  <CalendarPlus size={12} />
                </button>

                <button
                  className="btn btn-secondary btn-sm"
                  onClick={() => onEditClient(c)}
                  title="Edit client"
                >
                  <Edit3 size={12} />
                </button>

                <button
                  className="btn btn-danger btn-sm"
                  onClick={() => onDeleteClient(c.id)}
                  title="Delete client"
                >
                  <Trash2 size={12} />
                </button>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Pagination Controls */}
      {filteredClients.length > 0 && (
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
            Showing <strong>{((page - 1) * pageSize) + 1}</strong>–<strong>{Math.min(page * pageSize, filteredClients.length)}</strong> of <strong>{filteredClients.length.toLocaleString()}</strong> clients
          </div>

          <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', flexWrap: 'wrap' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', fontSize: '0.75rem', color: 'var(--text-muted)' }}>
              <span>Per page:</span>
              <select
                value={pageSize}
                onChange={(e) => { setPageSize(Number(e.target.value)); setPage(1); }}
                className="form-select"
                style={{ fontSize: '0.75rem', height: '30px', padding: '0.1rem 0.5rem' }}
              >
                <option value={25}>25</option>
                <option value={50}>50</option>
                <option value={100}>100</option>
              </select>
            </div>

            <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
              <button
                className="btn btn-secondary btn-sm"
                disabled={page <= 1}
                onClick={() => setPage(p => Math.max(1, p - 1))}
                style={{ fontSize: '0.75rem', height: '30px', padding: '0 0.65rem', display: 'flex', alignItems: 'center', gap: '0.25rem' }}
              >
                <ChevronLeft size={13} />
                <span>Prev</span>
              </button>

              <span style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--text-primary)', padding: '0 0.5rem' }}>
                Page {page} of {totalPages}
              </span>

              <button
                className="btn btn-secondary btn-sm"
                disabled={page >= totalPages}
                onClick={() => setPage(p => Math.min(totalPages, p + 1))}
                style={{ fontSize: '0.75rem', height: '30px', padding: '0 0.65rem', display: 'flex', alignItems: 'center', gap: '0.25rem' }}
              >
                <span>Next</span>
                <ChevronRight size={13} />
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
