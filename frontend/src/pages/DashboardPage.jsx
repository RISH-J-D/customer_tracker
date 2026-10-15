import React from 'react';
import { 
  Users, 
  Target, 
  CalendarCheck, 
  Video, 
  TrendingUp, 
  DollarSign, 
  ArrowRight, 
  CheckCircle2, 
  ExternalLink,
  MapPin,
  Handshake,
  Star,
  AlertTriangle
} from 'lucide-react';

// Status chip / "To Account" button for the client behind a follow-up
function ClientStageAction({ client, isLead, onConvertToAccount }) {
  if (client?.account_converted_at) {
    return (
      <span className="badge-status badge-lead" style={{ fontSize: '0.68rem' }}>
        <Handshake size={10} />
        <span>Account</span>
      </span>
    );
  }
  if (isLead) {
    return (
      <span className="badge-status badge-lead" style={{ fontSize: '0.68rem' }}>
        <Target size={10} />
        <span>Lead</span>
      </span>
    );
  }
  if (!client) return null;
  return (
    <button
      className="btn btn-lead btn-sm"
      onClick={() => {
        if (window.confirm(`Convert ${client.company || client.name} to an account?`)) onConvertToAccount(client.id);
      }}
      title="Convert to account"
      style={{ fontSize: '0.7rem', padding: '0.15rem 0.45rem' }}
    >
      <Handshake size={11} />
      <span>To Account</span>
    </button>
  );
}

export default function DashboardPage({
  stats,
  todayFollowups,
  upcomingMeetups,
  onOpenTodayModal,
  onOpenNewClient,
  onOpenNewFollowup,
  onOpenCompleteModal,
  clients = [],
  onConvertToAccount,
  setActiveTab
}) {
  const clientById = new Map(clients.map(c => [c.id, c]));
  const goTo = (tab) => ({
    role: 'button',
    tabIndex: 0,
    style: { cursor: 'pointer' },
    onClick: () => setActiveTab(tab),
    onKeyDown: (e) => { if (e.key === 'Enter') setActiveTab(tab); }
  });

  return (
    <div>
      {/* Today's follow-ups notice */}
      {stats?.today_followups_count > 0 && (
        <div className="today-reminder-banner">
          <div className="banner-content">
            <CalendarCheck size={18} color="var(--primary)" style={{ flexShrink: 0 }} />
            <div>
              <div style={{ fontSize: '0.88rem', fontWeight: 600, color: 'var(--text-primary)' }}>
                {stats.today_followups_count} follow-up{stats.today_followups_count === 1 ? '' : 's'} due today
              </div>
              <div style={{ fontSize: '0.78rem', color: 'var(--text-muted)' }}>
                {stats.high_priority_count || 0} high priority pending
              </div>
            </div>
          </div>
          <button 
            className="btn btn-secondary btn-sm" 
            onClick={onOpenTodayModal}
          >
            <span>Open agenda</span>
            <ArrowRight size={13} />
          </button>
        </div>
      )}

      {/* KPI Stats Grid — click a card to open that tab */}
      <div className="stats-grid">
        <div className="card stat-card" {...goTo('leads')} title="Open Leads">
          <div className="stat-header">
            <span className="stat-label">Leads</span>
            <div className="stat-icon">
              <Target size={15} />
            </div>
          </div>
          <div className="stat-value">{stats?.total_leads || 0}</div>
          <div className="stat-footer">
            <span>Imported and qualified leads</span>
          </div>
        </div>

        <div className="card stat-card" {...goTo('clients')} title="Open Clients">
          <div className="stat-header">
            <span className="stat-label">Clients</span>
            <div className="stat-icon">
              <Users size={15} />
            </div>
          </div>
          <div className="stat-value">{stats?.total_clients || 0}</div>
          <div className="stat-footer">
            <Star size={13} color="var(--prospect-row-accent)" />
            <span>{stats?.total_prospects || 0} marked prospect</span>
          </div>
        </div>

        <div className="card stat-card" {...goTo('accounts')} title="Open Accounts">
          <div className="stat-header">
            <span className="stat-label">Accounts</span>
            <div className="stat-icon">
              <Handshake size={15} />
            </div>
          </div>
          <div className="stat-value">{stats?.total_accounts || 0}</div>
          <div className="stat-footer">
            <TrendingUp size={13} color="var(--lead-action)" />
            <span>{stats?.conversion_rate || 0}% converted to accounts</span>
          </div>
        </div>

        <div className="card stat-card" {...goTo('today')} title="Open Today's Agenda">
          <div className="stat-header">
            <span className="stat-label">Follow-ups Due Today</span>
            <div className="stat-icon">
              <CalendarCheck size={15} />
            </div>
          </div>
          <div className="stat-value" style={{ color: stats?.today_followups_count > 0 ? 'var(--danger-color)' : 'var(--text-primary)' }}>
            {stats?.today_followups_count || 0}
          </div>
          <div className="stat-footer">
            {stats?.overdue_followups_count > 0 ? (
              <>
                <AlertTriangle size={13} color="var(--warning-strong)" />
                <span style={{ color: 'var(--warning-strong)', fontWeight: 600 }}>{stats.overdue_followups_count} overdue</span>
              </>
            ) : (
              <span>Nothing overdue</span>
            )}
          </div>
        </div>
      </div>

      {/* Two Column Section */}
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(min(100%, 320px), 1fr))', gap: '1.25rem', marginBottom: '1.5rem' }}>
        {/* Today's schedule */}
        <div className="card">
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '1rem', paddingBottom: '0.75rem', borderBottom: '1px solid var(--border-light)' }}>
            <div>
              <h3 style={{ fontSize: '0.95rem', fontWeight: 700, color: 'var(--text-primary)' }}>Today's Follow-up Schedule</h3>
              <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                Client meetups and calls scheduled for today
              </p>
            </div>
            <button 
              className="btn btn-secondary btn-sm"
              onClick={onOpenNewFollowup}
            >
              + Schedule
            </button>
          </div>

          {todayFollowups.length === 0 ? (
            <div style={{ textAlign: 'center', padding: '2.5rem 1rem', color: 'var(--text-muted)' }}>
              <CheckCircle2 size={32} color="var(--lead-action)" style={{ margin: '0 auto 0.5rem auto' }} />
              <p style={{ fontWeight: 600, color: 'var(--text-primary)', fontSize: '0.85rem' }}>All caught up for today!</p>
              <p style={{ fontSize: '0.75rem', marginTop: '0.15rem' }}>No pending follow-ups or meetups scheduled for today.</p>
            </div>
          ) : (
            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.65rem' }}>
              {todayFollowups.map((f) => {
                const isPending = f.status === 'Pending';
                const timeStr = new Date(f.scheduled_at).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
                return (
                  <div
                    key={f.id}
                    style={{
                      backgroundColor: isPending ? 'var(--bg-surface)' : 'var(--bg-subtle)',
                      border: '1px solid var(--border-subtle)',
                      borderRadius: 'var(--radius-md)',
                      padding: '0.85rem',
                      opacity: isPending ? 1 : 0.65,
                    }}
                  >
                    <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', marginBottom: '0.35rem' }}>
                      <div>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', marginBottom: '0.15rem' }}>
                          <span className={`badge-status badge-${f.priority.toLowerCase()}`}>
                            {f.priority}
                          </span>
                          <span style={{ fontSize: '0.72rem', color: 'var(--primary)', fontWeight: 600 }}>
                            {f.type}
                          </span>
                          <span style={{ fontSize: '0.72rem', color: 'var(--text-muted)' }}>
                            • {timeStr}
                          </span>
                        </div>
                        <div style={{ fontSize: '0.875rem', fontWeight: 600, color: 'var(--text-primary)' }}>
                          {f.title}
                        </div>
                      </div>

                      <ClientStageAction
                        client={clientById.get(f.client_id)}
                        isLead={f.client_is_lead}
                        onConvertToAccount={onConvertToAccount}
                      />
                    </div>

                    <div style={{ fontSize: '0.78rem', color: 'var(--text-muted)', marginBottom: '0.5rem' }}>
                      Client: <span style={{ color: 'var(--text-primary)', fontWeight: 500 }}>{f.client_name}</span>
                      {f.client_company ? ` (${f.client_company})` : ''}
                    </div>

                    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '0.4rem' }}>
                      {f.meeting_link ? (
                        <a 
                          href={f.meeting_link} 
                          target="_blank" 
                          rel="noreferrer" 
                          className="btn btn-secondary btn-sm"
                          style={{ fontSize: '0.725rem', padding: '0.2rem 0.5rem', color: 'var(--primary)' }}
                        >
                          <Video size={12} />
                          <span>Join Meeting</span>
                        </a>
                      ) : (
                        <span style={{ fontSize: '0.72rem', color: 'var(--text-muted)' }}>
                          <MapPin size={11} style={{ verticalAlign: '-1px', marginRight: '3px' }} />{f.location || 'Direct Call'}
                        </span>
                      )}

                      {isPending ? (
                        <button
                          className="btn btn-primary btn-sm"
                          onClick={() => onOpenCompleteModal(f)}
                          style={{ fontSize: '0.725rem', padding: '0.2rem 0.55rem' }}
                        >
                          <CheckCircle2 size={12} />
                          <span>Mark Complete</span>
                        </button>
                      ) : (
                        <span style={{ fontSize: '0.72rem', color: 'var(--lead-color)', fontWeight: 600 }}>
                          ✓ Completed
                        </span>
                      )}
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </div>

        {/* Upcoming Meetups */}
        <div className="card">
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '1rem', paddingBottom: '0.75rem', borderBottom: '1px solid var(--border-light)' }}>
            <div>
              <h3 style={{ fontSize: '0.95rem', fontWeight: 700, color: 'var(--text-primary)' }}>Upcoming Meetups & Demos</h3>
              <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                Scheduled client meetings for the coming days
              </p>
            </div>
            <button 
              className="btn btn-secondary btn-sm"
              onClick={() => setActiveTab('followups')}
            >
              View All
            </button>
          </div>

          {upcomingMeetups.length === 0 ? (
            <div style={{ textAlign: 'center', padding: '2.5rem 1rem', color: 'var(--text-muted)' }}>
              <Video size={32} style={{ margin: '0 auto 0.5rem auto', opacity: 0.3 }} />
              <p style={{ fontSize: '0.8rem' }}>No upcoming meetups scheduled</p>
            </div>
          ) : (
            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.65rem' }}>
              {upcomingMeetups.slice(0, 5).map((f) => {
                const dateStr = new Date(f.scheduled_at).toLocaleDateString([], { month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit' });
                return (
                  <div
                    key={f.id}
                    style={{
                      backgroundColor: 'var(--bg-surface)',
                      border: '1px solid var(--border-subtle)',
                      borderRadius: 'var(--radius-md)',
                      padding: '0.75rem 0.85rem',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'space-between',
                      gap: '0.65rem'
                    }}
                  >
                    <div>
                      <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', marginBottom: '0.15rem' }}>
                        <span style={{ fontSize: '0.72rem', fontWeight: 600, color: 'var(--primary)' }}>
                          {f.type}
                        </span>
                        <span style={{ fontSize: '0.72rem', color: 'var(--text-muted)' }}>
                          • {dateStr}
                        </span>
                      </div>
                      <div style={{ fontSize: '0.85rem', fontWeight: 600, color: 'var(--text-primary)' }}>
                        {f.title}
                      </div>
                      <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                        Client: {f.client_name} {f.client_company ? `(${f.client_company})` : ''}
                      </div>
                    </div>

                    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-end', gap: '0.25rem' }}>
                      <span className={`badge-status badge-${f.priority.toLowerCase()}`}>
                        {f.priority}
                      </span>
                      <ClientStageAction
                        client={clientById.get(f.client_id)}
                        isLead={f.client_is_lead}
                        onConvertToAccount={onConvertToAccount}
                      />
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
