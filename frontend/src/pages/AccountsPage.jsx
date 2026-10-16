import React, { useState, useMemo, useEffect } from 'react';
import { Search, Handshake, Undo2 } from 'lucide-react';
import NotesCell from '../components/NotesCell';
import Pagination from '../components/Pagination';
import { ContactBlock } from '../components/ContactLinks';
import { AddressFilters, AddressLine, useAddressFilter, formatAddress } from '../components/AddressFilters';
import { parseServerUtc } from '../components/calendarUtils';

// Imported rows without a named contact were saved as "<Company> Contact"
const getRepresentativeName = (c) => (c.name && c.name !== `${c.company} Contact` ? c.name : null);

// Converted accounts: read-only list. The only action is undoing a mistaken conversion.
export default function AccountsPage({ clients, onUndoConversion }) {
  const [searchQuery, setSearchQuery] = useState('');
  const [page, setPage] = useState(1);
  const [pageSize, setPageSize] = useState(25);

  const accounts = useMemo(() => clients
    .filter(c => c.account_converted_at)
    .sort((a, b) => (parseServerUtc(b.account_converted_at) || 0) - (parseServerUtc(a.account_converted_at) || 0)),
  [clients]);
  const address = useAddressFilter(accounts);

  useEffect(() => {
    setPage(1);
  }, [searchQuery, address.country, address.state, address.city]);

  const filtered = accounts.filter(c => {
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
  const paginated = filtered.slice((page - 1) * pageSize, page * pageSize);

  const undo = (c) => {
    const destination = c.is_lead ? 'Leads' : 'Contacts';
    if (window.confirm(`Undo the account conversion for ${c.company || c.name}? It will move back to ${destination}.`)) {
      onUndoConversion(c.id);
    }
  };

  return (
    <div>
      <div className="card" style={{ padding: '0.65rem 0.85rem', marginBottom: '1.25rem' }}>
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '0.75rem' }}>
          <AddressFilters filter={address} />
          <div className="search-box" style={{ position: 'relative', width: '100%', maxWidth: '280px' }}>
            <Search size={14} color="var(--text-muted)" style={{ position: 'absolute', left: '9px', top: '9px' }} />
            <input
              type="text"
              placeholder="Search accounts..."
              className="form-input"
              style={{ paddingLeft: '2rem', height: '32px', fontSize: '0.785rem' }}
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
          </div>
        </div>
      </div>

      {filtered.length === 0 ? (
        <div className="card" style={{ textAlign: 'center', padding: '3.5rem 1.5rem', color: 'var(--text-muted)' }}>
          <Handshake size={38} color="var(--lead-action)" style={{ margin: '0 auto 0.75rem auto', opacity: 0.5 }} />
          <h3 style={{ fontSize: '1rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '0.25rem' }}>
            No Accounts Found
          </h3>
          <p style={{ fontSize: '0.8rem', maxWidth: '420px', margin: '0 auto' }}>
            {accounts.length === 0
              ? <>Click <strong>To Account</strong> on the Contacts page to convert a contact. It will appear here.</>
              : 'No accounts match the current search or filters.'}
          </p>
        </div>
      ) : (
        <div className="table-responsive table-mobile-cards">
          <table className="custom-table">
            <thead>
              <tr>
                <th style={{ width: '20%' }}>Account</th>
                <th style={{ width: '16%' }}>Company Contact</th>
                <th style={{ width: '18%' }}>Representative</th>
                <th style={{ width: '34%' }}>Notes</th>
                <th style={{ width: '1%' }}></th>
              </tr>
            </thead>
            <tbody>
              {paginated.map(c => {
                const repName = getRepresentativeName(c);
                const convertedOn = parseServerUtc(c.account_converted_at);
                return (
                  <tr key={c.id} className="row-account-converted">
                    <td className="td-name">
                      <div style={{ fontWeight: 600, color: 'var(--text-primary)', fontSize: '0.85rem' }}>{c.company || c.name}</div>
                      <AddressLine client={c} />
                      {convertedOn && (
                        <div style={{ fontSize: '0.68rem', color: 'var(--lead-color)', marginTop: '0.25rem', fontWeight: 600 }}>
                          Account since {convertedOn.toLocaleDateString([], { month: 'short', day: 'numeric', year: 'numeric' })}
                        </div>
                      )}
                    </td>
                    <td className="td-email" data-label="Company">
                      <ContactBlock email={c.company_email} phone={c.company_phone} emailLabel="company email" phoneLabel="company number" />
                    </td>
                    <td className="td-rep" data-label="Representative">
                      {(repName || c.position) && (
                        <div style={{ marginBottom: '0.25rem' }}>
                          {repName && <div style={{ fontWeight: 600, color: 'var(--text-primary)', fontSize: '0.8rem' }}>{repName}</div>}
                          {c.position && <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)' }}>{c.position}</div>}
                        </div>
                      )}
                      <ContactBlock email={c.email} phone={c.phone} emailLabel="representative's email" phoneLabel="representative's number" />
                    </td>
                    <td className="td-stack" data-label="Notes">
                      <NotesCell client={c} />
                    </td>
                    <td className="td-actions" data-label="">
                      <button
                        className="btn btn-secondary btn-sm"
                        onClick={() => undo(c)}
                        title={`Undo conversion — move back to ${c.is_lead ? 'Leads' : 'Contacts'}`}
                        style={{ whiteSpace: 'nowrap', fontSize: '0.7rem' }}
                      >
                        <Undo2 size={12} />
                        <span>Undo</span>
                      </button>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      )}

      <Pagination
        page={page}
        pageSize={pageSize}
        total={filtered.length}
        noun="accounts"
        onPageChange={setPage}
        onPageSizeChange={(size) => { setPageSize(size); setPage(1); }}
      />
    </div>
  );
}
