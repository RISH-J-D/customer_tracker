import React, { useState } from 'react';
import { 
  Sparkles, 
  Search, 
  Plus, 
  ThumbsUp, 
  CalendarPlus, 
  Mail, 
  Phone, 
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
  Building2
} from 'lucide-react';
import ExportDropdown from '../components/ExportDropdown';

export default function LeadsPage({
  leads,
  onOpenNewLead,
  onEditLead,
  onDeleteLead,
  onTogglePositive,
  onScheduleFollowupForLead,
  onRevertToClient,
  onConvertToAccount,
  onOpenExportModal,
  onOpenImportModal
}) {
  const [activeFilter, setActiveFilter] = useState('all'); // all, positive, pending_followup
  const [searchQuery, setSearchQuery] = useState('');
  const [viewMode, setViewMode] = useState('table'); // 'table' or 'grid'

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
      const matchNotes = c.notes?.toLowerCase().includes(q);
      if (!matchName && !matchComp && !matchEmail && !matchPhone && !matchNotes) return false;
    }

    return true;
  });

  const totalLeadValue = leads.filter(c => c.is_lead).reduce((acc, c) => acc + (c.deal_value || 0), 0);
  const positiveLeadCount = leads.filter(c => c.is_lead && c.positive_approach).length;

  return (
    <div>
      {/* Page Header */}
      <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', flexWrap: 'wrap', gap: '1rem', marginBottom: '1.25rem' }}>
        <div>
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
            <h2 style={{ fontSize: '1.25rem', fontWeight: 700, color: 'var(--text-primary)', letterSpacing: '-0.02em' }}>
              Qualified Leads
            </h2>
            <span style={{
              backgroundColor: 'var(--lead-bg)',
              color: 'var(--lead-color)',
              border: '1px solid var(--lead-border)',
              fontSize: '0.72rem',
              fontWeight: 700,
              padding: '0.15rem 0.5rem',
              borderRadius: 'var(--radius-full)'
            }}>
              Steel Detailing
            </span>
          </div>
          <p style={{ fontSize: '0.815rem', color: 'var(--text-muted)', marginTop: '0.15rem' }}>
            Converted prospects ready for steel detailing contracts, structural takeoffs, and project execution.
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
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(210px, 1fr))', gap: '0.85rem', marginBottom: '1.25rem' }}>
        <div className="card" style={{ padding: '0.85rem 1rem' }}>
          <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', fontWeight: 600, textTransform: 'uppercase' }}>
            Active Leads
          </div>
          <div style={{ fontSize: '1.4rem', fontWeight: 800, color: 'var(--lead-color)', marginTop: '0.2rem' }}>
            {leads.filter(c => c.is_lead).length}
          </div>
          <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', marginTop: '0.15rem' }}>
            Qualified steel detailing clients
          </div>
        </div>

        <div className="card" style={{ padding: '0.85rem 1rem' }}>
          <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', fontWeight: 600, textTransform: 'uppercase' }}>
            Pipeline Deal Value
          </div>
          <div style={{ fontSize: '1.4rem', fontWeight: 800, color: 'var(--text-primary)', marginTop: '0.2rem' }}>
            ${totalLeadValue.toLocaleString()}
          </div>
          <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', marginTop: '0.15rem' }}>
            Estimated detailing quotes
          </div>
        </div>

        <div className="card" style={{ padding: '0.85rem 1rem' }}>
          <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', fontWeight: 600, textTransform: 'uppercase' }}>
            Positive Reactions
          </div>
          <div style={{ fontSize: '1.4rem', fontWeight: 800, color: '#D97706', marginTop: '0.2rem' }}>
            {positiveLeadCount}
          </div>
          <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', marginTop: '0.15rem' }}>
            Enthusiastic responses
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
              <Sparkles size={12} color="#059669" />
              <span>All Leads ({leads.filter(c => c.is_lead).length})</span>
            </button>
            <button
              className={`segmented-btn ${activeFilter === 'positive' ? 'active' : ''}`}
              onClick={() => setActiveFilter('positive')}
            >
              <ThumbsUp size={12} color="#D97706" />
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
          <div style={{ position: 'relative', width: '100%', maxWidth: '280px' }}>
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
          <Sparkles size={38} color="#059669" style={{ margin: '0 auto 0.75rem auto', opacity: 0.5 }} />
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
        <div className="table-responsive">
          <table className="custom-table">
            <thead>
              <tr>
                <th style={{ width: '28%' }}>Lead & Fabricator / Client</th>
                <th style={{ width: '15%' }}>Conversion & Status</th>
                <th style={{ width: '14%' }}>Positive Interest</th>
                <th style={{ width: '18%' }}>Contact Details</th>
                <th style={{ width: '12%' }}>Est. Detailing Value</th>
                <th style={{ width: '13%' }}>Actions</th>
              </tr>
            </thead>
            <tbody>
              {filteredLeads.map((c) => {
                const initials = c.name ? c.name.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase() : 'LD';
                return (
                  <tr key={c.id}>
                    {/* Lead Name & Company */}
                    <td>
                      <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
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
                          <div style={{ fontWeight: 600, color: 'var(--text-primary)', fontSize: '0.85rem' }}>
                            {c.name}
                          </div>
                          <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', color: 'var(--text-muted)', fontSize: '0.75rem', marginTop: '0.1rem' }}>
                            <span>{c.company || 'Fabricator / Contractor'}</span>
                            <span>•</span>
                            <span style={{ color: 'var(--lead-color)', fontWeight: 500 }}>Steel Detailing</span>
                          </div>
                        </div>
                      </div>
                    </td>

                    {/* Status & Converted Badge */}
                    <td>
                      <div>
                        <span className="badge-status badge-lead">
                          <CheckCircle2 size={11} />
                          <span>Active Lead</span>
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
                        onClick={() => onTogglePositive(c.id)}
                        className="btn btn-sm"
                        style={{
                          padding: '0.2rem 0.5rem',
                          fontSize: '0.725rem',
                          backgroundColor: c.positive_approach ? 'var(--positive-bg)' : 'transparent',
                          color: c.positive_approach ? 'var(--positive-color)' : 'var(--text-muted)',
                          border: `1px solid ${c.positive_approach ? 'var(--positive-border)' : 'var(--border-subtle)'}`,
                          fontWeight: 500
                        }}
                        title="Click to toggle positive response"
                      >
                        <ThumbsUp size={11} color={c.positive_approach ? '#D97706' : '#9CA3AF'} />
                        <span>{c.positive_approach ? 'Positive' : 'Standard'}</span>
                      </button>
                    </td>

                    {/* Contact */}
                    <td>
                      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.15rem', fontSize: '0.75rem', color: 'var(--text-secondary)' }}>
                        {c.email ? (
                          <a href={`mailto:${c.email}`} style={{ color: 'inherit', textDecoration: 'none', display: 'flex', alignItems: 'center', gap: '0.3rem' }}>
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

                    {/* Deal Value */}
                    <td>
                      <div style={{ fontWeight: 700, color: c.deal_value > 0 ? 'var(--lead-color)' : 'var(--text-muted)', fontSize: '0.85rem' }}>
                        {c.deal_value > 0 ? `$${c.deal_value.toLocaleString()}` : '—'}
                      </div>
                      <span style={{ fontSize: '0.68rem', color: 'var(--text-muted)' }}>
                        {c.total_followups} touchpoint(s)
                      </span>
                    </td>

                    {/* Actions */}
                    <td>
                      <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
                        {onConvertToAccount && (
                          <button
                            className="btn btn-sm"
                            onClick={() => onConvertToAccount(c)}
                            title="Turn this lead into an Account with projects & representatives"
                            style={{
                              padding: '0.25rem 0.5rem',
                              backgroundColor: 'var(--lead-surface)',
                              color: 'var(--lead-action)',
                              border: '1px solid var(--lead-border)',
                              fontSize: '0.72rem',
                              fontWeight: 700,
                              display: 'flex',
                              alignItems: 'center',
                              gap: '0.25rem'
                            }}
                          >
                            <Building2 size={12} />
                            <span>To Account</span>
                          </button>
                        )}

                        <button
                          className="btn btn-secondary btn-sm"
                          onClick={() => onScheduleFollowupForLead(c.id)}
                          title="Schedule steel detailing meetup or follow-up"
                          style={{ padding: '0.25rem 0.4rem' }}
                        >
                          <CalendarPlus size={12} />
                        </button>

                        <button
                          className="btn btn-secondary btn-sm"
                          onClick={() => onEditLead(c)}
                          title="Edit lead details"
                          style={{ padding: '0.25rem 0.4rem' }}
                        >
                          <Edit3 size={12} />
                        </button>

                        {onRevertToClient && (
                          <button
                            className="btn btn-secondary btn-sm"
                            onClick={() => onRevertToClient(c.id)}
                            title="Revert lead back to regular prospect client"
                            style={{ padding: '0.25rem 0.4rem' }}
                          >
                            <RotateCcw size={12} />
                          </button>
                        )}

                        <button
                          className="btn btn-danger btn-sm"
                          onClick={() => onDeleteLead(c.id)}
                          title="Delete lead record"
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
          {filteredLeads.map((c) => (
            <div
              key={c.id}
              className="card"
              style={{
                display: 'flex',
                flexDirection: 'column',
                border: '1px solid var(--lead-border)',
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
                  <ThumbsUp size={12} color={c.positive_approach ? '#D97706' : '#9CA3AF'} />
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
                {c.deal_value > 0 && (
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', color: 'var(--lead-color)', fontWeight: 700 }}>
                    <DollarSign size={12} />
                    <span>Est. Detailing Quote: ${c.deal_value.toLocaleString()}</span>
                  </div>
                )}
                {c.notes && (
                  <p style={{ fontSize: '0.72rem', color: 'var(--text-muted)', marginTop: '0.25rem', fontStyle: 'italic' }}>
                    "{c.notes}"
                  </p>
                )}
              </div>

              {/* Card Footer Actions */}
              <div style={{ marginTop: 'auto', display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: '0.4rem', borderTop: '1px solid var(--border-light)', paddingTop: '0.65rem' }}>
                {onConvertToAccount && (
                  <button
                    className="btn btn-primary btn-sm"
                    onClick={() => onConvertToAccount(c)}
                    title="Turn to Corporate Account & Projects"
                    style={{ background: 'var(--accent-primary)', fontSize: '0.72rem', padding: '0.25rem 0.5rem' }}
                  >
                    <Building2 size={12} />
                    <span>To Account</span>
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
    </div>
  );
}
