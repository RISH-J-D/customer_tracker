import React, { useState, useRef, useEffect } from 'react';
import { 
  Bell, 
  Sun, 
  Moon, 
  ChevronDown, 
  LogOut 
} from 'lucide-react';

export default function Navbar({
  title,
  subtitle,
  unreadCount,
  onOpenNotifications,
  onOpenTodayModal,
  todayCount = 0,
  theme,
  onToggleTheme,
  currentUser,
  onLogout
}) {
  const [isUserDropdownOpen, setIsUserDropdownOpen] = useState(false);
  const dropdownRef = useRef(null);

  // Close dropdown on click outside
  useEffect(() => {
    function handleClickOutside(event) {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
        setIsUserDropdownOpen(false);
      }
    }
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const getInitials = (name) => {
    if (!name) return 'U';
    const parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return name.slice(0, 2).toUpperCase();
  };

  const currentName = currentUser?.name || 'Admin';
  const currentUsername = currentUser?.username || 'admin';
  const currentRole = currentUser?.role || 'System Administrator';

  return (
    <header className="top-navbar">
      <div className="header-title-group">
        <h1>{title}</h1>
        {subtitle && <p>{subtitle}</p>}
      </div>

      <div className="navbar-actions" style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
        {/* 1. Today's Agenda Card in Top Bar */}
        <div 
          onClick={onOpenTodayModal}
          style={{
            backgroundColor: 'var(--danger-bg)',
            border: '1px solid var(--danger-border)',
            borderRadius: 'var(--radius-md)',
            padding: '0.4rem 0.85rem',
            cursor: 'pointer',
            transition: 'all 0.15s ease',
            display: 'flex',
            flexDirection: 'column',
            justifyContent: 'center',
            textAlign: 'left',
            boxShadow: 'var(--shadow-xs)',
          }}
          className="today-navbar-card"
          title="Click to view and complete today's client meetups"
        >
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: '0.75rem', marginBottom: '0.15rem' }}>
            <span style={{ 
              fontSize: '0.7rem', 
              fontWeight: 800, 
              color: 'var(--danger-color)', 
              textTransform: 'uppercase', 
              letterSpacing: '0.04em' 
            }}>
              Today's Agenda
            </span>
            <span style={{
              backgroundColor: 'var(--danger-btn)',
              color: 'white',
              fontSize: '0.65rem',
              fontWeight: 800,
              padding: '0.05rem 0.45rem',
              borderRadius: '999px',
              whiteSpace: 'nowrap',
              boxShadow: todayCount > 0 ? '0 0 0 2px rgba(239, 68, 68, 0.2)' : 'none'
            }}>
              {todayCount} Due
            </span>
          </div>
          <p className="today-navbar-desc" style={{ 
            fontSize: '0.735rem', 
            color: 'var(--text-secondary)', 
            lineHeight: '1.25',
            margin: 0,
            whiteSpace: 'nowrap'
          }}>
            Click to view and complete today's client meetups.
          </p>
        </div>

        {/* 2. Professional Dark Mode Toggle Button */}
        {onToggleTheme && (
          <button
            className="btn btn-secondary btn-icon"
            onClick={onToggleTheme}
            title={`Switch to ${theme === 'dark' ? 'Light' : 'Dark'} Mode`}
            style={{
              transition: 'all 0.2s ease',
              width: '36px',
              height: '36px',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center'
            }}
            aria-label="Toggle dark mode"
          >
            {theme === 'dark' ? (
              <Sun size={16} color="#FBBF24" />
            ) : (
              <Moon size={16} color="var(--text-secondary)" />
            )}
          </button>
        )}

        {/* 3. Notifications Button */}
        <button
          className="btn btn-secondary btn-icon"
          onClick={onOpenNotifications}
          title="Notification Center"
          style={{ 
            position: 'relative',
            width: '36px',
            height: '36px',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center'
          }}
          aria-label="Notifications"
        >
          <Bell size={16} color="var(--text-secondary)" />
          {unreadCount > 0 && (
            <span style={{
              position: 'absolute',
              top: '-3px',
              right: '-3px',
              backgroundColor: 'var(--danger-btn)',
              color: 'white',
              fontSize: '0.625rem',
              fontWeight: 700,
              minWidth: '16px',
              height: '16px',
              borderRadius: '999px',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              padding: '0 4px',
              border: '2px solid var(--bg-surface)'
            }}>
              {unreadCount}
            </span>
          )}
        </button>

        {/* 4. User Details with Dropdown / Switcher */}
        <div style={{ position: 'relative' }} ref={dropdownRef}>
          <button
            onClick={() => setIsUserDropdownOpen(!isUserDropdownOpen)}
            style={{
              display: 'flex',
              alignItems: 'center',
              gap: '0.55rem',
              background: 'var(--bg-subtle)',
              border: '1px solid var(--border-subtle)',
              borderRadius: 'var(--radius-full)',
              padding: '0.25rem 0.65rem 0.25rem 0.35rem',
              cursor: 'pointer',
              transition: 'all 0.15s ease'
            }}
            title="User Profile"
          >
            {/* Avatar Circle */}
            <div style={{
              width: '28px',
              height: '28px',
              borderRadius: '50%',
              background: currentUsername === 'admin' 
                ? 'linear-gradient(135deg, #10B981, #059669)' 
                : 'linear-gradient(135deg, #4F46E5, #7C3AED)',
              color: 'white',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              fontSize: '0.72rem',
              fontWeight: 700,
              letterSpacing: '0.02em',
              boxShadow: 'var(--shadow-xs)'
            }}>
              {getInitials(currentName)}
            </div>

            {/* Name & Role Text */}
            <div className="navbar-user-text" style={{ textAlign: 'left', lineHeight: '1.2' }}>
              <div style={{ 
                fontSize: '0.78rem', 
                fontWeight: 600, 
                color: 'var(--text-primary)',
                whiteSpace: 'nowrap'
              }}>
                {currentName}
              </div>
              <div style={{ 
                fontSize: '0.65rem', 
                color: 'var(--text-muted)',
                fontWeight: 500
              }}>
                {currentUsername === 'admin' ? 'Admin' : 'Executive'}
              </div>
            </div>

            <ChevronDown size={13} color="var(--text-muted)" style={{ marginLeft: '0.1rem' }} />
          </button>

          {/* User Details Dropdown Menu */}
          {isUserDropdownOpen && (
            <div style={{
              position: 'absolute',
              top: 'calc(100% + 8px)',
              right: 0,
              width: '240px',
              backgroundColor: 'var(--bg-surface)',
              border: '1px solid var(--border-subtle)',
              borderRadius: 'var(--radius-lg)',
              boxShadow: 'var(--shadow-lg)',
              zIndex: 1000,
              padding: '0.5rem',
              animation: 'fadeIn 0.15s ease'
            }}>
              {/* Profile Card Header */}
              <div style={{
                padding: '0.65rem 0.75rem',
                borderBottom: '1px solid var(--border-subtle)',
                marginBottom: '0.4rem'
              }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '0.55rem', marginBottom: '0.35rem' }}>
                  <div style={{
                    width: '32px',
                    height: '32px',
                    borderRadius: '50%',
                    background: currentUsername === 'admin' 
                      ? 'linear-gradient(135deg, #10B981, #059669)' 
                      : 'linear-gradient(135deg, #4F46E5, #7C3AED)',
                    color: 'white',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    fontSize: '0.8rem',
                    fontWeight: 700
                  }}>
                    {getInitials(currentName)}
                  </div>
                  <div>
                    <div style={{ fontSize: '0.825rem', fontWeight: 700, color: 'var(--text-primary)' }}>
                      {currentName}
                    </div>
                    <div style={{ fontSize: '0.7rem', color: 'var(--text-muted)' }}>
                      @{currentUsername}
                    </div>
                  </div>
                </div>
                <div style={{
                  display: 'inline-block',
                  fontSize: '0.65rem',
                  fontWeight: 600,
                  padding: '0.15rem 0.45rem',
                  borderRadius: 'var(--radius-full)',
                  backgroundColor: 'var(--primary-subtle)',
                  color: 'var(--primary)',
                  border: '1px solid var(--primary-border)'
                }}>
                  {currentRole}
                </div>
              </div>

              {/* Only Sign Out option */}
              <div style={{ borderTop: '1px solid var(--border-subtle)', marginTop: '0.4rem', paddingTop: '0.35rem' }}>
                <button
                  onClick={() => {
                    setIsUserDropdownOpen(false);
                    if (onLogout) onLogout();
                  }}
                  style={{
                    width: '100%',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '0.5rem',
                    padding: '0.5rem 0.65rem',
                    borderRadius: 'var(--radius-md)',
                    border: 'none',
                    background: 'transparent',
                    color: 'var(--danger-color)',
                    cursor: 'pointer',
                    fontSize: '0.78rem',
                    fontWeight: 600,
                    textAlign: 'left',
                    transition: 'background 0.15s ease'
                  }}
                  onMouseEnter={(e) => e.currentTarget.style.background = 'var(--danger-bg)'}
                  onMouseLeave={(e) => e.currentTarget.style.background = 'transparent'}
                >
                  <LogOut size={14} />
                  <span>Sign Out</span>
                </button>
              </div>
            </div>
          )}
        </div>
      </div>
    </header>
  );
}
