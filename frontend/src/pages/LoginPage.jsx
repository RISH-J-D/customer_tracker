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
  KeyRound,
  CheckCircle2,
  AlertCircle
} from 'lucide-react';
import { api } from '../services/api';

export default function LoginPage({ 
  onLoginSuccess, 
  theme, 
  onToggleTheme,
  dbInfo 
}) {
  const [username, setUsername] = useState(() => {
    return localStorage.getItem('savedUsername') || '';
  });
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [rememberMe, setRememberMe] = useState(() => {
    return localStorage.getItem('savedUsername') ? true : false;
  });
  const [isLoading, setIsLoading] = useState(false);
  const [authError, setAuthError] = useState('');
  const [forgotHelp, setForgotHelp] = useState(false);

  const handleFormSubmit = async (e) => {
    e.preventDefault();
    if (!username.trim()) {
      setAuthError('Please enter your work username or email.');
      return;
    }
    if (!password.trim()) {
      setAuthError('Please enter your account password.');
      return;
    }

    setAuthError('');
    setIsLoading(true);

    try {
      const data = await api.login(username.trim(), password.trim());
      if (rememberMe) {
        localStorage.setItem('savedUsername', username.trim());
      } else {
        localStorage.removeItem('savedUsername');
      }
      if (onLoginSuccess) {
        onLoginSuccess(data.user);
      }
    } catch (err) {
      setAuthError(err.message || 'Invalid username or password. Please verify your credentials.');
    } finally {
      setIsLoading(false);
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
      {/* Top Header */}
      <header style={{
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
        padding: '1.25rem 2rem',
        borderBottom: '1px solid var(--border-subtle)',
        backgroundColor: 'var(--bg-surface)',
        zIndex: 10
      }}>
        {/* Brand Logo & Title */}
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
          <div style={{
            width: '36px',
            height: '36px',
            borderRadius: 'var(--radius-md)',
            background: 'linear-gradient(135deg, var(--primary) 0%, #1D4ED8 100%)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            color: 'white',
            boxShadow: 'var(--shadow-sm)'
          }}>
            <Sparkles size={18} />
          </div>
          <div>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.45rem' }}>
              <span style={{ fontWeight: 800, fontSize: '1.05rem', color: 'var(--text-primary)', letterSpacing: '-0.02em' }}>
                ClientFlow
              </span>
              <span style={{
                fontSize: '0.65rem',
                fontWeight: 700,
                padding: '0.1rem 0.45rem',
                borderRadius: 'var(--radius-full)',
                backgroundColor: 'var(--primary-subtle)',
                color: 'var(--primary)',
                border: '1px solid var(--primary-border)',
                textTransform: 'uppercase',
                letterSpacing: '0.04em'
              }}>
                CRM
              </span>
            </div>
            <p style={{ fontSize: '0.72rem', color: 'var(--text-muted)', margin: 0, fontWeight: 500 }}>
              Steel Detailing & Pipeline Management
            </p>
          </div>
        </div>

        {/* Header Right Actions */}
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
          {/* DB Indicator */}
          <div style={{
            display: 'flex',
            alignItems: 'center',
            gap: '0.35rem',
            padding: '0.3rem 0.7rem',
            borderRadius: 'var(--radius-full)',
            backgroundColor: 'var(--bg-subtle)',
            border: '1px solid var(--border-subtle)',
            fontSize: '0.72rem',
            color: 'var(--text-secondary)'
          }} title="Database engine configuration">
            <Database size={12} color="var(--primary)" />
            <span>DB: {dbInfo?.engine === 'postgresql' ? 'PostgreSQL 18' : 'PostgreSQL Active'}</span>
          </div>

          {/* Theme Toggle Button */}
          {onToggleTheme && (
            <button
              onClick={onToggleTheme}
              className="btn btn-secondary btn-icon"
              title={`Switch to ${theme === 'dark' ? 'Light' : 'Dark'} Mode`}
              style={{ width: '34px', height: '34px' }}
              aria-label="Toggle color theme"
            >
              {theme === 'dark' ? <Sun size={15} color="#FBBF24" /> : <Moon size={15} color="var(--text-secondary)" />}
            </button>
          )}
        </div>
      </header>

      {/* Main Login Screen Body */}
      <main style={{
        flex: 1,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        padding: '2.5rem 1.25rem',
        position: 'relative',
        zIndex: 1
      }}>
        {/* Subtle Ambient Background Gradient Glow */}
        <div style={{
          position: 'absolute',
          top: '30%',
          left: '50%',
          transform: 'translate(-50%, -50%)',
          width: '600px',
          height: '450px',
          background: 'radial-gradient(circle, rgba(37, 99, 235, 0.07) 0%, transparent 70%)',
          pointerEvents: 'none',
          zIndex: 0
        }} />

        <div style={{
          maxWidth: '440px',
          width: '100%',
          position: 'relative',
          zIndex: 1
        }}>
          {/* Login Card */}
          <div className="card" style={{
            padding: '2.5rem 2.25rem',
            boxShadow: 'var(--shadow-lg)',
            border: '1px solid var(--border-subtle)',
            backgroundColor: 'var(--bg-surface)',
            borderRadius: 'var(--radius-lg)'
          }}>
            {/* Header Lock Icon & Titles */}
            <div style={{ textAlign: 'center', marginBottom: '2rem' }}>
              <div style={{
                width: '48px',
                height: '48px',
                borderRadius: 'var(--radius-md)',
                backgroundColor: 'var(--primary-subtle)',
                color: 'var(--primary)',
                display: 'inline-flex',
                alignItems: 'center',
                justifyContent: 'center',
                marginBottom: '1rem',
                border: '1px solid var(--primary-border)',
                boxShadow: 'var(--shadow-xs)'
              }}>
                <Lock size={22} />
              </div>
              <h1 style={{ fontSize: '1.4rem', fontWeight: 800, color: 'var(--text-primary)', letterSpacing: '-0.02em', margin: 0 }}>
                Sign In to Your Account
              </h1>
              <p style={{ fontSize: '0.825rem', color: 'var(--text-muted)', marginTop: '0.45rem', lineHeight: '1.4' }}>
                Enter your credentials to access ClientFlow CRM
              </p>
            </div>

            {/* Error Message Alert */}
            {authError && (
              <div style={{
                backgroundColor: 'var(--danger-bg)',
                border: '1px solid var(--danger-border)',
                color: 'var(--danger-color)',
                borderRadius: 'var(--radius-md)',
                padding: '0.75rem 0.95rem',
                fontSize: '0.8rem',
                marginBottom: '1.5rem',
                display: 'flex',
                alignItems: 'flex-start',
                gap: '0.55rem',
                animation: 'fadeIn 0.2s ease'
              }}>
                <AlertCircle size={16} style={{ flexShrink: 0, marginTop: '1px' }} />
                <div style={{ lineHeight: '1.4' }}>{authError}</div>
              </div>
            )}

            {/* Forgot Password Information Box */}
            {forgotHelp && (
              <div style={{
                backgroundColor: 'var(--primary-subtle)',
                border: '1px solid var(--primary-border)',
                color: 'var(--primary)',
                borderRadius: 'var(--radius-md)',
                padding: '0.75rem 0.95rem',
                fontSize: '0.785rem',
                marginBottom: '1.5rem',
                lineHeight: '1.4'
              }}>
                <strong>Account Support:</strong> Please reach out to your Steel Detailing administrator at <code style={{ fontFamily: 'var(--font-mono)' }}>admin@clientflow.internal</code> or contact IT Helpdesk to reset your password.
              </div>
            )}

            {/* Sign In Form */}
            <form onSubmit={handleFormSubmit}>
              {/* Username Input */}
              <div className="form-group" style={{ marginBottom: '1.25rem' }}>
                <label className="form-label" htmlFor="login-username" style={{ fontWeight: 600, fontSize: '0.78rem' }}>
                  Username or Work Email
                </label>
                <div style={{ position: 'relative' }}>
                  <User size={16} color="var(--text-muted)" style={{ position: 'absolute', left: '12px', top: '12px', pointerEvents: 'none' }} />
                  <input
                    id="login-username"
                    type="text"
                    value={username}
                    onChange={(e) => setUsername(e.target.value)}
                    placeholder="e.g. girish.j or admin"
                    className="form-input"
                    style={{ 
                      paddingLeft: '2.4rem', 
                      height: '42px',
                      fontSize: '0.875rem'
                    }}
                    autoComplete="username"
                    required
                  />
                </div>
              </div>

              {/* Password Input */}
              <div className="form-group" style={{ marginBottom: '1.25rem' }}>
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '0.35rem' }}>
                  <label className="form-label" htmlFor="login-password" style={{ margin: 0, fontWeight: 600, fontSize: '0.78rem' }}>
                    Password
                  </label>
                  <button
                    type="button"
                    onClick={() => setForgotHelp(!forgotHelp)}
                    style={{
                      background: 'none',
                      border: 'none',
                      color: 'var(--primary)',
                      fontSize: '0.75rem',
                      fontWeight: 600,
                      cursor: 'pointer',
                      padding: 0
                    }}
                  >
                    Forgot password?
                  </button>
                </div>
                <div style={{ position: 'relative' }}>
                  <Lock size={16} color="var(--text-muted)" style={{ position: 'absolute', left: '12px', top: '12px', pointerEvents: 'none' }} />
                  <input
                    id="login-password"
                    type={showPassword ? 'text' : 'password'}
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="Enter your password"
                    className="form-input"
                    style={{ 
                      paddingLeft: '2.4rem', 
                      paddingRight: '2.5rem', 
                      height: '42px',
                      fontSize: '0.875rem'
                    }}
                    autoComplete="current-password"
                    required
                  />
                  <button
                    type="button"
                    onClick={() => setShowPassword(!showPassword)}
                    style={{
                      position: 'absolute',
                      right: '10px',
                      top: '11px',
                      background: 'none',
                      border: 'none',
                      cursor: 'pointer',
                      color: 'var(--text-muted)',
                      padding: '2px',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center'
                    }}
                    aria-label={showPassword ? 'Hide password' : 'Show password'}
                  >
                    {showPassword ? <EyeOff size={17} /> : <Eye size={17} />}
                  </button>
                </div>
              </div>

              {/* Remember Me Checkbox */}
              <div style={{ display: 'flex', alignItems: 'center', marginBottom: '1.5rem' }}>
                <label style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.8rem', color: 'var(--text-secondary)', cursor: 'pointer', userSelect: 'none' }}>
                  <input
                    type="checkbox"
                    checked={rememberMe}
                    onChange={(e) => setRememberMe(e.target.checked)}
                    style={{ accentColor: 'var(--primary)', width: '15px', height: '15px' }}
                  />
                  <span>Remember my username</span>
                </label>
              </div>

              {/* Submit Button */}
              <button
                type="submit"
                className="btn btn-primary"
                disabled={isLoading}
                style={{
                  width: '100%',
                  height: '42px',
                  fontSize: '0.875rem',
                  fontWeight: 600,
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  gap: '0.5rem',
                  background: 'linear-gradient(135deg, var(--primary) 0%, #1D4ED8 100%)',
                  boxShadow: 'var(--shadow-sm)'
                }}
              >
                <span>{isLoading ? 'Signing In...' : 'Sign In'}</span>
                <ArrowRight size={16} />
              </button>
            </form>
          </div>

          {/* Secure System Footer */}
          <div style={{
            marginTop: '1.5rem',
            textAlign: 'center',
            fontSize: '0.75rem',
            color: 'var(--text-muted)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            gap: '0.45rem'
          }}>
            <ShieldCheck size={14} color="var(--lead-action)" />
            <span>Enterprise Security • 256-bit Encrypted Session</span>
          </div>
        </div>
      </main>
    </div>
  );
}
