import React, { useState, useMemo, useEffect } from 'react';
import {
  Users,
  Search,
  Plus,
  Building,
  Trash2,
  Edit3,
  UploadCloud,
  Handshake,
  Star,
  Clock
} from 'lucide-react';

import ExportDropdown from '../components/ExportDropdown';
import NotesCell from '../components/NotesCell';
import NextFollowUpCell from '../components/NextFollowUpCell';
import FollowUpLogModal from '../components/FollowUpLogModal';
import Pagination from '../components/Pagination';
import ViewModeToggle from '../components/ViewModeToggle';
import { ContactBlock } from '../components/ContactLinks';
import { AddressFilters, AddressLine, useAddressFilter, formatAddress } from '../components/AddressFilters';
import { parseServerUtc } from '../components/calendarUtils';

// Imported rows without a named contact were saved as "<Company> Contact"
const getRepresentativeName = (c) => (c.name && c.name !== `${c.company} Contact` ? c.name : null);

// A pending follow-up that is due today or already overdue
const endOfToday = () => { const d = new Date(); d.setHours(23, 59, 59, 999); return d; };
const hasDueFollowup = (c) => (c.followups || []).some(f => f.status === 'Pending' && parseServerUtc(f.scheduled_at) <= endOfToday());

function RepresentativeBlock({ client }) {
  const repName = getRepresentativeName(client);
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.25rem' }}>
      {(repName || client.position) && (
        <div>
          {repName && <div style={{ fontWeight: 600, color: 'var(--text-primary)', fontSize: '0.8rem' }}>{repName}</div>}
          {client.position && <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)' }}>{client.position}</div>}
        </div>
      )}
      <ContactBlock email={client.email} phone={client.phone} emailLabel="representative's email" phoneLabel="representative's number" />
    </div>
  );
}

export default function ClientsPage({
  clients,
  onOpenNewClient,
  onEditClient,
  onDeleteClient,
  onConvertToAccount,
  onToggleProspect,
  onLogFollowup,
  onOpenExportModal,
  onOpenImportModal,
  onUpdateNotes,
  onAddNote,
  onEditNote,
  onDeleteNote
}) {
  const [activeFilter, setActiveFilter] = useState('all'); // all, prospects, due
  const [searchQuery, setSearchQuery] = useState('');
  const [viewMode, setViewMode] = useState('table'); // 'table' or 'grid'
  const [page, setPage] = useState(1);
  const [pageSize, setPageSize] = useState(25);
  const [followUpClient, setFollowUpClient] = useState(null);

  // Leads and converted accounts have their own tabs
  const clientList = useMemo(() => clients.filter(c => !c.is_lead && !c.account_converted_at), [clients]);
  const address = useAddressFilter(clientList);

  useEffect(() => {
    setPage(1);
  }, [searchQuery, activeFilter, viewMode, address.country, address.state, address.city]);

  const prospectCount = clientList.filter(c => c.prospect_marked_at).length;
  const dueCount = clientList.filter(hasDueFollowup).length;

  const filteredClients = clientList.filter(c => {
    if (activeFilter === 'prospects' && !c.prospect_marked_at) return false;
    if (activeFilter === 'due' && !hasDueFollowup(c)) return false;
    if (!address.matches(c)) return false;

    if (searchQuery.trim()) {
      const q = searchQuery.toLowerCase();
      const fields = [c.name, c.company, c.email, c.phone, c.company_email, c.company_phone, c.notes, formatAddress(c)];
      const matchField = fields.some(v => v?.toLowerCase().includes(q));
      const matchNotes = (c.note_entries || []).some(n => n.content?.toLowerCase().includes(q));
      if (!matchField && !matchNotes) return false;
    }
    return true;
  });

  const paginatedClients = filteredClients.slice((page - 1) * pageSize, page * pageSize);

  const convertToAccount = (c) => {
    if (window.confirm(`Convert ${c.company || c.name} to an account? It will move to the Accounts tab.`)) {
      onConvertToAccount(c.id);
    }
  };

  const prospectButtonProps = (c) => ({
    onClick: () => onToggleProspect(c.id),
    title: c.prospect_marked_at ? 'Prospect — click to remove the highlight' : 'Mark as prospect (highlights the row)',
    'aria-pressed': Boolean(c.prospect_marked_at)
  });

  const notesCell = (c) => (
    <NotesCell
      client={c}
      onAddNote={onAddNote}
      onEditNote={onEditNote}
      onDeleteNote={onDeleteNote}
      onUpdateNotes={onUpdateNotes}
      compact
    />
  );

  return (
    <div className="table-page">
      {/* Page Header */}
      <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'flex-end', flexWrap: 'wrap', gap: '1rem', marginBottom: '1.25rem' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', flexWrap: 'wrap' }}>
          <ViewModeToggle viewMode={viewMode} onChange={setViewMode} />

          {onOpenImportModal && (
            <button
              className="btn btn-secondary"
              onClick={onOpenImportModal}
              title="Import contacts from Excel (.xlsx) or CSV"
            >
              <UploadCloud size={14} />
              <span>Import Excel</span>
            </button>
          )}

          <ExportDropdown onOpenModal={onOpenExportModal} />

          <button className="btn btn-primary" onClick={onOpenNewClient}>
            <Plus size={15} />
            <span>Add Contact</span>
          </button>
        </div>
      </div>

      {/* Filter and Search Bar */}
      <div className="card" style={{ padding: '0.65rem 0.85rem', marginBottom: '1.25rem', display: 'flex', flexDirection: 'column', gap: '0.6rem' }}>
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '0.75rem' }}>
          <div className="segmented-control">
            <button
              className={`segmented-btn ${activeFilter === 'all' ? 'active' : ''}`}
              onClick={() => setActiveFilter('all')}
            >
              All Contacts ({clientList.length})
            </button>
            <button
              className={`segmented-btn ${activeFilter === 'prospects' ? 'active' : ''}`}
              onClick={() => setActiveFilter('prospects')}
            >
              <Star size={12} color="var(--prospect-row-accent)" />
              <span>Prospects ({prospectCount})</span>
            </button>
            <button
              className={`segmented-btn ${activeFilter === 'due' ? 'active' : ''}`}
              onClick={() => setActiveFilter('due')}
            >
              <Clock size={12} color="var(--danger-btn)" />
              <span>Follow-up due ({dueCount})</span>
            </button>
          </div>

          <div className="search-box" style={{ position: 'relative', width: '100%', maxWidth: '280px' }}>
            <Search size={14} color="var(--text-muted)" style={{ position: 'absolute', left: '9px', top: '9px' }} />
            <input
              type="text"
              placeholder="Search contacts, companies, notes..."
              className="form-input"
              style={{ paddingLeft: '2rem', height: '32px', fontSize: '0.785rem' }}
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
          </div>
        </div>
        <AddressFilters filter={address} />
      </div>

      {filteredClients.length === 0 ? (
        <div className="card" style={{ textAlign: 'center', padding: '3rem 1.5rem', color: 'var(--text-muted)' }}>
          <Users size={36} style={{ margin: '0 auto 0.75rem auto', opacity: 0.3 }} />
          <h3 style={{ fontSize: '1rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '0.25rem' }}>
            No Contacts Found
          </h3>
          <p style={{ fontSize: '0.8rem', maxWidth: '380px', margin: '0 auto 1.25rem auto' }}>
            {clientList.length === 0
              ? 'Add a contact or import an Excel spreadsheet to get started.'
              : 'No contacts match the current search or filters.'}
          </p>
          {clientList.length === 0 && (
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.65rem' }}>
              {onOpenImportModal && (
                <button className="btn btn-secondary" onClick={onOpenImportModal}>
                  <UploadCloud size={14} />
                  <span>Import from Excel</span>
                </button>
              )}
              <button className="btn btn-primary" onClick={onOpenNewClient}>
                <Plus size={14} />
                <span>Add Contact</span>
              </button>
            </div>
          )}
        </div>
      ) : viewMode === 'table' ? (
        /* TABLE LIST VIEW */
        <div className="table-responsive table-mobile-cards">
          <table className="custom-table table-contacts">
            <thead>
              <tr>
                <th style={{ width: '25%' }}>Company</th>
                <th style={{ width: '25%' }}>Representative</th>
                <th style={{ width: '17%' }}>Follow-up</th>
                <th style={{ width: '32%' }}>Latest note</th>
                <th style={{ width: '1%' }}>Actions</th>
              </tr>
            </thead>
            <tbody>
              {paginatedClients.map((c) => {
                const companyName = c.company || c.name;
                const initials = companyName ? companyName.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase() : 'CO';
                return (
                  <tr key={c.id} className={c.prospect_marked_at ? 'row-prospect' : undefined}>
                    {/* Company, address and company contact details */}
                    <td className="td-name">
                      <div className="cell-company">
                        <div className="cell-avatar">{initials}</div>
                        <div style={{ minWidth: 0 }}>
                          <div className="cell-title">
                            <span>{companyName}</span>
                            {c.prospect_marked_at && <Star size={12} fill="var(--prospect-row-accent)" color="var(--prospect-row-accent)" />}
                          </div>
                          <AddressLine client={c} />
                          {(c.company_email || c.company_phone) && (
                            <div style={{ marginTop: '0.35rem' }}>
                              <ContactBlock email={c.company_email} phone={c.company_phone} emailLabel="company email" phoneLabel="company number" />
                            </div>
                          )}
                        </div>
                      </div>
                    </td>

                    <td className="td-rep" data-label="Representative">
                      <RepresentativeBlock client={c} />
                    </td>

                    <td className="td-stack" data-label="Follow-up">
                      <NextFollowUpCell client={c} onFollowedUp={setFollowUpClient} />
                    </td>

                    <td className="td-stack" data-label="Notes">
                      {notesCell(c)}
                    </td>

                    <td className="td-actions" data-label="Actions">
                      <div className="row-actions">
                        <button
                          className="btn btn-lead btn-sm row-action-wide"
                          onClick={() => convertToAccount(c)}
                          title="Convert this contact to an account (moves to the Accounts tab)"
                        >
                          <Handshake size={13} />
                          <span>To Account</span>
                        </button>

                        <button
                          className={`btn btn-secondary btn-sm row-action-btn btn-prospect-toggle${c.prospect_marked_at ? ' is-prospect' : ''}`}
                          {...prospectButtonProps(c)}
                        >
                          <Star size={14} />
                        </button>

                        <button
                          className="btn btn-secondary btn-sm row-action-btn"
                          onClick={() => onEditClient(c)}
                          title="Edit contact"
                        >
                          <Edit3 size={14} />
                        </button>

                        <button
                          className="btn btn-danger btn-sm row-action-btn"
                          onClick={() => onDeleteClient(c.id)}
                          title="Delete contact"
                        >
                          <Trash2 size={14} />
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
        <div className="table-scroll" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(320px, 1fr))', gap: '1rem' }}>
          {paginatedClients.map((c) => (
            <div
              key={c.id}
              className={`card${c.prospect_marked_at ? ' card-prospect' : ''}`}
              style={{ display: 'flex', flexDirection: 'column', gap: '0.65rem', border: '1px solid var(--border-subtle)' }}
            >
              <div>
                <h3 style={{ fontSize: '0.95rem', fontWeight: 700, color: 'var(--text-primary)', display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
                  <Building size={14} color="var(--text-muted)" />
                  <span>{c.company || c.name}</span>
                  {c.prospect_marked_at && <Star size={13} fill="var(--prospect-row-accent)" color="var(--prospect-row-accent)" />}
                </h3>
                <AddressLine client={c} size={12} />
                <div style={{ marginTop: '0.35rem' }}>
                  <ContactBlock email={c.company_email} phone={c.company_phone} emailLabel="company email" phoneLabel="company number" />
                </div>
              </div>

              <div style={{ paddingTop: '0.5rem', borderTop: '1px solid var(--border-light)' }}>
                <RepresentativeBlock client={c} />
              </div>

              <div style={{ paddingTop: '0.5rem', borderTop: '1px solid var(--border-light)' }}>
                <NextFollowUpCell client={c} onFollowedUp={setFollowUpClient} />
              </div>

              <div style={{ paddingTop: '0.5rem', borderTop: '1px solid var(--border-light)' }}>
                {notesCell(c)}
              </div>

              <div style={{ marginTop: 'auto', display: 'flex', alignItems: 'center', gap: '0.4rem', borderTop: '1px solid var(--border-light)', paddingTop: '0.65rem' }}>
                <button className="btn btn-lead btn-sm" onClick={() => convertToAccount(c)} style={{ flex: 1 }} title="Convert to account">
                  <Handshake size={12} />
                  <span>To Account</span>
                </button>
                <button
                  className={`btn btn-secondary btn-sm btn-prospect-toggle${c.prospect_marked_at ? ' is-prospect' : ''}`}
                  {...prospectButtonProps(c)}
                >
                  <Star size={12} />
                </button>
                <button className="btn btn-secondary btn-sm" onClick={() => onEditClient(c)} title="Edit contact">
                  <Edit3 size={12} />
                </button>
                <button className="btn btn-danger btn-sm" onClick={() => onDeleteClient(c.id)} title="Delete contact">
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
        total={filteredClients.length}
        noun="contacts"
        onPageChange={setPage}
        onPageSizeChange={(size) => { setPageSize(size); setPage(1); }}
      />

      {followUpClient && (
        <FollowUpLogModal
          client={followUpClient}
          onClose={() => setFollowUpClient(null)}
          onSave={onLogFollowup}
        />
      )}
    </div>
  );
}
