import React, { useMemo, useState, useEffect } from 'react';
import { History, Search } from 'lucide-react';
import ExportDropdown from '../components/ExportDropdown';
import { groupByDay, relativeDayLabel, formatTime } from '../components/calendarUtils';
import { numberedHistory, ordinal, splitFollowupNotes, startOfDay, longDayLabel, contactNames } from '../components/followupHistory';

const DAYS_PER_PAGE = 14;
const ENTRIES_PER_CONTACT = 5;

const RANGES = [
  { id: 'all', label: 'All time' },
  { id: '7', label: 'Last 7 days' },
  { id: '30', label: 'Last 30 days' }
];

const daysAgo = (n) => {
  const d = startOfDay(new Date());
  d.setDate(d.getDate() - (n - 1));
  return d;
};

function FollowupNote({ f }) {
  const { plan, outcome } = splitFollowupNotes(f.notes);
  if (outcome) return <p className="fu-note">{outcome}</p>;
  if (plan) return <p className="fu-note is-plan">{plan}</p>;
  return null;
}

function TimelineEntry({ f }) {
  const { company, rep } = contactNames(f);
  return (
    <li className="fu-item">
      <div className="fu-num" title={`${ordinal(f.number)} follow-up with ${company}`}>#{f.number}</div>
      <div className="fu-body">
        <div className="fu-title-row">
          <span className="fu-company">{company}</span>
          {rep && <span className="fu-rep">{rep}</span>}
        </div>
        <div className="fu-meta">
          <span>{ordinal(f.number)} follow-up</span>
          <span>·</span>
          <span>{f.type}</span>
          <span>·</span>
          <span>{formatTime(f.doneAt)}</span>
        </div>
        <FollowupNote f={f} />
      </div>
    </li>
  );
}

function ContactHistoryCard({ entries }) {
  const [showAll, setShowAll] = useState(false);
  const latest = entries[0];
  const { company, rep } = contactNames(latest);
  const visible = showAll ? entries : entries.slice(0, ENTRIES_PER_CONTACT);

  return (
    <div className="card fu-contact">
      <div className="fu-contact-head">
        <div style={{ minWidth: 0 }}>
          <div className="fu-company">{company}</div>
          {rep && <div className="fu-rep">{rep}</div>}
        </div>
        <div className="fu-contact-count">
          <strong>{latest.number}</strong>
          {latest.number === 1 ? 'follow-up' : 'follow-ups'} · last {relativeDayLabel(latest.doneAt).toLowerCase()}
        </div>
      </div>
      <ol className="fu-list">
        {visible.map(f => (
          <li key={f.id} className="fu-item">
            <div className="fu-num">#{f.number}</div>
            <div className="fu-body">
              <div className="fu-meta" style={{ marginTop: 0 }}>
                <strong style={{ color: 'var(--text-primary)' }}>{longDayLabel(f.doneAt)}</strong>
                <span>·</span>
                <span>{f.type}</span>
              </div>
              <FollowupNote f={f} />
            </div>
          </li>
        ))}
      </ol>
      {entries.length > ENTRIES_PER_CONTACT && (
        <button type="button" className="fu-more" onClick={() => setShowAll(v => !v)}>
          {showAll ? 'Show fewer' : `Show all ${entries.length}`}
        </button>
      )}
    </div>
  );
}

export default function FollowUpsPage({ followups, onOpenExportModal }) {
  const [view, setView] = useState('timeline'); // timeline, contacts
  const [range, setRange] = useState('all');
  const [search, setSearch] = useState('');
  const [dayLimit, setDayLimit] = useState(DAYS_PER_PAGE);

  useEffect(() => { setDayLimit(DAYS_PER_PAGE); }, [view, range, search]);

  const history = useMemo(() => numberedHistory(followups), [followups]);

  const weekStart = daysAgo(7);
  const doneThisWeek = history.filter(f => f.doneAt >= weekStart).length;
  const contactsReached = new Set(history.map(f => f.client_id)).size;

  const cutoff = range === 'all' ? null : daysAgo(Number(range));
  const q = search.trim().toLowerCase();
  const visible = history
    .filter(f => !cutoff || f.doneAt >= cutoff)
    .filter(f => !q || [f.client_company, f.client_name, f.notes, f.title].some(v => v?.toLowerCase().includes(q)))
    .reverse(); // newest first

  const days = groupByDay(visible, f => f.doneAt);

  const byContact = [];
  const contactIndex = new Map();
  visible.forEach(f => {
    if (!contactIndex.has(f.client_id)) {
      contactIndex.set(f.client_id, byContact.length);
      byContact.push([]);
    }
    byContact[contactIndex.get(f.client_id)].push(f);
  });

  const todayKey = startOfDay(new Date()).getTime();

  return (
    <div>
      <div className="fu-summary">
        <div className="fu-summary-tile">
          <div className="fu-summary-value">{history.length}</div>
          <div className="fu-summary-label">Follow-ups logged</div>
        </div>
        <div className="fu-summary-tile">
          <div className="fu-summary-value">{doneThisWeek}</div>
          <div className="fu-summary-label">In the last 7 days</div>
        </div>
        <div className="fu-summary-tile">
          <div className="fu-summary-value">{contactsReached}</div>
          <div className="fu-summary-label">Contacts followed up</div>
        </div>
      </div>

      <div className="card fu-toolbar">
        <div className="fu-toolbar-group">
          <div className="segmented-control">
            <button className={`segmented-btn ${view === 'timeline' ? 'active' : ''}`} onClick={() => setView('timeline')}>Timeline</button>
            <button className={`segmented-btn ${view === 'contacts' ? 'active' : ''}`} onClick={() => setView('contacts')}>By contact</button>
          </div>
          <div className="segmented-control">
            {RANGES.map(r => (
              <button key={r.id} className={`segmented-btn ${range === r.id ? 'active' : ''}`} onClick={() => setRange(r.id)}>
                {r.label}
              </button>
            ))}
          </div>
        </div>
        <div className="fu-toolbar-group">
          <div className="search-box" style={{ position: 'relative', width: '240px', maxWidth: '100%' }}>
            <Search size={14} color="var(--text-muted)" style={{ position: 'absolute', left: '9px', top: '9px' }} />
            <input
              type="text"
              placeholder="Search contact or notes..."
              className="form-input"
              style={{ paddingLeft: '2rem', height: '32px', fontSize: '0.785rem' }}
              value={search}
              onChange={(e) => setSearch(e.target.value)}
            />
          </div>
          <ExportDropdown onOpenModal={onOpenExportModal} />
        </div>
      </div>

      {visible.length === 0 ? (
        <div className="card" style={{ textAlign: 'center', padding: '3rem 1rem', color: 'var(--text-muted)' }}>
          <History size={36} style={{ margin: '0 auto 0.75rem auto', opacity: 0.3 }} />
          <h3 style={{ fontSize: '0.95rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '0.25rem' }}>
            {history.length === 0 ? 'No follow-ups logged yet' : 'Nothing matches'}
          </h3>
          <p style={{ fontSize: '0.8rem' }}>
            {history.length === 0
              ? 'Press "Followed up" on a contact and it will show up here.'
              : 'Try a wider date range or a different search.'}
          </p>
        </div>
      ) : view === 'timeline' ? (
        <>
          {days.slice(0, dayLimit).map(g => {
            const label = relativeDayLabel(g.date);
            const isRelative = ['Today', 'Yesterday'].includes(label);
            return (
              <section key={g.key} className={`fu-day${startOfDay(g.date).getTime() === todayKey ? ' is-today' : ''}`}>
                <header className="fu-day-head">
                  <span className="fu-day-name">{label}</span>
                  {isRelative && <span className="fu-day-date">{longDayLabel(g.date)}</span>}
                  <span className="fu-day-count">{g.items.length} {g.items.length === 1 ? 'follow-up' : 'follow-ups'}</span>
                </header>
                <ol className="fu-list">
                  {g.items.map(f => <TimelineEntry key={f.id} f={f} />)}
                </ol>
              </section>
            );
          })}
          {days.length > dayLimit && (
            <div style={{ textAlign: 'center' }}>
              <button className="btn btn-secondary btn-sm" onClick={() => setDayLimit(n => n + DAYS_PER_PAGE)}>
                Show older days
              </button>
            </div>
          )}
        </>
      ) : (
        <div className="fu-contact-grid">
          {byContact.map(entries => <ContactHistoryCard key={entries[0].client_id} entries={entries} />)}
        </div>
      )}
    </div>
  );
}
