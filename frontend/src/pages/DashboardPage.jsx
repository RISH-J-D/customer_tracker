import React from 'react';
import { 
  Users, 
  Sparkles, 
  CalendarCheck, 
  Video, 
  TrendingUp, 
  DollarSign, 
  Clock, 
  ArrowRight, 
  CheckCircle2, 
  ExternalLink,
  ThumbsUp,
  Calendar
} from 'lucide-react';
import confetti from 'canvas-confetti';

export default function DashboardPage({
  stats,
  todayFollowups,
  upcomingMeetups,
  onOpenTodayModal,
  onOpenNewClient,
  onOpenNewFollowup,
  onOpenCompleteModal,
  onPromoteClientToLead,
  onSelectClient,
  setActiveTab
}) {
  const triggerLeadPromotion = (clientId) => {
    confetti({
      particleCount: 80,
      spread: 70,
      origin: { y: 0.6 }
    });
    onPromoteClientToLead(clientId);
  };

  return (
    <div>
      {/* Today's Follow-up Alert Banner (Linear Style) */}
      {stats?.today_followups_count > 0 && (
        <div className="today-reminder-banner">
          <div className="banner-content">
            <div className="banner-icon-pulse">
              <CalendarCheck size={18} />
            </div>
            <div>
              <div style={{ display: 'flex', alignItems: 'center', gap: '0.45rem', marginBottom: '0.15rem' }}>
                <span style={{
                  backgroundColor: '#DC2626',
                  color: 'white',
                  fontSize: '0.65rem',
                  fontWeight: 700,
                  padding: '0.1rem 0.4rem',
                  borderRadius: '999px',
                  textTransform: 'uppercase',
                  letterSpacing: '0.03em'
                }}>
                  Today's Action
                </span>
                <span style={{ fontSize: '0.785rem', color: '#1E40AF', fontWeight: 500 }}>
                  {stats.today_followups_count} client interactions scheduled for today
                </span>
              </div>
              <h3 style={{ fontSize: '0.985rem', fontWeight: 700, color: '#1E3A8A' }}>
                You have {stats.today_followups_count} client follow-ups due today.
              </h3>
            </div>
          </div>
          <button 
            className="btn btn-primary btn-sm" 
            onClick={onOpenTodayModal}
          >
            <span>View Today's Agenda</span>
            <ArrowRight size={13} />
          </button>
        </div>
      )}

      {/* KPI Stats Grid */}
      <div className="stats-grid">
        <div className="card stat-card">
          <div className="stat-header">
            <span className="stat-label">Total Clients</span>
            <div className="stat-icon">
              <Users size={15} />
            </div>
          </div>
          <div className="stat-value">{stats?.total_clients || 0}</div>
          <div className="stat-footer">
            <span>{stats?.clients_with_positive_approach || 0} with positive approach</span>
          </div>
        </div>

        <div className="card stat-card">
          <div className="stat-header">
            <span className="stat-label">Active Leads</span>
            <div className="stat-icon" style={{ color: '#059669', backgroundColor: '#ECFDF5' }}>
              <Sparkles size={15} />
            </div>
          </div>
          <div className="stat-value" style={{ color: '#065F46' }}>{stats?.total_leads || 0}</div>
          <div className="stat-footer" style={{ color: '#059669' }}>
            <TrendingUp size={13} />
            <span>{stats?.conversion_rate || 0}% Conversion Rate</span>
          </div>
        </div>

        <div className="card stat-card">
          <div className="stat-header">
            <span className="stat-label">Today's Due</span>
            <div className="stat-icon" style={{ color: stats?.today_followups_count > 0 ? '#DC2626' : 'var(--text-muted)', backgroundColor: stats?.today_followups_count > 0 ? '#FEF2F2' : 'var(--bg-hover)' }}>
              <CalendarCheck size={15} />
            </div>
          </div>
          <div className="stat-value" style={{ color: stats?.today_followups_count > 0 ? '#991B1B' : 'var(--text-primary)' }}>
            {stats?.today_followups_count || 0}
          </div>
          <div className="stat-footer">
            <span>{stats?.high_priority_count || 0} high priority pending</span>
          </div>
        </div>

        <div className="card stat-card">
          <div className="stat-header">
            <span className="stat-label">Upcoming Meetups</span>
            <div className="stat-icon" style={{ color: '#0284C7', backgroundColor: '#F0F9FF' }}>
              <Video size={15} />
            </div>
          </div>
          <div className="stat-value">{stats?.upcoming_meetups_count || 0}</div>
          <div className="stat-footer">
            <span>Scheduled meetings & calls</span>
          </div>
        </div>

        <div className="card stat-card">
          <div className="stat-header">
            <span className="stat-label">Pipeline Value</span>
            <div className="stat-icon" style={{ color: '#D97706', backgroundColor: '#FFFBEB' }}>
              <DollarSign size={15} />
            </div>
          </div>
          <div className="stat-value" style={{ fontSize: '1.45rem' }}>
            ${(stats?.total_pipeline_value || 0).toLocaleString()}
          </div>
          <div className="stat-footer">
            <span>Estimated deal volume</span>
          </div>
        </div>
      </div>

      {/* Two Column Section */}
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(360px, 1fr))', gap: '1.25rem', marginBottom: '1.5rem' }}>
        {/* Today's Action Center */}
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
              <CheckCircle2 size={32} color="#059669" style={{ margin: '0 auto 0.5rem auto' }} />
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

                      {/* Convert to Lead button */}
                      {!f.client_is_lead && isPending && (
                        <button
                          className="btn btn-lead btn-sm"
                          onClick={() => triggerLeadPromotion(f.client_id)}
                          title="Convert to Lead"
                          style={{ fontSize: '0.7rem', padding: '0.15rem 0.45rem' }}
                        >
                          <Sparkles size={11} />
                          <span>Convert to Lead</span>
                        </button>
                      )}
                      {f.client_is_lead && (
                        <span className="badge-status badge-lead" style={{ fontSize: '0.68rem' }}>
                          <Sparkles size={10} />
                          <span>Lead</span>
                        </span>
                      )}
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
                          style={{ fontSize: '0.725rem', padding: '0.2rem 0.5rem', color: '#0284C7' }}
                        >
                          <Video size={12} />
                          <span>Join Meeting</span>
                        </a>
                      ) : (
                        <span style={{ fontSize: '0.72rem', color: 'var(--text-muted)' }}>
                          📍 {f.location || 'Direct Call'}
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
                      {f.client_is_lead ? (
                        <span className="badge-status badge-lead" style={{ fontSize: '0.65rem' }}>
                          Lead
                        </span>
                      ) : (
                        <button
                          className="btn btn-secondary btn-sm"
                          onClick={() => triggerLeadPromotion(f.client_id)}
                          style={{ fontSize: '0.65rem', padding: '0.15rem 0.35rem' }}
                        >
                          <Sparkles size={10} color="#059669" />
                          <span>Make Lead</span>
                        </button>
                      )}
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
