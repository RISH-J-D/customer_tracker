import React, { useState } from 'react';
import { LayoutDashboard, Users, Target, Handshake, CalendarCheck, History, MoreHorizontal, ScrollText, FileSpreadsheet, Database } from 'lucide-react';

export default function MobileBottomNav({ activeTab, setActiveTab, todayCount, leadsCount, onOpenDbModal }) {
  const [isMoreOpen, setIsMoreOpen] = useState(false);

  const tabs = [
    { id: 'dashboard', label: 'Home', icon: LayoutDashboard },
    { id: 'leads', label: 'Leads', icon: Target, badge: leadsCount },
    { id: 'clients', label: 'Contacts', icon: Users },
    { id: 'accounts', label: 'Accounts', icon: Handshake },
    { id: 'today', label: 'Agenda', icon: CalendarCheck, badge: todayCount },
  ];

  // Pages that don't fit in the bottom bar
  const moreItems = [
    { id: 'followups', label: 'Follow-up History', icon: History },
    { id: 'logs', label: 'Activity Logs', icon: ScrollText },
    { id: 'export', label: 'Export Reports', icon: FileSpreadsheet },
  ];
  const isMoreActive = moreItems.some(item => item.id === activeTab);

  return (
    <>
      {isMoreOpen && (
        <div className="mobile-more-backdrop" onClick={() => setIsMoreOpen(false)}>
          <div className="mobile-more-sheet" onClick={(e) => e.stopPropagation()}>
            {moreItems.map(item => {
              const Icon = item.icon;
              return (
                <button
                  key={item.id}
                  className={`mobile-more-item ${activeTab === item.id ? 'active' : ''}`}
                  onClick={() => { setActiveTab(item.id); setIsMoreOpen(false); }}
                >
                  <Icon size={18} />
                  <span>{item.label}</span>
                </button>
              );
            })}
            {onOpenDbModal && (
              <button
                className="mobile-more-item"
                onClick={() => { onOpenDbModal(); setIsMoreOpen(false); }}
              >
                <Database size={18} />
                <span>Database</span>
              </button>
            )}
          </div>
        </div>
      )}

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
        <button
          className={`mobile-nav-btn ${isMoreActive || isMoreOpen ? 'active' : ''}`}
          onClick={() => setIsMoreOpen(open => !open)}
          aria-expanded={isMoreOpen}
        >
          <MoreHorizontal size={20} />
          <span>More</span>
        </button>
      </nav>
    </>
  );
}
