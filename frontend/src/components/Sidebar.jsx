import React from 'react';
import { 
  LayoutDashboard, 
  Users, 
  CalendarCheck, 
  History,
  FileSpreadsheet, 
  Target, 
  TrendingUp,
  Database,
  ScrollText,
  Handshake
} from 'lucide-react';

export default function Sidebar({ 
  activeTab, 
  setActiveTab, 
  stats, 
  onOpenTodayModal,
  onOpenDbModal,
  onOpenLogin,
  dbInfo,
  currentUser
}) {

  const isPostgres = dbInfo?.is_postgres || dbInfo?.engine === 'postgresql';

  const navItems = [
    { id: 'dashboard', label: 'Dashboard', icon: LayoutDashboard },
    { 
      id: 'leads', 
      label: 'Leads', 
      icon: Target,
      badge: stats?.total_leads ? `${stats.total_leads}` : null,
      badgeColor: 'lead'
    },
    { 
      id: 'clients', 
      label: 'Contacts', 
      icon: Users,
      badge: stats ? `${stats.total_clients || 0}` : null
    },
    {
      id: 'accounts',
      label: 'Accounts',
      icon: Handshake,
      badge: stats?.total_accounts ? `${stats.total_accounts}` : null
    },
    { 
      id: 'today', 
      label: "Today's Agenda", 
      icon: CalendarCheck,
      badge: stats?.today_followups_count > 0 ? `${stats.today_followups_count}` : null,
      badgeColor: 'alert'
    },
    { id: 'followups', label: 'Follow-up History', icon: History },
    { id: 'logs', label: 'Activity Logs', icon: ScrollText },
    { id: 'export', label: 'Export Reports', icon: FileSpreadsheet },
  ];

  const currentName = currentUser?.name || 'Admin';
  const currentUsername = currentUser?.username || 'admin';
  const currentRole = currentUser?.role || 'System Administrator';

  return (
    <aside className="sidebar">
      {/* Brand Header */}
      <div className="sidebar-logo">
        <div className="sidebar-logo-icon">CF</div>
        <div>
          <div className="sidebar-logo-text">ClientFlow</div>
          <div className="sidebar-logo-sub">Steel Detailing CRM</div>
        </div>
      </div>

      {/* Navigation items */}
      <nav className="nav-links">
        {navItems.map((item) => {
          const Icon = item.icon;
          const isActive = activeTab === item.id;
          return (
            <button
              key={item.id}
              className={`nav-item ${isActive ? 'active' : ''}`}
              onClick={() => setActiveTab(item.id)}
            >
              <Icon size={16} />
              <span>{item.label}</span>
              {item.badge && (
                <span className={`badge ${item.badgeColor === 'lead' ? 'badge-lead' : item.badgeColor === 'alert' ? 'badge-alert' : ''}`}>
                  {item.badge}
                </span>
              )}
            </button>
          );
        })}
      </nav>

      {/* Database Status Pill for pgAdmin Controls */}
      <div 
        onClick={onOpenDbModal}
        style={{
          marginTop: 'auto',
          marginBottom: '0.65rem',
          backgroundColor: 'var(--bg-subtle)',
          border: '1px solid var(--border-subtle)',
          borderRadius: 'var(--radius-md)',
          padding: '0.65rem 0.75rem',
          cursor: 'pointer',
          transition: 'all 0.15s ease'
        }}
        title="Click to view database controls and pgAdmin connection info"
      >
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '0.2rem' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.4rem' }}>
            <Database size={13} color={isPostgres ? 'var(--lead-action)' : 'var(--primary)'} />
            <span style={{ fontSize: '0.72rem', fontWeight: 600, color: 'var(--text-primary)' }}>
              {isPostgres ? 'PostgreSQL Active' : 'pgAdmin Ready'}
            </span>
          </div>
          <span style={{
            width: '7px',
            height: '7px',
            borderRadius: '50%',
            backgroundColor: isPostgres ? 'var(--lead-action)' : 'var(--warning-strong)'
          }}></span>
        </div>
        <div style={{ fontSize: '0.68rem', color: 'var(--text-muted)' }}>
          DB Controls & Schema Manager
        </div>
      </div>

      {/* User Status Card */}
      <div style={{
        backgroundColor: 'var(--bg-subtle)',
        border: '1px solid var(--border-subtle)',
        borderRadius: 'var(--radius-md)',
        padding: '0.65rem 0.75rem',
        marginBottom: '0.65rem',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
        cursor: 'default'
      }}
      title={`Signed in as ${currentName}`}
      >
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', minWidth: 0 }}>
          <div style={{
            width: '28px',
            height: '28px',
            borderRadius: '50%',
            background: currentUsername === 'admin' 
              ? 'linear-gradient(135deg, var(--lead-action), var(--lead-action))' 
              : 'var(--avatar-bg)',
            color: 'white',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            fontSize: '0.72rem',
            fontWeight: 700,
            flexShrink: 0
          }}>
            {currentName[0]}
          </div>
          <div style={{ minWidth: 0 }}>
            <div style={{ 
              fontSize: '0.76rem', 
              fontWeight: 700, 
              color: 'var(--text-primary)',
              overflow: 'hidden',
              textOverflow: 'ellipsis',
              whiteSpace: 'nowrap'
            }}>
              {currentName}
            </div>
            <div style={{ fontSize: '0.65rem', color: 'var(--text-muted)' }}>
              @{currentUsername}
            </div>
          </div>
        </div>
        <span style={{
          width: '6px',
          height: '6px',
          borderRadius: '50%',
          backgroundColor: 'var(--lead-action)'
        }} title="Active Session"></span>
      </div>
    </aside>
  );
}
