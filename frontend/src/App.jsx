import React, { useState, useEffect, useCallback } from 'react';
import { api } from './services/api';
import { notificationService } from './services/notifications';

// Components
import Sidebar from './components/Sidebar';
import Navbar from './components/Navbar';
import MobileBottomNav from './components/MobileBottomNav';
import NotificationCenterModal from './components/NotificationCenterModal';
import TodayReminderModal from './components/TodayReminderModal';
import ClientModal from './components/ClientModal';
import FollowUpModal from './components/FollowUpModal';
import CompleteFollowupModal from './components/CompleteFollowupModal';
import ExportModal from './components/ExportModal';
import ImportExcelModal from './components/ImportExcelModal';
import DbControlModal from './components/DbControlModal';
import AccountModal from './components/AccountModal';

// Pages
import DashboardPage from './pages/DashboardPage';
import ClientsPage from './pages/ClientsPage';
import LeadsPage from './pages/LeadsPage';
import AccountsPage from './pages/AccountsPage';
import FollowUpsPage from './pages/FollowUpsPage';
import LogsPage from './pages/LogsPage';
import LoginPage from './pages/LoginPage';

export default function App() {
  const [activeTab, setActiveTab] = useState('dashboard');
  const [theme, setTheme] = useState(() => localStorage.getItem('theme') || 'light');
  const [currentUser, setCurrentUser] = useState(() => {
    try {
      const saved = localStorage.getItem('currentUser');
      return saved ? JSON.parse(saved) : { username: 'admin', name: 'Admin', role: 'System Administrator' };
    } catch {
      return { username: 'admin', name: 'Admin', role: 'System Administrator' };
    }
  });
  const [clients, setClients] = useState([]);
  const [accounts, setAccounts] = useState(() => {
    try {
      const saved = localStorage.getItem('cached_accounts_count');
      return saved ? new Array(parseInt(saved, 10)).fill({}) : [];
    } catch {
      return [];
    }
  });
  const [followups, setFollowups] = useState([]);
  const [todayFollowups, setTodayFollowups] = useState([]);
  const [upcomingMeetups, setUpcomingMeetups] = useState([]);
  const [stats, setStats] = useState(() => {
    try {
      const saved = localStorage.getItem('cached_stats');
      return saved ? JSON.parse(saved) : null;
    } catch {
      return null;
    }
  });
  const [notifications, setNotifications] = useState([]);
  const [dbInfo, setDbInfo] = useState(null);
  const [showLoginPage, setShowLoginPage] = useState(false);

  // Apply theme to document root
  useEffect(() => {
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem('theme', theme);
  }, [theme]);

  const toggleTheme = () => {
    setTheme(prev => prev === 'light' ? 'dark' : 'light');
  };

  // Modals
  const [isTodayModalOpen, setIsTodayModalOpen] = useState(false);
  const [isNotificationsOpen, setIsNotificationsOpen] = useState(false);
  const [isClientModalOpen, setIsClientModalOpen] = useState(false);
  const [editingClient, setEditingClient] = useState(null);
  const [isLeadModalMode, setIsLeadModalMode] = useState(false);
  const [isAccountModalOpen, setIsAccountModalOpen] = useState(false);
  const [editingAccount, setEditingAccount] = useState(null);
  const [prefilledClientForAccount, setPrefilledClientForAccount] = useState(null);
  const [isFollowupModalOpen, setIsFollowupModalOpen] = useState(false);
  const [preselectedClientId, setPreselectedClientId] = useState('');
  const [isCompleteModalOpen, setIsCompleteModalOpen] = useState(false);
  const [activeFollowupToComplete, setActiveFollowupToComplete] = useState(null);
  const [isExportModalOpen, setIsExportModalOpen] = useState(false);
  const [exportModalType, setExportModalType] = useState('clients');
  const [isImportModalOpen, setIsImportModalOpen] = useState(false);
  const [importModalMode, setImportModalMode] = useState('clients');
  const [isDbModalOpen, setIsDbModalOpen] = useState(false);

  // Load all app data
  const loadData = useCallback(async () => {
    // 1. Fetch dashboard stats & DB status immediately (fast: ~100ms)
    api.getDashboardStats().then(st => {
      if (st) {
        setStats(st);
        try { localStorage.setItem('cached_stats', JSON.stringify(st)); } catch {}
      }
    }).catch(err => console.error('Error fetching dashboard stats:', err));

    api.getDbStatus().then(status => {
      if (status) setDbInfo(status);
    }).catch(() => null);

    // 2. Fetch full lists with Promise.allSettled so no single slow query blocks other data
    try {
      const [clsRes, accsRes, flwsRes, tFlwsRes, uFlwsRes, notifsRes] = await Promise.allSettled([
        api.getClients(),
        api.getAccounts(),
        api.getFollowups(),
        api.getFollowups({ today_only: true }),
        api.getFollowups({ upcoming_only: true }),
        api.getNotifications()
      ]);

      if (clsRes.status === 'fulfilled' && clsRes.value) {
        setClients(clsRes.value);
      }
      if (accsRes.status === 'fulfilled' && accsRes.value) {
        setAccounts(accsRes.value);
        try { localStorage.setItem('cached_accounts_count', String(accsRes.value.length)); } catch {}
      }
      if (flwsRes.status === 'fulfilled' && flwsRes.value) {
        setFollowups(flwsRes.value);
      }
      if (tFlwsRes.status === 'fulfilled' && tFlwsRes.value) {
        setTodayFollowups(tFlwsRes.value);
      }
      if (uFlwsRes.status === 'fulfilled' && uFlwsRes.value) {
        setUpcomingMeetups(uFlwsRes.value);
      }
      if (notifsRes.status === 'fulfilled' && notifsRes.value) {
        setNotifications(notifsRes.value);
      }
    } catch (err) {
      console.error('Error fetching tracker data:', err);
    }
  }, []);

  // Initial mount & reminder checker
  useEffect(() => {
    loadData();

    // Request notification permission once user interacts
    notificationService.requestPermission();

    // Check reminders periodically every 25 seconds
    const interval = setInterval(async () => {
      try {
        const checkResult = await api.checkReminders();
        if (checkResult.new_notifications > 0) {
          notificationService.send({
            title: "Steel Detailing Follow-up Alert!",
            body: `You have ${checkResult.new_notifications} pending follow-up reminder(s) due today.`
          });
          loadData();
        }
      } catch {
        // quiet in background
      }
    }, 25000);

    return () => clearInterval(interval);
  }, [loadData]);

  // Client actions
  const handleSaveClient = async (formData, clientId) => {
    if (clientId) {
      await api.updateClient(clientId, formData);
    } else {
      await api.createClient(formData);
    }
    await loadData();
  };

  const handleDeleteClient = async (clientId) => {
    if (window.confirm('Are you sure you want to delete this record and all associated follow-ups?')) {
      await api.deleteClient(clientId);
      await loadData();
    }
  };

  const handlePromoteToLead = async (clientId) => {
    try {
      await api.promoteToLead(clientId);
      notificationService.playChime();
      await loadData();
    } catch (err) {
      alert('Error promoting to lead: ' + err.message);
    }
  };

  const handleTogglePositive = async (clientId) => {
    try {
      await api.togglePositive(clientId);
      await loadData();
    } catch (err) {
      alert('Error toggling positive status: ' + err.message);
    }
  };

  const handleUpdateClientNotes = async (clientId, notes) => {
    try {
      await api.updateClient(clientId, { notes });
      setClients(prev => prev.map(c => c.id === clientId ? { ...c, notes } : c));
    } catch (err) {
      console.error('Error updating notes:', err);
    }
  };

  // Account actions
  const handleSaveAccount = async (formData, accountId) => {
    if (accountId) {
      await api.updateAccount(accountId, formData);
    } else {
      await api.createAccount(formData);
    }
    notificationService.send({
      title: "Corporate Account Saved",
      body: `${formData.project_name || formData.account_title || 'Project'} has been recorded.`
    });
    await loadData();
  };

  const handleDeleteAccount = async (accountId) => {
    if (window.confirm('Are you sure you want to delete this project account record?')) {
      await api.deleteAccount(accountId);
      await loadData();
    }
  };

  const handleConvertToAccount = (leadOrClient) => {
    setPrefilledClientForAccount(leadOrClient);
    setEditingAccount(null);
    setIsAccountModalOpen(true);
  };

  // Follow-up actions
  const handleSaveFollowup = async (formData) => {
    await api.createFollowup(formData);
    notificationService.send({
      title: "Follow-up Scheduled",
      body: `${formData.title} has been added to your calendar.`
    });
    await loadData();
  };

  const handleCompleteFollowup = async (followupId, options) => {
    await api.completeFollowup(followupId, options);
    await loadData();
  };

  const handleDeleteFollowup = async (followupId) => {
    if (window.confirm('Delete this follow-up record?')) {
      await api.deleteFollowup(followupId);
      await loadData();
    }
  };

  // Notification actions
  const handleMarkNotifRead = async (id) => {
    await api.markNotificationRead(id);
    setNotifications(prev => prev.map(n => n.id === id ? { ...n, is_read: true } : n));
  };

  const handleMarkAllNotifsRead = async () => {
    await api.markAllNotificationsRead();
    setNotifications(prev => prev.map(n => ({ ...n, is_read: true })));
  };

  // Title info based on active tab
  const getHeaderInfo = () => {
    switch (activeTab) {
      case 'dashboard':
        return { title: 'Dashboard', subtitle: 'Overview of follow-ups, clients, and conversion metrics' };
      case 'clients':
        return { title: 'Clients', subtitle: 'Steel Detailing prospective accounts and outreach pipeline' };
      case 'leads':
        return { title: 'Qualified Leads', subtitle: 'Converted Steel Detailing projects and active proposals' };
      case 'accounts':
        return { title: 'Corporate Accounts & Projects', subtitle: 'Manage converted client accounts, multiple project detailing orders & representatives' };
      case 'today':
        return { title: "Today's Agenda", subtitle: "Scheduled meetings, demos, and follow-ups due today" };
      case 'followups':
        return { title: 'Meetups & Schedule', subtitle: 'Full calendar of upcoming and past client interactions' };
      case 'logs':
        return { title: 'Activity Logs', subtitle: 'Complete audit trail of all changes made across the CRM' };
      case 'export':
        return { title: 'Export Reports', subtitle: 'Download client and lead lists in Excel, PDF, or CSV' };
      default:
        return { title: 'ClientFlow Tracker', subtitle: '' };
    }
  };

  const unreadCount = notifications.filter(n => !n.is_read).length;
  const headerInfo = getHeaderInfo();

  // If user is not logged in or login screen is requested
  if (!currentUser || showLoginPage) {
    return (
      <LoginPage
        onLoginSuccess={(user) => {
          if (user) {
            setCurrentUser(user);
            localStorage.setItem('currentUser', JSON.stringify(user));
          }
          setShowLoginPage(false);
          loadData();
        }}
        theme={theme}
        onToggleTheme={toggleTheme}
        dbInfo={dbInfo}
      />
    );
  }

  return (
    <div className="app-container">
      {/* Desktop Sidebar */}
      <Sidebar
        activeTab={activeTab}
        setActiveTab={setActiveTab}
        stats={stats}
        accountsCount={accounts.length}
        unreadNotificationsCount={unreadCount}
        onOpenTodayModal={() => setIsTodayModalOpen(true)}
        onOpenDbModal={() => setIsDbModalOpen(true)}
        dbInfo={dbInfo}
        currentUser={currentUser}
      />

      <div className="main-wrapper">
        {/* Top Navbar */}
        <Navbar
          title={headerInfo.title}
          subtitle={headerInfo.subtitle}
          unreadCount={unreadCount}
          onOpenNotifications={() => setIsNotificationsOpen(true)}
          onOpenTodayModal={() => setIsTodayModalOpen(true)}
          todayCount={stats?.today_followups_count || 0}
          theme={theme}
          onToggleTheme={toggleTheme}
          currentUser={currentUser}
          onLogout={() => {
            localStorage.removeItem('currentUser');
            setCurrentUser(null);
            setShowLoginPage(true);
          }}
        />

        {/* Content Area */}
        <main className="page-content">
          {activeTab === 'dashboard' && (
            <DashboardPage
              stats={stats}
              todayFollowups={todayFollowups}
              upcomingMeetups={upcomingMeetups}
              onOpenTodayModal={() => setIsTodayModalOpen(true)}
              onOpenNewClient={() => {
                setEditingClient(null);
                setIsLeadModalMode(false);
                setIsClientModalOpen(true);
              }}
              onOpenNewFollowup={() => {
                setPreselectedClientId('');
                setIsFollowupModalOpen(true);
              }}
              onOpenCompleteModal={(f) => {
                setActiveFollowupToComplete(f);
                setIsCompleteModalOpen(true);
              }}
              onPromoteClientToLead={handlePromoteToLead}
              onSelectClient={() => {
                setActiveTab('clients');
              }}
              setActiveTab={setActiveTab}
            />
          )}

          {activeTab === 'clients' && (
            <ClientsPage
              clients={clients}
              onOpenNewClient={() => {
                setEditingClient(null);
                setIsLeadModalMode(false);
                setIsClientModalOpen(true);
              }}
              onEditClient={(c) => {
                setEditingClient(c);
                setIsLeadModalMode(false);
                setIsClientModalOpen(true);
              }}
              onDeleteClient={handleDeleteClient}
              onPromoteClientToLead={handlePromoteToLead}
              onTogglePositive={handleTogglePositive}
              onConvertToAccount={handleConvertToAccount}
              onScheduleFollowupForClient={(clientId) => {
                setPreselectedClientId(String(clientId));
                setIsFollowupModalOpen(true);
              }}
              onOpenExportModal={() => {
                setExportModalType('clients');
                setIsExportModalOpen(true);
              }}
              onOpenImportModal={() => {
                setImportModalMode('clients');
                setIsImportModalOpen(true);
              }}
              onUpdateNotes={handleUpdateClientNotes}
            />
          )}

          {activeTab === 'leads' && (
            <LeadsPage
              leads={clients}
              onOpenNewLead={() => {
                setEditingClient(null);
                setIsLeadModalMode(true);
                setIsClientModalOpen(true);
              }}
              onEditLead={(c) => {
                setEditingClient(c);
                setIsLeadModalMode(true);
                setIsClientModalOpen(true);
              }}
              onDeleteLead={handleDeleteClient}
              onTogglePositive={handleTogglePositive}
              onConvertToAccount={handleConvertToAccount}
              onScheduleFollowupForLead={(clientId) => {
                setPreselectedClientId(String(clientId));
                setIsFollowupModalOpen(true);
              }}
              onRevertToClient={async (clientId) => {
                await api.updateClient(clientId, { is_lead: false, status: 'Prospect' });
                await loadData();
              }}
              onOpenExportModal={() => {
                setExportModalType('clients');
                setIsExportModalOpen(true);
              }}
              onOpenImportModal={() => {
                setImportModalMode('clients');
                setIsImportModalOpen(true);
              }}
              onUpdateNotes={handleUpdateClientNotes}
            />
          )}

          {activeTab === 'accounts' && (
            <AccountsPage
              accounts={accounts}
              clients={clients}
              onOpenNewAccount={(pref) => {
                setEditingAccount(null);
                setPrefilledClientForAccount(pref && pref.company ? {
                  company: pref.company,
                  name: pref.client_representative || '',
                  email: pref.rep_email || '',
                  phone: pref.rep_phone || '',
                  client_id: pref.client_id || null
                } : null);
                setIsAccountModalOpen(true);
              }}
              onEditAccount={(acc) => {
                setEditingAccount(acc);
                setPrefilledClientForAccount(null);
                setIsAccountModalOpen(true);
              }}
              onDeleteAccount={handleDeleteAccount}
              onConvertToAccount={handleConvertToAccount}
              onOpenExportModal={() => {
                setExportModalType('accounts');
                setIsExportModalOpen(true);
              }}
              onOpenImportModal={() => {
                setImportModalMode('accounts');
                setIsImportModalOpen(true);
              }}
            />
          )}

          {(activeTab === 'followups' || activeTab === 'today') && (
            <FollowUpsPage
              followups={activeTab === 'today' ? todayFollowups : followups}
              onOpenNewFollowup={() => {
                setPreselectedClientId('');
                setIsFollowupModalOpen(true);
              }}
              onOpenCompleteModal={(f) => {
                setActiveFollowupToComplete(f);
                setIsCompleteModalOpen(true);
              }}
              onDeleteFollowup={handleDeleteFollowup}
              onPromoteClientToLead={handlePromoteToLead}
              onOpenExportModal={() => setIsExportModalOpen(true)}
            />
          )}

          {activeTab === 'logs' && (
            <LogsPage />
          )}

          {activeTab === 'export' && (
            <div className="card" style={{ maxWidth: '640px', margin: '1rem auto' }}>
              <div style={{ textAlign: 'center', marginBottom: '1.5rem' }}>
                <h3 style={{ fontSize: '1.35rem', fontWeight: 800 }}>Export Reports</h3>
                <p style={{ fontSize: '0.85rem', color: 'var(--text-muted)' }}>
                  Download client and lead datasets in formatted Excel, PDF, or CSV
                </p>
              </div>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
                <button
                  className="btn btn-primary"
                  onClick={() => setIsExportModalOpen(true)}
                  style={{ padding: '0.85rem 1.25rem', fontSize: '1rem' }}
                >
                  Open Export Center (Excel, PDF, CSV)
                </button>
              </div>
            </div>
          )}
        </main>

        {/* Mobile Bottom Navigation */}
        <MobileBottomNav
          activeTab={activeTab}
          setActiveTab={setActiveTab}
          todayCount={stats?.today_followups_count || 0}
          leadsCount={stats?.total_leads || 0}
        />
      </div>

      {/* Modals */}
      <NotificationCenterModal
        isOpen={isNotificationsOpen}
        onClose={() => setIsNotificationsOpen(false)}
        notifications={notifications}
        onMarkRead={handleMarkNotifRead}
        onMarkAllRead={handleMarkAllNotifsRead}
        onRequestPermission={() => notificationService.requestPermission()}
      />

      <TodayReminderModal
        isOpen={isTodayModalOpen}
        onClose={() => setIsTodayModalOpen(false)}
        todayFollowups={todayFollowups}
        onOpenCompleteModal={(f) => {
          setIsTodayModalOpen(false);
          setActiveFollowupToComplete(f);
          setIsCompleteModalOpen(true);
        }}
        onPromoteClientToLead={handlePromoteToLead}
        onSelectClient={() => {
          setIsTodayModalOpen(false);
          setActiveTab('clients');
        }}
      />

      <ClientModal
        isOpen={isClientModalOpen}
        onClose={() => setIsClientModalOpen(false)}
        client={editingClient}
        onSave={handleSaveClient}
        isLeadMode={isLeadModalMode}
      />

      <FollowUpModal
        isOpen={isFollowupModalOpen}
        onClose={() => setIsFollowupModalOpen(false)}
        clients={clients}
        preselectedClientId={preselectedClientId}
        onSave={handleSaveFollowup}
      />

      <CompleteFollowupModal
        isOpen={isCompleteModalOpen}
        onClose={() => setIsCompleteModalOpen(false)}
        followup={activeFollowupToComplete}
        onComplete={handleCompleteFollowup}
      />

      <ExportModal
        isOpen={isExportModalOpen}
        onClose={() => setIsExportModalOpen(false)}
        stats={stats}
        defaultType={exportModalType}
      />

      <ImportExcelModal
        isOpen={isImportModalOpen}
        onClose={() => setIsImportModalOpen(false)}
        mode={importModalMode}
        onImportSuccess={() => loadData()}
      />

      <AccountModal
        isOpen={isAccountModalOpen}
        onClose={() => {
          setIsAccountModalOpen(false);
          setEditingAccount(null);
          setPrefilledClientForAccount(null);
        }}
        account={editingAccount}
        prefilledClient={prefilledClientForAccount}
        clients={clients}
        onSave={handleSaveAccount}
      />

      <DbControlModal
        isOpen={isDbModalOpen}
        onClose={() => setIsDbModalOpen(false)}
        dbInfo={dbInfo}
      />
    </div>
  );
}
