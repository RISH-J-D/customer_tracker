import React, { useMemo, useState } from 'react';
import { CalendarCheck, CheckCircle2 } from 'lucide-react';
import FollowUpLogModal from '../components/FollowUpLogModal';
import DeleteFollowupButton from '../components/DeleteFollowupButton';
import { groupByDay, parseServerUtc, relativeDayLabel, formatTime } from '../components/calendarUtils';
import { ordinal, splitFollowupNotes, startOfDay, longDayLabel, contactNames } from '../components/followupHistory';

const RANGES = [
  { id: 'all', label: 'All upcoming' },
  { id: '7', label: 'Next 7 days' },
  { id: '30', label: 'Next 30 days' }
];

const addDays = (d, n) => {
  const out = new Date(d);
  out.setDate(out.getDate() + n);
  return out;
};

// Auto-scheduled follow-ups are titled "Follow-up with <name>"; only show titles someone typed
const customTitle = (f) => (f.title && !f.title.startsWith('Follow-up with ') ? f.title : null);

function AgendaEntry({ f, client, overdue, onFollowedUp, onDelete }) {
  const { company, rep } = contactNames(f);
  const { plan } = splitFollowupNotes(f.notes);
  const title = customTitle(f);
  return (
    <li className="fu-item">
      <div className="fu-time">{overdue ? longDayLabel(f.date) : formatTime(f.date)}</div>
      <div className="fu-body">
        <div className="fu-title-row">
          <span className="fu-company">{company}</span>
          {rep && <span className="fu-rep">{rep}</span>}
        </div>
        <div className="fu-meta">
          <span>{ordinal(f.number)} follow-up</span>
          <span>·</span>
          <span>{f.type}</span>
          {title && <><span>·</span><span>{title}</span></>}
          {f.priority === 'High' && <span className="fu-tag is-high">High</span>}
          {overdue && <span className="fu-tag is-overdue">Overdue</span>}
        </div>
        {plan && <p className="fu-note is-plan">{plan}</p>}
      </div>
      {client && (
        <div className="fu-item-action">
          <button
            className="btn btn-primary btn-sm"
            onClick={() => onFollowedUp(client)}
            title="Log what you discussed and pick the next follow-up date"
          >
            <CheckCircle2 size={13} />
            <span>Followed up</span>
          </button>
        </div>
      )}
      <DeleteFollowupButton followupId={f.id} onDelete={onDelete} />
    </li>
  );
}

export default function AgendaPage({ followups, clients, onLogFollowup, onDeleteFollowup }) {
  const [range, setRange] = useState('all');
  const [logClient, setLogClient] = useState(null);

  const clientById = useMemo(() => new Map(clients.map(c => [c.id, c])), [clients]);

  // Pending follow-ups soonest first, each numbered as the follow-up it will be for that contact
  const pending = useMemo(() => {
    const done = new Map();
    followups.forEach(f => {
      if (f.status === 'Completed') done.set(f.client_id, (done.get(f.client_id) || 0) + 1);
    });
    const queued = new Map();
    return followups
      .filter(f => f.status === 'Pending')
      .map(f => ({ ...f, date: parseServerUtc(f.scheduled_at) }))
      .filter(f => f.date)
      .sort((a, b) => a.date - b.date)
      .map(f => {
        const k = (queued.get(f.client_id) || 0) + 1;
        queued.set(f.client_id, k);
        return { ...f, number: (done.get(f.client_id) || 0) + k };
      });
  }, [followups]);

  const today = startOfDay(new Date());
  const tomorrow = addDays(today, 1);
  const overdue = pending.filter(f => f.date < today);
  const fromToday = pending.filter(f => f.date >= today);
  const end = range === 'all' ? null : addDays(today, Number(range));
  const upcoming = fromToday.filter(f => !end || f.date < end);
  const days = groupByDay(upcoming, f => f.date);

  const dueToday = fromToday.filter(f => f.date < tomorrow).length;
  const nextWeek = fromToday.filter(f => f.date < addDays(today, 7)).length;

  const renderEntry = (f, isOverdue = false) => (
    <AgendaEntry key={f.id} f={f} client={clientById.get(f.client_id)} overdue={isOverdue} onFollowedUp={setLogClient} onDelete={onDeleteFollowup} />
  );

  return (
    <div>
      <div className="fu-summary">
        <div className={`fu-summary-tile${dueToday > 0 ? ' is-today' : ''}`}>
          <div className="fu-summary-value">{dueToday}</div>
          <div className="fu-summary-label">Due today</div>
        </div>
        <div className="fu-summary-tile">
          <div className="fu-summary-value">{nextWeek}</div>
          <div className="fu-summary-label">In the next 7 days</div>
        </div>
        <div className="fu-summary-tile">
          <div className="fu-summary-value">{fromToday.length}</div>
          <div className="fu-summary-label">Upcoming in total</div>
        </div>
        <div className={`fu-summary-tile${overdue.length > 0 ? ' is-alert' : ''}`}>
          <div className="fu-summary-value">{overdue.length}</div>
          <div className="fu-summary-label">Overdue</div>
        </div>
      </div>

      <div className="card fu-toolbar">
        <div className="segmented-control">
          {RANGES.map(r => (
            <button key={r.id} className={`segmented-btn ${range === r.id ? 'active' : ''}`} onClick={() => setRange(r.id)}>
              {r.label}
            </button>
          ))}
        </div>
        <span style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
          {upcoming.length} {upcoming.length === 1 ? 'follow-up' : 'follow-ups'} from today
        </span>
      </div>

      {overdue.length > 0 && (
        <section className="fu-day is-overdue">
          <header className="fu-day-head">
            <span className="fu-day-name">Overdue</span>
            <span className="fu-day-date">missed, still to do</span>
            <span className="fu-day-count">{overdue.length}</span>
          </header>
          <ol className="fu-list">{overdue.map(f => renderEntry(f, true))}</ol>
        </section>
      )}

      {days.length === 0 ? (
        <div className="card" style={{ textAlign: 'center', padding: '3rem 1rem', color: 'var(--text-muted)' }}>
          <CalendarCheck size={36} style={{ margin: '0 auto 0.75rem auto', opacity: 0.3 }} />
          <h3 style={{ fontSize: '0.95rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '0.25rem' }}>
            Nothing scheduled
          </h3>
          <p style={{ fontSize: '0.8rem' }}>
            {range === 'all' ? 'No follow-ups from today onward.' : 'No follow-ups in this range. Try "All upcoming".'}
          </p>
        </div>
      ) : (
        days.map(g => {
          const label = relativeDayLabel(g.date);
          const isRelative = ['Today', 'Tomorrow'].includes(label);
          return (
            <section key={g.key} className={`fu-day${label === 'Today' ? ' is-today' : ''}`}>
              <header className="fu-day-head">
                <span className="fu-day-name">{label}</span>
                {isRelative && <span className="fu-day-date">{longDayLabel(g.date)}</span>}
                <span className="fu-day-count">{g.items.length}</span>
              </header>
              <ol className="fu-list">{g.items.map(f => renderEntry(f))}</ol>
            </section>
          );
        })
      )}

      {logClient && (
        <FollowUpLogModal client={logClient} onClose={() => setLogClient(null)} onSave={onLogFollowup} />
      )}
    </div>
  );
}
