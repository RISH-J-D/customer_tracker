import React from 'react';
import { 
  LayoutDashboard, 
  Users, 
  CalendarCheck, 
  History,
  FileSpreadsheet, 
  Target, 
  TrendingUp,
  ScrollText,
  Handshake
} from 'lucide-react';

export default function Sidebar({ 
  activeTab, 
  setActiveTab, 
  stats, 
  onOpenTodayModal,
  onOpenLogin,
  currentUser
}) {

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
        <img className="sidebar-logo-icon" src="/tendon-mark.png" alt="" />
        <div>
          <div className="sidebar-logo-text">Tendon CRM</div>
          <div className="sidebar-logo-sub">Steel Detailing &amp; Fabrication</div>
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

      {/* User Status Card */}
      <div style={{
        marginTop: 'auto',
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
