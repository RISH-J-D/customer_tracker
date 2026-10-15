import React from 'react';
import { Mail, Phone } from 'lucide-react';
import CopyButton from './CopyButton';
import { splitPhoneNumbers } from './phoneUtils';

const linkStyle = { color: 'inherit', textDecoration: 'none', display: 'flex', alignItems: 'flex-start', gap: '0.3rem', minWidth: 0 };

export function EmailLink({ email, label = 'email' }) {
  if (!email) return null;
  return (
    <span className="copyable">
      <a href={`mailto:${email}`} style={linkStyle} title={email}>
        <Mail size={11} color="var(--text-placeholder)" style={{ flexShrink: 0, marginTop: '0.15rem' }} />
        <span style={{ wordBreak: 'break-all', minWidth: 0 }}>{email}</span>
      </a>
      <CopyButton text={email} label={label} />
    </span>
  );
}

export function PhoneLinks({ phone, label = 'phone number' }) {
  if (!phone) return null;
  return (
    <span style={{ display: 'flex', flexDirection: 'column', gap: '0.15rem', minWidth: 0 }}>
      {splitPhoneNumbers(phone).map((num, i) => (
        <span key={i} className="copyable">
          <a href={`tel:${num}`} style={linkStyle}>
            <Phone size={11} color="var(--text-placeholder)" style={{ marginTop: '0.15rem', flexShrink: 0 }} />
            <span>{num}</span>
          </a>
          <CopyButton text={num} label={label} />
        </span>
      ))}
    </span>
  );
}

// Email + phone(s) stacked, or a dash when there is neither
export function ContactBlock({ email, phone, emailLabel, phoneLabel }) {
  if (!email && !phone) return <span style={{ color: 'var(--text-muted)' }}>-</span>;
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.25rem', fontSize: '0.75rem', color: 'var(--text-secondary)' }}>
      <EmailLink email={email} label={emailLabel} />
      <PhoneLinks phone={phone} label={phoneLabel} />
    </div>
  );
}
