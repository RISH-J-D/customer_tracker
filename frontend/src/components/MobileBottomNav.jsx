import React from 'react';
import { LayoutDashboard, Users, Sparkles, CalendarCheck, Calendar } from 'lucide-react';

export default function MobileBottomNav({ activeTab, setActiveTab, todayCount, leadsCount }) {
  const tabs = [
    { id: 'dashboard', label: 'Dashboard', icon: LayoutDashboard },
    { id: 'clients', label: 'Clients', icon: Users },
    { id: 'leads', label: 'Leads', icon: Sparkles, badge: leadsCount },
    { id: 'today', label: 'Today', icon: CalendarCheck, badge: todayCount },
    { id: 'followups', label: 'Meetups', icon: Calendar },
  ];


  return (
    <nav className="mobile-bottom-nav">
      {tabs.map((tab) => {
        const Icon = tab.icon;
        const isActive = activeTab === tab.id;
        return (
          <button
            key={tab.id}
            className={`mobile-nav-btn ${isActive ? 'active' : ''}`}
            onClick={() => setActiveTab(tab.id)}
          >
            <Icon size={20} />
            <span>{tab.label}</span>
            {tab.badge > 0 && <span className="mobile-nav-badge">{tab.badge}</span>}
          </button>
        );
      })}
    </nav>
  );
}
