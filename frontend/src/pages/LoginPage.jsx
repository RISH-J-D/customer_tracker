import React, { useState } from 'react';
import { 
  Sparkles, 
  Lock, 
  User, 
  Eye, 
  EyeOff, 
  ArrowRight, 
  Database, 
  ShieldCheck, 
  Moon, 
  Sun,
  LayoutDashboard,
  CheckCircle2,
  KeyRound
} from 'lucide-react';
import { api } from '../services/api';

export default function LoginPage({ 
  onLoginSuccess, 
  onBypass, 
  theme, 
  onToggleTheme,
  dbInfo 
}) {
  const [username, setUsername] = useState('abarna.s');
  const [password, setPassword] = useState('abarna@2026');
  const [showPassword, setShowPassword] = useState(false);
  const [rememberMe, setRememberMe] = useState(true);
  const [isLoading, setIsLoading] = useState(false);
  const [authError, setAuthError] = useState('');

  const demoAccounts = [
    { username: 'abarna.s', pass: 'abarna@2026', name: 'Abarna S', role: 'Steel Detailing Executive' },
    { username: 'girish.j', pass: 'girish@2026', name: 'Girish J', role: 'Steel Detailing Executive' },
    { username: 'admin', pass: 'admin@123', name: 'Admin', role: 'System Administrator' },
  ];

  const handleSelectAccount = (acc) => {
    setUsername(acc.username);
    setPassword(acc.pass);
    setAuthError('');
  };

  const handleFormSubmit = async (e) => {
    e.preventDefault();
    if (!username.trim()) {
      setAuthError('Please enter your username or work email.');
      return;
    }
    if (!password.trim()) {
      setAuthError('Please enter your password.');
      return;
    }

    setAuthError('');
    setIsLoading(true);

    try {
      const data = await api.login(username.trim(), password.trim());
      if (onLoginSuccess) {
        onLoginSuccess(data.user);
      }
    } catch (err) {
      setAuthError(err.message || 'Invalid credentials');
    } finally {
      setIsLoading(false);
    }
  };

  const handleDemoAccess = () => {
    const defaultUser = { username: 'admin', name: 'Admin', role: 'System Administrator' };
    localStorage.setItem('currentUser', JSON.stringify(defaultUser));
    if (onBypass) {
      onBypass(defaultUser);
    }
  };

  return (
    <div style={{
      minHeight: '100vh',
      display: 'flex',
      flexDirection: 'column',
      backgroundColor: 'var(--bg-main)',
      position: 'relative',
      overflow: 'hidden'
    }}>
      {/* Top Bar */}
      <header style={{
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
        padding: '1.25rem 2rem',
        borderBottom: '1px solid var(--border-subtle)',
        backgroundColor: 'var(--bg-surface)'
      }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
          <div style={{
            width: '32px',
            height: '32px',
            borderRadius: 'var(--radius-md)',
            backgroundColor: 'var(--primary)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            color: 'white',
            boxShadow: 'var(--shadow-sm)'
          }}>
            <Sparkles size={18} />
          </div>
          <div>
            <span style={{ fontWeight: 700, fontSize: '1rem', color: 'var(--text-primary)', letterSpacing: '-0.02em' }}>
              ClientFlow
            </span>
            <span style={{ fontSize: '0.72rem', color: 'var(--text-muted)', marginLeft: '0.4rem', fontWeight: 500 }}>
              Steel Detailing CRM & Pipeline
            </span>
          </div>
        </div>

        <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
          {/* DB Indicator */}
          <div style={{
            display: 'flex',
            alignItems: 'center',
            gap: '0.35rem',
            padding: '0.25rem 0.65rem',
            borderRadius: 'var(--radius-full)',
            backgroundColor: 'var(--bg-subtle)',
            border: '1px solid var(--border-subtle)',
            fontSize: '0.72rem',
            color: 'var(--text-secondary)'
          }} title="Database engine configuration">
            <Database size={12} color="var(--primary)" />
            <span>DB: {dbInfo?.engine === 'postgresql' ? 'PostgreSQL 18 (pgAdmin)' : 'pgAdmin Ready'}</span>
          </div>

          {/* Theme Toggle Button */}
          {onToggleTheme && (
            <button
              onClick={onToggleTheme}
              className="btn btn-secondary btn-icon"
              title={`Switch to ${theme === 'dark' ? 'Light' : 'Dark'} Mode`}
              style={{ width: '32px', height: '32px' }}
            >
              {theme === 'dark' ? <Sun size={15} color="#FBBF24" /> : <Moon size={15} color="var(--text-secondary)" />}
            </button>
          )}

          <button
            onClick={handleDemoAccess}
            className="btn btn-secondary btn-sm"
            style={{ display: 'flex', alignItems: 'center', gap: '0.35rem' }}
          >
            <LayoutDashboard size={13} />
            <span>Skip to Dashboard</span>
          </button>
        </div>
      </header>

      {/* Main Login Container */}
      <main style={{
        flex: 1,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        padding: '2.5rem 1.5rem',
        position: 'relative'
      }}>
        {/* Ambient background glow */}
        <div style={{
          position: 'absolute',
          top: '20%',
          left: '50%',
          transform: 'translate(-50%, -50%)',
          width: '500px',
          height: '400px',
          background: 'radial-gradient(circle, rgba(37, 99, 235, 0.08) 0%, transparent 70%)',
          pointerEvents: 'none',
          zIndex: 0
        }} />

        <div style={{
          maxWidth: '460px',
          width: '100%',
          position: 'relative',
          zIndex: 1
        }}>
          {/* Card */}
          <div className="card" style={{
            padding: '2.25rem',
            boxShadow: 'var(--shadow-lg)',
            border: '1px solid var(--border-subtle)',
            backgroundColor: 'var(--bg-surface)'
          }}>
            <div style={{ textAlign: 'center', marginBottom: '1.5rem' }}>
              <div style={{
                width: '44px',
                height: '44px',
                borderRadius: 'var(--radius-lg)',
                backgroundColor: 'var(--primary-subtle)',
                color: 'var(--primary)',
                display: 'inline-flex',
                alignItems: 'center',
                justifyContent: 'center',
                marginBottom: '0.85rem',
                border: '1px solid var(--primary-border)'
              }}>
                <Lock size={20} />
              </div>
              <h1 style={{ fontSize: '1.35rem', fontWeight: 800, color: 'var(--text-primary)', letterSpacing: '-0.02em' }}>
                Sign In to ClientFlow
              </h1>
              <p style={{ fontSize: '0.8rem', color: 'var(--text-muted)', marginTop: '0.3rem' }}>
                Manage Steel Detailing clients, leads, and activity logs
              </p>
            </div>

            {/* Quick-Select User Cards */}
            <div style={{ marginBottom: '1.35rem' }}>
              <div style={{ fontSize: '0.7rem', fontWeight: 700, color: 'var(--text-muted)', textTransform: 'uppercase', marginBottom: '0.45rem', letterSpacing: '0.04em' }}>
                Select Active User
              </div>
              <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '0.45rem' }}>
                {demoAccounts.map((acc) => {
                  const isSelected = username === acc.username;
                  return (
                    <button
                      key={acc.username}
                      type="button"
                      onClick={() => handleSelectAccount(acc)}
                      style={{
                        padding: '0.5rem 0.35rem',
                        borderRadius: 'var(--radius-md)',
                        border: isSelected ? '2px solid var(--primary)' : '1px solid var(--border-subtle)',
                        backgroundColor: isSelected ? 'var(--primary-subtle)' : 'var(--bg-subtle)',
                        color: 'var(--text-primary)',
                        cursor: 'pointer',
                        textAlign: 'center',
                        transition: 'all 0.15s ease'
                      }}
                    >
                      <div style={{
                        width: '24px',
                        height: '24px',
                        borderRadius: '50%',
                        backgroundColor: isSelected ? 'var(--primary)' : 'var(--border-subtle)',
                        color: isSelected ? 'white' : 'var(--text-secondary)',
                        fontSize: '0.65rem',
                        fontWeight: 700,
                        margin: '0 auto 0.25rem auto',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center'
                      }}>
                        {acc.name[0]}
                      </div>
                      <div style={{ fontSize: '0.72rem', fontWeight: 700 }}>
                        {acc.name}
                      </div>
                      <div style={{ fontSize: '0.62rem', color: 'var(--text-muted)' }}>
                        {acc.username}
                      </div>
                    </button>
                  );
                })}
              </div>
            </div>

            {authError && (
              <div style={{
                backgroundColor: 'var(--danger-bg)',
                border: '1px solid var(--danger-border)',
                color: 'var(--danger-color)',
                borderRadius: 'var(--radius-md)',
                padding: '0.65rem 0.85rem',
                fontSize: '0.785rem',
                marginBottom: '1.25rem'
              }}>
                {authError}
              </div>
            )}

            <form onSubmit={handleFormSubmit}>
              {/* Username */}
              <div className="form-group">
                <label className="form-label" htmlFor="login-username">Username</label>
                <div style={{ position: 'relative' }}>
                  <User size={15} color="var(--text-muted)" style={{ position: 'absolute', left: '11px', top: '11px' }} />
                  <input
                    id="login-username"
                    type="text"
                    value={username}
                    onChange={(e) => setUsername(e.target.value)}
                    placeholder="abarna.s / girish.j / admin"
                    className="form-input"
                    style={{ paddingLeft: '2.25rem' }}
                    required
                  />
                </div>
              </div>

              {/* Password */}
              <div className="form-group">
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '0.35rem' }}>
                  <label className="form-label" htmlFor="login-password" style={{ margin: 0 }}>Password</label>
                  <span style={{ fontSize: '0.7rem', color: 'var(--text-muted)' }}>
                    Auto-filled for selected user
                  </span>
                </div>
                <div style={{ position: 'relative' }}>
                  <Lock size={15} color="var(--text-muted)" style={{ position: 'absolute', left: '11px', top: '11px' }} />
                  <input
                    id="login-password"
                    type={showPassword ? 'text' : 'password'}
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="Enter password"
                    className="form-input"
                    style={{ paddingLeft: '2.25rem', paddingRight: '2.25rem' }}
                    required
                  />
                  <button
                    type="button"
                    onClick={() => setShowPassword(!showPassword)}
                    style={{
                      position: 'absolute',
                      right: '10px',
                      top: '9px',
                      background: 'none',
                      border: 'none',
                      cursor: 'pointer',
                      color: 'var(--text-muted)',
                      padding: 0
                    }}
                  >
                    {showPassword ? <EyeOff size={16} /> : <Eye size={16} />}
                  </button>
                </div>
              </div>

              {/* Remember me */}
              <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '1.25rem' }}>
                <label style={{ display: 'flex', alignItems: 'center', gap: '0.45rem', fontSize: '0.78rem', color: 'var(--text-secondary)', cursor: 'pointer' }}>
                  <input
                    type="checkbox"
                    checked={rememberMe}
                    onChange={(e) => setRememberMe(e.target.checked)}
                    style={{ accentColor: 'var(--primary)' }}
                  />
                  <span>Remember this account</span>
                </label>
              </div>

              {/* Submit */}
              <button
                type="submit"
                className="btn btn-primary"
                disabled={isLoading}
                style={{
                  width: '100%',
                  padding: '0.65rem 1rem',
                  fontSize: '0.875rem',
                  fontWeight: 600,
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  gap: '0.5rem'
                }}
              >
                <span>{isLoading ? 'Signing In...' : `Sign In as ${username}`}</span>
                <ArrowRight size={15} />
              </button>
            </form>

            {/* Quick Demo Bypass */}
            <div style={{
              marginTop: '1.25rem',
              paddingTop: '1.25rem',
              borderTop: '1px solid var(--border-subtle)',
              textAlign: 'center'
            }}>
              <button
                type="button"
                className="btn btn-secondary"
                onClick={handleDemoAccess}
                style={{ width: '100%', fontSize: '0.8rem' }}
              >
                Continue as Admin (Quick Access)
              </button>
            </div>
          </div>

          {/* Database info banner */}
          <div style={{
            marginTop: '1.25rem',
            padding: '0.85rem 1rem',
            backgroundColor: 'var(--bg-surface)',
            border: '1px solid var(--border-subtle)',
            borderRadius: 'var(--radius-md)',
            fontSize: '0.75rem',
            color: 'var(--text-secondary)',
            display: 'flex',
            alignItems: 'center',
            gap: '0.65rem'
          }}>
            <ShieldCheck size={18} color="var(--lead-action)" style={{ flexShrink: 0 }} />
            <div>
              <strong style={{ color: 'var(--text-primary)' }}>Audit Logging Active:</strong>{' '}
              All operations by <code style={{ fontFamily: 'var(--font-mono)' }}>abarna.s</code>, <code style={{ fontFamily: 'var(--font-mono)' }}>girish.j</code>, and <code style={{ fontFamily: 'var(--font-mono)' }}>admin</code> are permanently recorded in PostgreSQL <code style={{ fontFamily: 'var(--font-mono)' }}>activity_logs</code>.
            </div>
          </div>
        </div>
      </main>
    </div>
  );
}
