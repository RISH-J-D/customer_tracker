import React, { useState, useEffect } from 'react';
import { 
  ScrollText, 
  Search, 
  RefreshCw, 
  Filter, 
  User, 
  Calendar, 
  Clock, 
  CheckCircle2, 
  Target, 
  UploadCloud, 
  LogIn, 
  Trash2, 
  Edit3, 
  PlusCircle, 
  CalendarPlus, 
  ChevronDown, 
  ChevronUp,
  ShieldCheck,
  Tag,
  ArrowRight
} from 'lucide-react';
import { api } from '../services/api';

export default function LogsPage() {
  const [logs, setLogs] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [selectedUser, setSelectedUser] = useState('all');
  const [selectedAction, setSelectedAction] = useState('all');
  const [expandedLogId, setExpandedLogId] = useState(null);
  const [stats, setStats] = useState({ total: 0, today: 0, users: 3 });

  const fetchLogs = async () => {
    setIsLoading(true);
    try {
      const params = {};
      if (selectedAction !== 'all') params.action = selectedAction;
      if (selectedUser !== 'all') params.user = selectedUser;
      if (search.trim()) params.search = search.trim();

      const data = await api.getLogs(params);
      setLogs(data);

      // Simple metrics
      const todayStr = new Date().toISOString().slice(0, 10);
      const todayCount = data.filter(l => l.created_at && l.created_at.startsWith(todayStr)).length;
      setStats({
        total: data.length,
        today: todayCount,
        users: 3
      });
    } catch (err) {
      console.error('Failed to load activity logs:', err);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchLogs();
  }, [selectedAction, selectedUser]);

  const handleSearchSubmit = (e) => {
    e.preventDefault();
    fetchLogs();
  };

  const getActionBadge = (action) => {
    switch (action) {
      case 'CONVERT_LEAD':
        return {
          label: 'Lead Converted',
          color: 'var(--lead-action)',
          bg: 'var(--lead-surface)',
          border: 'var(--lead-border)',
          icon: Target
        };
      case 'CREATE_CLIENT':
      case 'CREATE_LEAD':
        return {
          label: 'Created',
          color: 'var(--lead-action)',
          bg: 'rgba(16, 185, 129, 0.1)',
          border: 'rgba(16, 185, 129, 0.25)',
          icon: PlusCircle
        };
      case 'UPDATE_CLIENT':
      case 'UPDATE_FOLLOWUP':
        return {
          label: 'Updated',
          color: 'var(--primary)',
          bg: 'rgba(59, 130, 246, 0.1)',
          border: 'rgba(59, 130, 246, 0.25)',
          icon: Edit3
        };
      case 'COMPLETE_FOLLOWUP':
        return {
          label: 'Followup Done',
          color: 'var(--lead-action)',
          bg: 'rgba(5, 150, 105, 0.12)',
          border: 'rgba(5, 150, 105, 0.25)',
          icon: CheckCircle2
        };
      case 'SCHEDULE_FOLLOWUP':
        return {
          label: 'Scheduled',
          color: 'var(--warning-strong)',
          bg: 'rgba(245, 158, 11, 0.1)',
          border: 'rgba(245, 158, 11, 0.25)',
          icon: CalendarPlus
        };
      case 'IMPORT_EXCEL':
        return {
          label: 'Excel Import',
          color: 'var(--primary)',
          bg: 'rgba(139, 92, 246, 0.1)',
          border: 'rgba(139, 92, 246, 0.25)',
          icon: UploadCloud
        };
      case 'LOGIN':
        return {
          label: 'Signed In',
          color: 'var(--primary)',
          bg: 'rgba(99, 102, 241, 0.1)',
          border: 'rgba(99, 102, 241, 0.25)',
          icon: LogIn
        };
      case 'DELETE_CLIENT':
      case 'DELETE_FOLLOWUP':
        return {
          label: 'Deleted',
          color: 'var(--danger-btn)',
          bg: 'rgba(239, 68, 68, 0.1)',
          border: 'rgba(239, 68, 68, 0.25)',
          icon: Trash2
        };
      default:
        return {
          label: action || 'Modified',
          color: 'var(--text-secondary)',
          bg: 'var(--bg-subtle)',
          border: 'var(--border-subtle)',
          icon: Tag
        };
    }
  };

  const formatTimestamp = (isoString) => {
    if (!isoString) return '';
    try {
      const date = new Date(isoString);
      return date.toLocaleString('en-US', {
        month: 'short',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
      });
    } catch {
      return isoString;
    }
  };

  const parseChanges = (changesRaw) => {
    if (!changesRaw) return null;
    try {
      if (typeof changesRaw === 'object') return changesRaw;
      return JSON.parse(changesRaw);
    } catch {
      return null;
    }
  };

  return (
    <div className="page-container" style={{ paddingBottom: '3rem' }}>
      {/* Top Banner & Title */}
      <div style={{
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'flex-end',
        flexWrap: 'wrap',
        gap: '1rem',
        marginBottom: '1.25rem'
      }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
          <button
            onClick={fetchLogs}
            className="btn btn-secondary btn-sm"
            disabled={isLoading}
            style={{ display: 'flex', alignItems: 'center', gap: '0.4rem' }}
          >
            <RefreshCw size={13} className={isLoading ? 'spin-icon' : ''} />
            <span>{isLoading ? 'Refreshing...' : 'Refresh'}</span>
          </button>
        </div>
      </div>

      {/* Metrics Row */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))',
        gap: '0.85rem',
        marginBottom: '1.25rem'
      }}>
        <div className="card" style={{ padding: '0.95rem 1.15rem' }}>
          <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', fontWeight: 600, textTransform: 'uppercase' }}>
            Total Events Logged
          </div>
          <div style={{ fontSize: '1.65rem', fontWeight: 800, color: 'var(--text-primary)', marginTop: '0.2rem' }}>
            {stats.total}
          </div>
          <div style={{ fontSize: '0.7rem', color: 'var(--text-secondary)', marginTop: '0.2rem' }}>
            Permanent PostgreSQL history
          </div>
        </div>

        <div className="card" style={{ padding: '0.95rem 1.15rem' }}>
          <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', fontWeight: 600, textTransform: 'uppercase' }}>
            Active Operators
          </div>
          <div style={{ fontSize: '1.65rem', fontWeight: 800, color: 'var(--primary)', marginTop: '0.2rem' }}>
            3 Users
          </div>
          <div style={{ fontSize: '0.7rem', color: 'var(--text-secondary)', marginTop: '0.2rem' }}>
            Abarna S, Girish J, Admin
          </div>
        </div>

        <div className="card" style={{ padding: '0.95rem 1.15rem' }}>
          <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', fontWeight: 600, textTransform: 'uppercase' }}>
            Industry Scope
          </div>
          <div style={{ fontSize: '1.35rem', fontWeight: 800, color: 'var(--lead-action)', marginTop: '0.35rem' }}>
            Steel Detailing
          </div>
          <div style={{ fontSize: '0.7rem', color: 'var(--text-secondary)', marginTop: '0.2rem' }}>
            All project & client audits
          </div>
        </div>
      </div>

      {/* Filters & Search Toolbar */}
      <div className="card" style={{ padding: '0.85rem 1rem', marginBottom: '1.25rem' }}>
        <div style={{
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          flexWrap: 'wrap',
          gap: '0.75rem'
        }}>
          {/* Search Box */}
          <form onSubmit={handleSearchSubmit} style={{ flex: '1 1 240px', position: 'relative' }}>
            <Search size={14} color="var(--text-muted)" style={{ position: 'absolute', left: '10px', top: '10px' }} />
            <input
              type="text"
              placeholder="Search in log descriptions, company or user..."
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="form-input"
              style={{ paddingLeft: '2rem', paddingRight: '1rem', fontSize: '0.825rem', height: '36px' }}
            />
          </form>

          {/* User Filter */}
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', flexWrap: 'wrap' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
              <User size={13} color="var(--text-muted)" />
              <select
                value={selectedUser}
                onChange={(e) => setSelectedUser(e.target.value)}
                className="form-select"
                style={{ fontSize: '0.8rem', height: '36px', padding: '0.25rem 0.65rem' }}
              >
                <option value="all">All Users</option>
                <option value="abarna.s">Abarna S</option>
                <option value="girish.j">Girish J</option>
                <option value="admin">Admin</option>
              </select>
            </div>

            {/* Action Filter */}
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
              <Filter size={13} color="var(--text-muted)" />
              <select
                value={selectedAction}
                onChange={(e) => setSelectedAction(e.target.value)}
                className="form-select"
                style={{ fontSize: '0.8rem', height: '36px', padding: '0.25rem 0.65rem' }}
              >
                <option value="all">All Actions</option>
                <option value="CREATE_CLIENT">Contact Created</option>
                <option value="UPDATE_CLIENT">Contact Updated</option>
                <option value="CONVERT_LEAD">Lead Converted</option>
                <option value="SCHEDULE_FOLLOWUP">Meetup Scheduled</option>
                <option value="COMPLETE_FOLLOWUP">Follow-up Completed</option>
                <option value="IMPORT_EXCEL">Excel Imported</option>
                <option value="DELETE_CLIENT">Contact Deleted</option>
                <option value="LOGIN">User Login</option>
              </select>
            </div>
          </div>
        </div>
      </div>

      {/* Logs Timeline List */}
      {isLoading ? (
        <div style={{ padding: '3rem', textAlign: 'center', color: 'var(--text-muted)' }}>
          <RefreshCw size={24} className="spin-icon" style={{ margin: '0 auto 0.75rem auto' }} />
          <div>Loading activity logs from database...</div>
        </div>
      ) : logs.length === 0 ? (
        <div className="card" style={{ padding: '3rem 1.5rem', textAlign: 'center' }}>
          <ScrollText size={36} color="var(--text-muted)" style={{ margin: '0 auto 0.75rem auto', opacity: 0.6 }} />
          <h3 style={{ fontSize: '1rem', fontWeight: 700, color: 'var(--text-primary)', marginBottom: '0.25rem' }}>
            No activity logs found
          </h3>
          <p style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>
            {search || selectedUser !== 'all' || selectedAction !== 'all'
              ? 'Try resetting the filters or search query.'
              : 'All updates to contacts, leads, and follow-ups will appear here automatically.'}
          </p>
        </div>
      ) : (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.65rem' }}>
          {logs.map((log) => {
            const badge = getActionBadge(log.action);
            const BadgeIcon = badge.icon;
            const changesObj = parseChanges(log.changes);
            const isExpanded = expandedLogId === log.id;

            return (
              <div 
                key={log.id} 
                className="card" 
                style={{
                  padding: '0.95rem 1.15rem',
                  borderLeft: `4px solid ${badge.color}`,
                  transition: 'background-color 0.15s ease',
                  backgroundColor: 'var(--bg-surface)'
                }}
              >
                <div style={{
                  display: 'flex',
                  alignItems: 'flex-start',
                  justifyContent: 'space-between',
                  gap: '1rem',
                  flexWrap: 'wrap'
                }}>
                  {/* Left Column: User avatar + Action badge + description */}
                  <div style={{ display: 'flex', alignItems: 'flex-start', gap: '0.75rem', flex: '1 1 300px' }}>
                    {/* User Initials Badge */}
                    <div style={{
                      width: '32px',
                      height: '32px',
                      borderRadius: '50%',
                      backgroundColor: log.user_username === 'admin' ? 'var(--lead-action)' : 'var(--primary)',
                      color: 'white',
                      fontSize: '0.72rem',
                      fontWeight: 700,
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      flexShrink: 0,
                      boxShadow: 'var(--shadow-xs)'
                    }}>
                      {(log.user_name || 'U')[0]}
                    </div>

                    <div style={{ flex: 1 }}>
                      {/* Top Meta Line: User name, Action badge, Entity type */}
                      <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', flexWrap: 'wrap', marginBottom: '0.3rem' }}>
                        <span style={{ fontSize: '0.825rem', fontWeight: 700, color: 'var(--text-primary)' }}>
                          {log.user_name || 'Admin'}
                        </span>
                        <span style={{ fontSize: '0.68rem', color: 'var(--text-muted)' }}>
                          (@{log.user_username || 'admin'})
                        </span>

                        <span style={{
                          display: 'inline-flex',
                          alignItems: 'center',
                          gap: '0.25rem',
                          fontSize: '0.68rem',
                          fontWeight: 700,
                          padding: '0.15rem 0.5rem',
                          borderRadius: 'var(--radius-full)',
                          backgroundColor: badge.bg,
                          color: badge.color,
                          border: `1px solid ${badge.border}`
                        }}>
                          <BadgeIcon size={11} />
                          <span>{badge.label}</span>
                        </span>

                        {log.entity_name && (
                          <span style={{
                            fontSize: '0.7rem',
                            fontWeight: 600,
                            padding: '0.15rem 0.45rem',
                            borderRadius: 'var(--radius-sm)',
                            backgroundColor: 'var(--bg-subtle)',
                            color: 'var(--text-secondary)',
                            border: '1px solid var(--border-subtle)'
                          }}>
                            {log.entity_name}
                          </span>
                        )}
                      </div>

                      {/* Description Text */}
                      <p style={{
                        fontSize: '0.825rem',
                        color: 'var(--text-primary)',
                        margin: 0,
                        lineHeight: '1.4',
                        fontWeight: 500
                      }}>
                        {log.description}
                      </p>
                    </div>
                  </div>

                  {/* Right Column: Timestamp & Details Expander */}
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
                    <div style={{
                      display: 'flex',
                      alignItems: 'center',
                      gap: '0.35rem',
                      fontSize: '0.72rem',
                      color: 'var(--text-muted)'
                    }}>
                      <Clock size={12} />
                      <span>{formatTimestamp(log.created_at)}</span>
                    </div>

                    {changesObj && (
                      <button
                        onClick={() => setExpandedLogId(isExpanded ? null : log.id)}
                        className="btn btn-secondary btn-sm"
                        style={{
                          fontSize: '0.72rem',
                          padding: '0.2rem 0.5rem',
                          height: '26px',
                          display: 'flex',
                          alignItems: 'center',
                          gap: '0.25rem'
                        }}
                      >
                        <span>{isExpanded ? 'Hide' : 'Details'}</span>
                        {isExpanded ? <ChevronUp size={12} /> : <ChevronDown size={12} />}
                      </button>
                    )}
                  </div>
                </div>

                {/* Expandable Changes Details */}
                {isExpanded && changesObj && (
                  <div style={{
                    marginTop: '0.75rem',
                    padding: '0.75rem',
                    backgroundColor: 'var(--bg-subtle)',
                    border: '1px solid var(--border-subtle)',
                    borderRadius: 'var(--radius-md)',
                    fontSize: '0.75rem',
                    fontFamily: 'var(--font-mono)'
                  }}>
                    <div style={{ fontWeight: 700, color: 'var(--text-muted)', marginBottom: '0.35rem', textTransform: 'uppercase', fontSize: '0.68rem' }}>
                      Exact Changes Captured:
                    </div>
                    {typeof changesObj === 'object' && !Array.isArray(changesObj) ? (
                      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.35rem' }}>
                        {Object.entries(changesObj).map(([key, val]) => {
                          if (val && typeof val === 'object' && ('old' in val || 'new' in val)) {
                            return (
                              <div key={key} style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', flexWrap: 'wrap' }}>
                                <strong style={{ color: 'var(--text-primary)' }}>{key}:</strong>
                                <span style={{ color: 'var(--danger-color)', textDecoration: 'line-through' }}>
                                  {String(val.old ?? 'empty')}
                                </span>
                                <ArrowRight size={11} color="var(--text-muted)" />
                                <span style={{ color: 'var(--lead-action)', fontWeight: 600 }}>
                                  {String(val.new ?? 'empty')}
                                </span>
                              </div>
                            );
                          }
                          return (
                            <div key={key}>
                              <strong style={{ color: 'var(--text-primary)' }}>{key}:</strong>{' '}
                              <span style={{ color: 'var(--text-secondary)' }}>
                                {typeof val === 'object' ? JSON.stringify(val) : String(val)}
                              </span>
                            </div>
                          );
                        })}
                      </div>
                    ) : (
                      <pre style={{ margin: 0, whiteSpace: 'pre-wrap', color: 'var(--text-secondary)' }}>
                        {JSON.stringify(changesObj, null, 2)}
                      </pre>
                    )}
                  </div>
                )}
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}
