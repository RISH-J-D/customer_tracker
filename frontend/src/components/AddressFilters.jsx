import React, { useState } from 'react';
import { MapPin, X } from 'lucide-react';

const clean = (v) => (v || '').trim();
const uniqueSorted = (values) => [...new Set(values.map(clean).filter(Boolean))].sort((a, b) => a.localeCompare(b));

export const formatAddress = (c) => [c.city, c.state, c.country].map(clean).filter(Boolean).join(', ');

// Country -> state -> city filter state for a list of clients
export function useAddressFilter(items) {
  const [country, setCountry] = useState('');
  const [state, setState] = useState('');
  const [city, setCity] = useState('');

  const inCountry = (c) => !country || clean(c.country) === country;
  const inState = (c) => !state || clean(c.state) === state;
  const inCity = (c) => !city || clean(c.city) === city;

  return {
    country, state, city,
    isActive: Boolean(country || state || city),
    matches: (c) => inCountry(c) && inState(c) && inCity(c),
    options: {
      countries: uniqueSorted(items.map(c => c.country)),
      states: uniqueSorted(items.filter(inCountry).map(c => c.state)),
      cities: uniqueSorted(items.filter(c => inCountry(c) && inState(c)).map(c => c.city))
    },
    setCountry: (v) => { setCountry(v); setState(''); setCity(''); },
    setState: (v) => { setState(v); setCity(''); },
    setCity,
    clear: () => { setCountry(''); setState(''); setCity(''); }
  };
}

export function AddressFilters({ filter }) {
  const { options } = filter;
  return (
    <div className="address-filters">
      <MapPin size={14} color="var(--text-muted)" style={{ flexShrink: 0 }} />
      <select className="form-select" value={filter.country} onChange={(e) => filter.setCountry(e.target.value)} title="Filter by country">
        <option value="">All countries</option>
        {options.countries.map(v => <option key={v} value={v}>{v}</option>)}
      </select>
      <select className="form-select" value={filter.state} onChange={(e) => filter.setState(e.target.value)} title="Filter by state">
        <option value="">All states</option>
        {options.states.map(v => <option key={v} value={v}>{v}</option>)}
      </select>
      <select className="form-select" value={filter.city} onChange={(e) => filter.setCity(e.target.value)} title="Filter by city">
        <option value="">All cities</option>
        {options.cities.map(v => <option key={v} value={v}>{v}</option>)}
      </select>
      {filter.isActive && (
        <button className="btn btn-secondary btn-sm" onClick={filter.clear} title="Clear address filters">
          <X size={12} />
          <span>Clear</span>
        </button>
      )}
    </div>
  );
}

export function AddressLine({ client, size = 11 }) {
  const address = formatAddress(client);
  if (!address) return null;
  return (
    <div style={{ display: 'flex', alignItems: 'flex-start', gap: '0.25rem', color: 'var(--text-muted)', fontSize: '0.72rem', marginTop: '0.2rem' }}>
      <MapPin size={size} color="var(--text-placeholder)" style={{ marginTop: '0.12rem', flexShrink: 0 }} />
      <span>{address}</span>
    </div>
  );
}
