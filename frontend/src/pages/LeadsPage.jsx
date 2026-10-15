import React, { useState, useEffect } from 'react';
import {
  Target,
  Search,
  Plus,
  Building,
  Trash2,
  Edit3,
  CheckCircle2,
  UploadCloud,
  Users,
  Ban
} from 'lucide-react';
import ExportDropdown from '../components/ExportDropdown';
import NotesCell from '../components/NotesCell';
import Pagination from '../components/Pagination';
import ViewModeToggle from '../components/ViewModeToggle';
import { EmailLink, PhoneLinks } from '../components/ContactLinks';
import { AddressFilters, AddressLine, useAddressFilter, formatAddress } from '../components/AddressFilters';

// Green = converted to account, red = not feasible / not contactable / negative
const rowMarkClass = (c, prefix) =>
  c.account_converted_at ? `${prefix}-account-converted` : c.marked_negative_at ? `${prefix}-negative` : '';

const dash = <span style={{ color: 'var(--text-muted)' }}>-</span>;

export default function LeadsPage({
  leads,
  onOpenNewLead,
  onEditLead,
  onDeleteLead,
  onToggleNegative,
  onMoveToClient,
  onOpenExportModal,
  onOpenImportModal,
  onUpdateNotes,
  onAddNote,
  onEditNote,
  onDeleteNote
}) {
  const leadList = leads.filter(c => c.is_lead);
  const address = useAddressFilter(leadList);

  const [searchQuery, setSearchQuery] = useState('');
  const [viewMode, setViewMode] = useState('table'); // 'table' or 'grid'
  const [page, setPage] = useState(1);
  const [pageSize, setPageSize] = useState(25);

  useEffect(() => {
    setPage(1);
  }, [searchQuery, viewMode, address.country, address.state, address.city]);

  const filteredLeads = leadList.filter(c => {
    if (!address.matches(c)) return false;

    if (searchQuery.trim()) {
      const q = searchQuery.toLowerCase();
      const fields = [c.name, c.company, c.email, c.phone, c.notes, formatAddress(c)];
      const matchField = fields.some(v => v?.toLowerCase().includes(q));
      const matchNotes = (c.note_entries || []).some(n => n.content?.toLowerCase().includes(q));
      if (!matchField && !matchNotes) return false;
    }

    return true;
  });

  const paginatedLeads = filteredLeads.slice((page - 1) * pageSize, page * pageSize);

  const moveToClient = (c) => {
    if (window.confirm(`Move ${c.company || c.name} to Clients?`)) onMoveToClient(c.id);
  };

  const negativeToggleProps = (c) => ({
    onClick: () => onToggleNegative(c.id),
    title: c.marked_negative_at
      ? `Marked not feasible / negative on ${new Date(c.marked_negative_at + 'Z').toLocaleDateString()} — click to undo`
      : 'Mark as not feasible / not contactable / negative (highlights the row red)',
    'aria-pressed': Boolean(c.marked_negative_at)
  });

  const notesCell = (c) => (
    <NotesCell
      client={c}
      onAddNote={onAddNote}
      onEditNote={onEditNote}
      onDeleteNote={onDeleteNote}
      onUpdateNotes={onUpdateNotes}
    />
  );

  return (
    <div>
      {/* Page Header */}
      <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'flex-end', flexWrap: 'wrap', gap: '1rem', marginBottom: '1.25rem' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', flexWrap: 'wrap' }}>
          <ViewModeToggle viewMode={viewMode} onChange={setViewMode} />

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

      {/* Leads Summary KPI Card */}
      <div className="kpi-grid" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(210px, 1fr))', gap: '0.85rem', marginBottom: '1.25rem' }}>
        <div className="card" style={{ padding: '0.85rem 1rem' }}>
          <div style={{ fontSize: '0.78rem', color: 'var(--text-secondary)', fontWeight: 500 }}>
            Active leads
          </div>
          <div className="stat-value" style={{ fontSize: '1.4rem', marginTop: '0.2rem' }}>
            {leadList.length}
          </div>
          <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', marginTop: '0.15rem' }}>
            Move a lead to Clients once you start working it
          </div>
        </div>
      </div>

      {/* Address Filters and Search Bar */}
      <div className="card" style={{ padding: '0.65rem 0.85rem', marginBottom: '1.25rem' }}>
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '0.75rem' }}>
          <AddressFilters filter={address} />

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
          {searchQuery || address.isActive ? (
            <p style={{ fontSize: '0.8rem', maxWidth: '420px', margin: '0 auto' }}>
              Nothing matches the current search or address filters.
            </p>
          ) : (
            <>
              <p style={{ fontSize: '0.8rem', maxWidth: '420px', margin: '0 auto 1.25rem auto' }}>
                Add a lead or import existing leads directly from Excel.
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
            </>
          )}
        </div>
      ) : viewMode === 'table' ? (
        /* TABLE LIST VIEW */
        <div className="table-responsive table-mobile-cards">
          <table className="custom-table">
            <thead>
              <tr>
                <th style={{ width: '22%' }}>Lead & Fabricator / Client</th>
                <th style={{ width: '16%' }}>Email</th>
                <th style={{ width: '12%' }}>Mobile</th>
                <th style={{ width: '40%' }}>Notes</th>
                <th style={{ width: '1%' }}>Actions</th>
              </tr>
            </thead>
            <tbody>
              {paginatedLeads.map((c) => {
                const initials = c.name ? c.name.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase() : 'LD';
                return (
                  <tr key={c.id} className={rowMarkClass(c, 'row') || undefined}>
                    {/* Lead Name, Company & Address */}
                    <td className="td-name">
                      <div style={{ display: 'flex', alignItems: 'flex-start', gap: '0.65rem' }}>
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
                          <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', color: 'var(--text-muted)', fontSize: '0.75rem', marginTop: '0.1rem', flexWrap: 'wrap' }}>
                            <span>{c.company || 'Fabricator / Contractor'}</span>
                            {c.position && <span>• <strong style={{ fontWeight: 500, color: 'var(--text-secondary)' }}>{c.position}</strong></span>}
                          </div>
                          <AddressLine client={c} />
                        </div>
                      </div>
                    </td>

                    <td className="td-email" data-label="Email">
                      <div style={{ fontSize: '0.75rem', color: 'var(--text-secondary)' }}>
                        {c.email ? <EmailLink email={c.email} /> : dash}
                      </div>
                    </td>

                    <td className="td-mobile" data-label="Mobile">
                      <div style={{ fontSize: '0.75rem', color: 'var(--text-secondary)' }}>
                        {c.phone ? <PhoneLinks phone={c.phone} label="mobile number" /> : dash}
                      </div>
                    </td>

                    <td className="td-stack" data-label="Notes">
                      {notesCell(c)}
                    </td>

                    <td className="td-actions" data-label="Actions">
                      <div className="row-actions">
                        <button
                          className="btn btn-primary btn-sm row-action-wide"
                          onClick={() => moveToClient(c)}
                          title="Move this lead to the Clients tab"
                        >
                          <Users size={13} />
                          <span>To Client</span>
                        </button>
                        {onToggleNegative && (
                          <button
                            className={`btn btn-secondary btn-sm row-action-btn btn-negative-toggle${c.marked_negative_at ? ' is-negative' : ''}`}
                            {...negativeToggleProps(c)}
                          >
                            <Ban size={15} />
                          </button>
                        )}

                        <button
                          className="btn btn-secondary btn-sm row-action-btn"
                          onClick={() => onEditLead(c)}
                          title="Edit lead details"
                        >
                          <Edit3 size={15} />
                        </button>

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
              className={`card ${rowMarkClass(c, 'card')}`}
              style={{
                display: 'flex',
                flexDirection: 'column',
                border: '1px solid var(--lead-border)'
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
                  <AddressLine client={c} size={12} />
                </div>

                <span className="badge-status badge-lead">
                  <CheckCircle2 size={11} />
                  <span>Lead</span>
                </span>
              </div>

              {/* Contact info */}
              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.25rem', marginBottom: '0.65rem', fontSize: '0.75rem', color: 'var(--text-secondary)' }}>
                {c.position && (
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', color: 'var(--text-secondary)' }}>
                    <Building size={12} color="var(--text-placeholder)" />
                    <span>{c.position}</span>
                  </div>
                )}
                <EmailLink email={c.email} />
                <PhoneLinks phone={c.phone} label="mobile number" />
                <div style={{ marginTop: '0.4rem', paddingTop: '0.4rem', borderTop: '1px solid var(--border-light)' }}>
                  {notesCell(c)}
                </div>
              </div>

              {/* Card Footer Actions */}
              <div style={{ marginTop: 'auto', display: 'flex', alignItems: 'center', gap: '0.4rem', borderTop: '1px solid var(--border-light)', paddingTop: '0.65rem' }}>
                <button
                  className="btn btn-primary btn-sm"
                  onClick={() => moveToClient(c)}
                  title="Move this lead to the Clients tab"
                  style={{ flex: 1 }}
                >
                  <Users size={12} />
                  <span>To Client</span>
                </button>
                {onToggleNegative && (
                  <button
                    className={`btn btn-secondary btn-sm btn-negative-toggle${c.marked_negative_at ? ' is-negative' : ''}`}
                    {...negativeToggleProps(c)}
                  >
                    <Ban size={12} />
                  </button>
                )}

                <button
                  className="btn btn-secondary btn-sm"
                  onClick={() => onEditLead(c)}
                  title="Edit lead"
                >
                  <Edit3 size={12} />
                </button>

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

      <Pagination
        page={page}
        pageSize={pageSize}
        total={filteredLeads.length}
        noun="leads"
        onPageChange={setPage}
        onPageSizeChange={(size) => { setPageSize(size); setPage(1); }}
      />
    </div>
  );
}
