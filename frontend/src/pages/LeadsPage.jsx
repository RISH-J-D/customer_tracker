import React, { useState, useMemo, useEffect } from 'react';
import { 
  Target, 
  Search, 
  Plus, 
  ThumbsUp, 
  CalendarPlus, 
  Mail, 
  Phone, 
  MapPin,
  Building, 
  Trash2, 
  Edit3, 
  DollarSign,
  Table as TableIcon,
  LayoutGrid,
  CheckCircle2,
  Clock,
  UploadCloud,
  RotateCcw,
  ChevronLeft,
  ChevronRight,
  Handshake,
  CalendarDays
} from 'lucide-react';
import ExportDropdown from '../components/ExportDropdown';
import FollowupTimelineCell from '../components/FollowupTimelineCell';
import NotesCell from '../components/NotesCell';
import { splitPhoneNumbers } from '../components/phoneUtils';
import LeadCalendarModal from '../components/LeadCalendarModal';

export default function LeadsPage({
  leads,
  onOpenNewLead,
  onEditLead,
  onDeleteLead,
  onTogglePositive,
  onToggleAccount,
  onScheduleFollowupForLead,
  onRevertToClient,
  onOpenExportModal,
  onOpenImportModal,
  onUpdateNotes,
  onAddNote,
  onEditNote,
  onDeleteNote
}) {
  const [activeFilter, setActiveFilter] = useState('all'); // all, positive, pending_followup
  const [searchQuery, setSearchQuery] = useState('');
  const [viewMode, setViewMode] = useState('table'); // 'table' or 'grid'
  const [calendarLeadId, setCalendarLeadId] = useState(null);
  const calendarLead = calendarLeadId ? leads.find(l => l.id === calendarLeadId) : null;
  const openCalendarProps = (lead) => ({
    className: 'lead-open-calendar',
    role: 'button',
    tabIndex: 0,
    title: 'Click to view this lead\'s follow-up calendar',
    onClick: () => setCalendarLeadId(lead.id),
    onKeyDown: (e) => { if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); setCalendarLeadId(lead.id); } }
  });
  const [page, setPage] = useState(1);
  const [pageSize, setPageSize] = useState(25);

  useEffect(() => {
    setPage(1);
  }, [searchQuery, activeFilter, viewMode]);

  const filteredLeads = leads.filter(c => {
    // Only leads belong on this page
    if (!c.is_lead) return false;

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
      const matchNotes = c.notes?.toLowerCase().includes(q) || (c.note_entries || []).some(n => n.content?.toLowerCase().includes(q));
      if (!matchName && !matchComp && !matchEmail && !matchPhone && !matchNotes) return false;
    }

    return true;
  });

  const positiveLeadCount = leads.filter(c => c.is_lead && c.positive_approach).length;

  const totalPages = Math.ceil(filteredLeads.length / pageSize) || 1;
  const paginatedLeads = useMemo(() => {
    return filteredLeads.slice((page - 1) * pageSize, page * pageSize);
  }, [filteredLeads, page, pageSize]);

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

          {/* Import Excel Button for Leads */}
          {onOpenImportModal && (
            <button 
              className="btn btn-secondary" 
              onClick={onOpenImportModal}
              title="Import leads from Excel spreadsheet"
            >
              <UploadCloud size={14} />
              <span>Import Excel</span>
            </button>
          )}

          <ExportDropdown onOpenModal={onOpenExportModal} />

          <button className="btn btn-lead" onClick={onOpenNewLead}>
            <Plus size={15} />
            <span>Add Lead</span>
          </button>
        </div>
      </div>

      {/* Leads Summary KPI Cards */}
      <div className="kpi-grid" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(210px, 1fr))', gap: '0.85rem', marginBottom: '1.25rem' }}>
        <div className="card" style={{ padding: '0.85rem 1rem' }}>
          <div style={{ fontSize: '0.78rem', color: 'var(--text-secondary)', fontWeight: 500 }}>
            Active leads
          </div>
          <div className="stat-value" style={{ fontSize: '1.4rem', marginTop: '0.2rem' }}>
            {leads.filter(c => c.is_lead).length}
          </div>
          <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', marginTop: '0.15rem' }}>
            Converted from clients
          </div>
        </div>

        <div className="card" style={{ padding: '0.85rem 1rem' }}>
          <div style={{ fontSize: '0.78rem', color: 'var(--text-secondary)', fontWeight: 500 }}>
            Positive responses
          </div>
          <div className="stat-value" style={{ fontSize: '1.4rem', marginTop: '0.2rem' }}>
            {positiveLeadCount}
          </div>
          <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', marginTop: '0.15rem' }}>
            Leads marked positive
          </div>
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
              <Target size={12} color="var(--lead-action)" />
              <span>All Leads ({leads.filter(c => c.is_lead).length})</span>
            </button>
            <button
              className={`segmented-btn ${activeFilter === 'positive' ? 'active' : ''}`}
              onClick={() => setActiveFilter('positive')}
            >
              <ThumbsUp size={12} color="var(--warning-strong)" />
              <span>Positive ({leads.filter(c => c.is_lead && c.positive_approach).length})</span>
            </button>
            <button
              className={`segmented-btn ${activeFilter === 'pending_followup' ? 'active' : ''}`}
              onClick={() => setActiveFilter('pending_followup')}
            >
              <Clock size={12} color="var(--primary)" />
              <span>Due Follow-up ({leads.filter(c => c.is_lead && c.pending_followups > 0).length})</span>
            </button>
          </div>

          {/* Search Input (No Industry selection required) */}
          <div className="search-box" style={{ position: 'relative', width: '100%', maxWidth: '280px' }}>
            <Search size={14} color="var(--text-muted)" style={{ position: 'absolute', left: '9px', top: '9px' }} />
            <input
              type="text"
              placeholder="Search leads by name, company, notes..."
              className="form-input"
              style={{ paddingLeft: '2rem', height: '32px', fontSize: '0.785rem' }}
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
          </div>
        </div>
      </div>

      {filteredLeads.length === 0 ? (
        <div className="card" style={{ textAlign: 'center', padding: '3.5rem 1.5rem', color: 'var(--text-muted)' }}>
          <Target size={38} color="var(--lead-action)" style={{ margin: '0 auto 0.75rem auto', opacity: 0.5 }} />
          <h3 style={{ fontSize: '1rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '0.25rem' }}>
            No Leads Found
          </h3>
          <p style={{ fontSize: '0.8rem', maxWidth: '420px', margin: '0 auto 1.25rem auto' }}>
            When clients demonstrate positive interest and you click <strong>"Convert to Lead"</strong> on the Clients page, they will automatically appear here! You can also import existing leads directly from Excel.
          </p>
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.65rem' }}>
            {onOpenImportModal && (
              <button className="btn btn-secondary" onClick={onOpenImportModal}>
                <UploadCloud size={14} />
                <span>Import Leads from Excel</span>
              </button>
            )}
            <button className="btn btn-lead" onClick={onOpenNewLead}>
              <Plus size={14} />
              <span>Add Qualified Lead</span>
            </button>
          </div>
        </div>
      ) : viewMode === 'table' ? (
        /* TABLE LIST VIEW */
        <div className="table-responsive table-mobile-cards">
          <table className="custom-table">
            <thead>
              <tr>
                <th style={{ width: '18%' }}>Lead & Fabricator / Client</th>
                <th style={{ width: '13%' }}>Email</th>
                <th style={{ width: '10%' }}>Mobile</th>
                <th style={{ width: '11%' }}>Address</th>
                <th style={{ width: '20%' }}>Follow-ups</th>
                <th style={{ width: '19%' }}>Notes</th>
                <th style={{ width: '1%' }}>Actions</th>
              </tr>
            </thead>
            <tbody>
              {paginatedLeads.map((c) => {
                const initials = c.name ? c.name.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase() : 'LD';
                return (
                  <tr key={c.id} className={c.account_converted_at ? 'row-account-converted' : undefined}>
                    {/* Lead Name & Company */}
                    <td className="td-name">
                      <div {...openCalendarProps(c)} style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
                        <div style={{
                          width: '32px',
                          height: '32px',
                          borderRadius: 'var(--radius-md)',
                          backgroundColor: 'var(--lead-bg)',
                          color: 'var(--lead-color)',
                          border: '1px solid var(--lead-border)',
                          display: 'flex',
                          alignItems: 'center',
                          justifyContent: 'center',
                          fontWeight: 700,
                          fontSize: '0.785rem',
                          flexShrink: 0
                        }}>
                          {initials}
                        </div>
                        <div>
                          <div style={{ fontWeight: 600, color: 'var(--text-primary)', fontSize: '0.85rem', display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
                            <span className="lead-name-text">{c.name}</span>
                            <CalendarDays size={13} color="var(--text-muted)" style={{ flexShrink: 0 }} />
                          </div>
                          <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', color: 'var(--text-muted)', fontSize: '0.75rem', marginTop: '0.1rem', flexWrap: 'wrap' }}>
                            <span>{c.company || 'Fabricator / Contractor'}</span>
                            {c.position && <span>• <strong style={{ fontWeight: 500, color: 'var(--text-secondary)' }}>{c.position}</strong></span>}
                          </div>
                        </div>
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

                    {/* Follow-ups (calendar grouped) */}
                    <td className="td-stack" data-label="Follow-ups">
                      <FollowupTimelineCell
                        client={c}
                      />
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

                    {/* Actions */}
                    <td className="td-actions" data-label="Actions">
                      <div className="row-actions">
                        {onToggleAccount && (
                          <button
                            className={`btn btn-secondary btn-sm row-action-btn btn-account-toggle${c.account_converted_at ? ' is-converted' : ''}`}
                            onClick={() => onToggleAccount(c.id)}
                            title={c.account_converted_at
                              ? `Converted to account on ${new Date(c.account_converted_at + 'Z').toLocaleDateString()} — click to undo`
                              : 'Mark as converted to account (highlights the row green)'}
                            aria-pressed={Boolean(c.account_converted_at)}
                          >
                            <Handshake size={15} />
                          </button>
                        )}
                        <button
                          className="btn btn-secondary btn-sm row-action-btn"
                          onClick={() => onScheduleFollowupForLead(c.id)}
                          title="Schedule steel detailing meetup or follow-up"
                        >
                          <CalendarPlus size={15} />
                        </button>

                        <button
                          className="btn btn-secondary btn-sm row-action-btn"
                          onClick={() => onEditLead(c)}
                          title="Edit lead details"
                        >
                          <Edit3 size={15} />
                        </button>

                        {onRevertToClient && (
                          <button
                            className="btn btn-secondary btn-sm row-action-btn"
                            onClick={() => onRevertToClient(c.id)}
                            title="Revert lead back to regular prospect client"
                            style={{ padding: '0.25rem 0.4rem' }}
                          >
                            <RotateCcw size={15} />
                          </button>
                        )}

                        <button
                          className="btn btn-danger btn-sm row-action-btn"
                          onClick={() => onDeleteLead(c.id)}
                          title="Delete lead record"
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
          {paginatedLeads.map((c) => (
            <div
              key={c.id}
              className={`card${c.account_converted_at ? ' card-account-converted' : ''}`}
              style={{
                display: 'flex',
                flexDirection: 'column',
                border: '1px solid var(--lead-border)',
                backgroundColor: c.account_converted_at ? 'var(--account-row-bg)' : 'var(--bg-surface)'
              }}
            >
              <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', marginBottom: '0.65rem' }}>
                <div>
                  <h3 {...openCalendarProps(c)} style={{ fontSize: '0.95rem', fontWeight: 700, color: 'var(--text-primary)', display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
                    <span className="lead-name-text">{c.name}</span>
                    <CalendarDays size={14} color="var(--text-muted)" style={{ flexShrink: 0 }} />
                  </h3>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', color: 'var(--text-muted)', fontSize: '0.785rem', marginTop: '0.1rem' }}>
                    <Building size={12} />
                    <span>{c.company || 'Fabricator / Contractor'}</span>
                  </div>
                </div>

                <span className="badge-status badge-lead">
                  <CheckCircle2 size={11} />
                  <span>Lead</span>
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
                    {c.positive_approach ? 'Positive Response' : 'Standard Response'}
                  </span>
                </div>
                <button
                  className="btn btn-secondary btn-sm"
                  onClick={() => onTogglePositive(c.id)}
                  style={{ fontSize: '0.68rem', padding: '0.15rem 0.35rem' }}
                >
                  {c.positive_approach ? 'Clear' : 'Mark Positive'}
                </button>
              </div>

              {/* Contact info & Deal Value */}
              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.25rem', marginBottom: '0.65rem', fontSize: '0.75rem', color: 'var(--text-secondary)' }}>
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
                <div style={{ marginTop: '0.4rem', paddingTop: '0.4rem', borderTop: '1px solid var(--border-light)' }}>
                  <FollowupTimelineCell
                    client={c}
                  />
                </div>
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
                {onToggleAccount && (
                  <button
                    className={`btn btn-secondary btn-sm btn-account-toggle${c.account_converted_at ? ' is-converted' : ''}`}
                    onClick={() => onToggleAccount(c.id)}
                    title={c.account_converted_at
                      ? `Converted to account on ${new Date(c.account_converted_at + 'Z').toLocaleDateString()} — click to undo`
                      : 'Mark as converted to account (highlights the row green)'}
                    aria-pressed={Boolean(c.account_converted_at)}
                  >
                    <Handshake size={12} />
                  </button>
                )}
                <button
                  className="btn btn-secondary btn-sm"
                  onClick={() => onScheduleFollowupForLead(c.id)}
                  style={{ flex: 1 }}
                >
                  <CalendarPlus size={12} />
                  <span>Schedule</span>
                </button>

                <button
                  className="btn btn-secondary btn-sm"
                  onClick={() => onEditLead(c)}
                  title="Edit lead"
                >
                  <Edit3 size={12} />
                </button>

                {onRevertToClient && (
                  <button
                    className="btn btn-secondary btn-sm"
                    onClick={() => onRevertToClient(c.id)}
                    title="Revert back to prospect"
                  >
                    <RotateCcw size={12} />
                  </button>
                )}

                <button
                  className="btn btn-danger btn-sm"
                  onClick={() => onDeleteLead(c.id)}
                  title="Delete lead"
                >
                  <Trash2 size={12} />
                </button>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Pagination Controls */}
      {filteredLeads.length > 0 && (
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
            Showing <strong>{((page - 1) * pageSize) + 1}</strong>–<strong>{Math.min(page * pageSize, filteredLeads.length)}</strong> of <strong>{filteredLeads.length.toLocaleString()}</strong> leads
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

      {calendarLead && (
        <LeadCalendarModal lead={calendarLead} onClose={() => setCalendarLeadId(null)} />
      )}
    </div>
  );
}
