import React, { useState, useMemo, useEffect } from 'react';
import { 
  Users, 
  Search, 
  Plus, 
  Target, 
  ThumbsUp, 
  Mail, 
  Phone, 
  MapPin,
  Building, 
  Trash2, 
  Edit3, 
  Table as TableIcon, 
  LayoutGrid, 
  UploadCloud,
  ChevronLeft,
  ChevronRight
} from 'lucide-react';

import ExportDropdown from '../components/ExportDropdown';
import NotesCell from '../components/NotesCell';
import { splitPhoneNumbers } from '../components/phoneUtils';

// Imported rows without a named contact were saved as "<Company> Contact"
const getRepresentativeName = (c) => (c.name && c.name !== `${c.company} Contact` ? c.name : null);

export default function ClientsPage({
  clients,
  onOpenNewClient,
  onEditClient,
  onDeleteClient,
  onPromoteClientToLead,
  onTogglePositive,
  onOpenExportModal,
  onOpenImportModal,
  onUpdateNotes,
  onAddNote,
  onEditNote,
  onDeleteNote
}) {
  const [activeFilter, setActiveFilter] = useState('all'); // all, positive
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

      // Search query
      if (searchQuery.trim()) {
        const q = searchQuery.toLowerCase();
        const matchName = c.name?.toLowerCase().includes(q);
        const matchComp = c.company?.toLowerCase().includes(q);
        const matchEmail = c.email?.toLowerCase().includes(q);
        const matchPhone = c.phone?.toLowerCase().includes(q);
        const matchNotes = c.notes?.toLowerCase().includes(q) || (c.note_entries || []).some(n => n.content?.toLowerCase().includes(q));
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
    onPromoteClientToLead(clientId);
  };

  const handleTogglePositive = (clientId, e) => {
    if (e) e.stopPropagation();
    onTogglePositive(clientId);
  };

  return (
    <div>
      {/* Page Header */}
      <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'flex-end', flexWrap: 'wrap', gap: '1rem', marginBottom: '1.25rem' }}>
        
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
              <ThumbsUp size={12} color="var(--warning-strong)" />
              <span>Positive ({clientProspects.filter(c => c.positive_approach).length})</span>
            </button>
          </div>

          {/* Search Input (No Industry selection required) */}
          <div className="search-box" style={{ position: 'relative', width: '100%', maxWidth: '280px' }}>
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
        <div className="table-responsive table-mobile-cards">
          <table className="custom-table">
            <thead>
              <tr>
                <th style={{ width: '20%' }}>Fabricator / Company</th>
                <th style={{ width: '15%' }}>Client Representative</th>
                <th style={{ width: '14%' }}>Email</th>
                <th style={{ width: '11%' }}>Mobile</th>
                <th style={{ width: '13%' }}>Address</th>
                <th style={{ width: '26%' }}>Notes</th>
                <th style={{ width: '1%' }}>Convert / Action</th>
              </tr>
            </thead>
            <tbody>
              {paginatedClients.map((c) => {
                const companyName = c.company || c.name;
                const initials = companyName ? companyName.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase() : 'CL';
                const repName = getRepresentativeName(c);
                return (
                  <tr key={c.id}>
                    {/* Client & Company */}
                    <td className="td-name">
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
                        <div style={{ fontWeight: 600, color: 'var(--text-primary)', fontSize: '0.85rem' }}>
                          {companyName}
                        </div>
                      </div>
                    </td>

                    {/* Client Representative */}
                    <td className="td-rep" data-label="Representative">
                      <div style={{ fontSize: '0.8rem' }}>
                        {repName ? (
                          <>
                            <div style={{ fontWeight: 600, color: 'var(--text-primary)' }}>{repName}</div>
                            {c.position && (
                              <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', marginTop: '0.1rem' }}>{c.position}</div>
                            )}
                          </>
                        ) : (
                          <span style={{ color: 'var(--text-muted)' }}>{c.position || '-'}</span>
                        )}
                      </div>
                    </td>

                    {/* Email */}
                    <td className="td-email" data-label="Email">
                      <div style={{ fontSize: '0.75rem', color: 'var(--text-secondary)' }}>
                        {c.email ? (
                          <a href={`mailto:${c.email}`} style={{ color: 'inherit', textDecoration: 'none', display: 'flex', alignItems: 'flex-start', gap: '0.3rem' }} title={c.email}>
                            <Mail size={11} color="var(--text-placeholder)" style={{ flexShrink: 0, marginTop: '0.15rem' }} />
                            <span style={{ wordBreak: 'break-all', minWidth: 0 }}>{c.email}</span>
                          </a>
                        ) : (
                          <span style={{ color: 'var(--text-muted)' }}>-</span>
                        )}
                      </div>
                    </td>

                    {/* Mobile */}
                    <td className="td-mobile" data-label="Mobile">
                      <div style={{ fontSize: '0.75rem', color: 'var(--text-secondary)' }}>
                        {c.phone ? (
                          <a href={`tel:${c.phone}`} style={{ color: 'inherit', textDecoration: 'none', display: 'flex', alignItems: 'flex-start', gap: '0.3rem' }}>
                            <Phone size={11} color="var(--text-placeholder)" style={{ marginTop: '0.15rem', flexShrink: 0 }} />
                            <span style={{ display: 'flex', flexDirection: 'column', minWidth: 0 }}>
                              {splitPhoneNumbers(c.phone).map((num, i) => (
                                <span key={i}>{num}</span>
                              ))}
                            </span>
                          </a>
                        ) : (
                          <span style={{ color: 'var(--text-muted)' }}>-</span>
                        )}
                      </div>
                    </td>

                    {/* Address */}
                    <td className="td-address" data-label="Address">
                      <div style={{ display: 'flex', alignItems: 'flex-start', gap: '0.3rem', fontSize: '0.75rem', color: 'var(--text-secondary)' }}>
                        {(c.city || c.state || c.country) ? (
                          <>
                            <MapPin size={11} color="var(--text-placeholder)" style={{ marginTop: '0.15rem', flexShrink: 0 }} />
                            <span>{[c.city, c.state, c.country].filter(Boolean).join(', ')}</span>
                          </>
                        ) : (
                          <span style={{ color: 'var(--text-muted)' }}>-</span>
                        )}
                      </div>
                    </td>

                    {/* Notes (calendar grouped) */}
                    <td className="td-stack" data-label="Notes">
                      <NotesCell
                        client={c}
                        onAddNote={onAddNote}
                        onEditNote={onEditNote}
                        onDeleteNote={onDeleteNote}
                        onUpdateNotes={onUpdateNotes}
                      />
                    </td>

                    {/* Pipeline Action & Row Buttons */}
                    <td className="td-actions" data-label="Actions">
                      <div className="row-actions">
                        {/* 1-Click Convert to Lead */}
                        <button
                          className="btn btn-lead btn-sm row-action-wide"
                          onClick={(e) => handlePromote(c.id, e)}
                          title="Convert this client to Lead (moves to Leads page)"
                        >
                          <Target size={13} />
                          <span>To Lead</span>
                        </button>

                        <button
                          className="btn btn-secondary btn-sm row-action-btn"
                          onClick={() => onEditClient(c)}
                          title="Edit client"
                        >
                          <Edit3 size={15} />
                        </button>

                        <button
                          className="btn btn-danger btn-sm row-action-btn"
                          onClick={() => onDeleteClient(c.id)}
                          title="Delete client"
                        >
                          <Trash2 size={15} />
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
                    {c.company || c.name}
                  </h3>
                  {getRepresentativeName(c) && (
                    <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', color: 'var(--text-secondary)', fontSize: '0.785rem', marginTop: '0.1rem' }}>
                      <Users size={12} />
                      <span>{getRepresentativeName(c)}</span>
                    </div>
                  )}
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
                  <ThumbsUp size={12} color={c.positive_approach ? 'var(--warning-strong)' : 'var(--text-placeholder)'} />
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
                    <Mail size={12} color="var(--text-placeholder)" />
                    <span>{c.email}</span>
                  </div>
                )}
                {c.phone && (
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
                    <Phone size={12} color="var(--text-placeholder)" />
                    <span>{c.phone}</span>
                  </div>
                )}
                {c.position && (
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', color: 'var(--text-secondary)' }}>
                    <Building size={12} color="var(--text-placeholder)" />
                    <span>{c.position}</span>
                  </div>
                )}
                {(c.city || c.state || c.country) && (
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', color: 'var(--text-muted)', fontSize: '0.72rem' }}>
                    <span><MapPin size={11} style={{ verticalAlign: '-1px', marginRight: '3px' }} />{[c.city, c.state, c.country].filter(Boolean).join(', ')}</span>
                  </div>
                )}
                <div style={{ marginTop: '0.4rem', paddingTop: '0.4rem', borderTop: '1px solid var(--border-light)' }}>
                  <NotesCell
                    client={c}
                    onAddNote={onAddNote}
                    onEditNote={onEditNote}
                    onDeleteNote={onDeleteNote}
                    onUpdateNotes={onUpdateNotes}
                  />
                </div>
              </div>

              {/* Card Footer Actions */}
              <div style={{ marginTop: 'auto', display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: '0.4rem', borderTop: '1px solid var(--border-light)', paddingTop: '0.65rem' }}>
                <button
                  className="btn btn-lead btn-sm"
                  onClick={(e) => handlePromote(c.id, e)}
                  style={{ flex: 1 }}
                  title="Promote to lead (moves client to Leads page)"
                >
                  <Target size={12} />
                  <span>Convert to Lead</span>
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
