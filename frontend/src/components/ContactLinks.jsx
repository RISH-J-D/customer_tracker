import React from 'react';
import { Mail, Phone } from 'lucide-react';
import CopyButton from './CopyButton';
import { splitPhoneNumbers } from './phoneUtils';

const linkStyle = { color: 'inherit', textDecoration: 'none', display: 'flex', alignItems: 'flex-start', gap: '0.3rem', minWidth: 0 };

// Long addresses may wrap only after the "@", never mid-word
function EmailText({ email }) {
  const at = email.indexOf('@');
  if (at < 0) return <span className="contact-text">{email}</span>;
  return <span className="contact-text">{email.slice(0, at + 1)}<wbr />{email.slice(at + 1)}</span>;
}

export function EmailLink({ email, label = 'email' }) {
  if (!email) return null;
  return (
    <span className="copyable">
      <a href={`mailto:${email}`} style={linkStyle} title={email}>
        <Mail size={11} color="var(--text-placeholder)" style={{ flexShrink: 0, marginTop: '0.15rem' }} />
        <EmailText email={email} />
      </a>
      <CopyButton text={email} label={label} />
    </span>
  );
}

export function PhoneLinks({ phone, label = 'phone number', inline = false }) {
  if (!phone) return null;
  return (
    <span style={{ display: 'flex', flexDirection: inline ? 'row' : 'column', gap: inline ? '0.6rem' : '0.15rem', minWidth: 0 }}>
      {splitPhoneNumbers(phone).map((num, i) => (
        <span key={i} className="copyable">
          <a href={`tel:${num}`} style={linkStyle}>
            <Phone size={11} color="var(--text-placeholder)" style={{ marginTop: '0.15rem', flexShrink: 0 }} />
            <span style={{ whiteSpace: 'nowrap' }}>{num}</span>
          </a>
          <CopyButton text={num} label={label} />
        </span>
      ))}
    </span>
  );
}

// Email + phone(s) stacked (or side by side when `inline`), or a dash when there is neither
export function ContactBlock({ email, phone, emailLabel, phoneLabel, inline = false }) {
  if (!email && !phone) return <span style={{ color: 'var(--text-muted)' }}>-</span>;
  return (
    <div
      className={inline ? 'contact-inline' : undefined}
      style={{ display: 'flex', flexDirection: inline ? 'row' : 'column', flexWrap: inline ? 'wrap' : undefined, gap: inline ? '0.15rem 0.6rem' : '0.25rem', fontSize: '0.75rem', color: 'var(--text-secondary)' }}
    >
      <PhoneLinks phone={phone} label={phoneLabel} inline={inline} />
      <EmailLink email={email} label={emailLabel} />
    </div>
  );
}
