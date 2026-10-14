// Server timestamps (created_at etc.) are naive UTC; treat a value with no timezone as UTC.
export const parseServerUtc = (value) => {
  if (!value) return null;
  const hasZone = /[zZ]|[+-]\d{2}:?\d{2}$/.test(value);
  const d = new Date(hasZone ? value : `${value}Z`);
  return isNaN(d.getTime()) ? null : d;
};

const dayKey = (d) => `${d.getFullYear()}-${d.getMonth()}-${d.getDate()}`;

// Group items into calendar days. `getDate` returns a Date for each item.
// Returns [{ key, date, items }] in the order the items were given.
export const groupByDay = (items, getDate) => {
  const groups = [];
  const byKey = new Map();
  items.forEach(item => {
    const d = getDate(item);
    if (!d) return;
    const key = dayKey(d);
    if (!byKey.has(key)) {
      const group = { key, date: d, items: [] };
      byKey.set(key, group);
      groups.push(group);
    }
    byKey.get(key).items.push(item);
  });
  return groups;
};

export const relativeDayLabel = (d) => {
  const today = new Date();
  const diffDays = Math.round(
    (new Date(d.getFullYear(), d.getMonth(), d.getDate()) - new Date(today.getFullYear(), today.getMonth(), today.getDate())) / 86400000
  );
  if (diffDays === 0) return 'Today';
  if (diffDays === 1) return 'Tomorrow';
  if (diffDays === -1) return 'Yesterday';
  const sameYear = d.getFullYear() === today.getFullYear();
  return d.toLocaleDateString([], { weekday: 'short', month: 'short', day: 'numeric', ...(sameYear ? {} : { year: 'numeric' }) });
};

export const formatTime = (d) => d.toLocaleTimeString([], { hour: 'numeric', minute: '2-digit' });

export const linkButtonStyle = {
  border: 'none',
  background: 'transparent',
  color: 'var(--primary)',
  fontSize: '0.68rem',
  fontWeight: 600,
  cursor: 'pointer',
  padding: '0',
  display: 'flex',
  alignItems: 'center',
  gap: '2px'
};

export const sectionLabelStyle = {
  fontSize: '0.64rem',
  fontWeight: 700,
  textTransform: 'uppercase',
  letterSpacing: '0.03em',
  color: 'var(--text-muted)'
};
