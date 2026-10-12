import React, { useState, useEffect, useMemo } from 'react';
import { 
  X, 
  Building2, 
  FolderKanban, 
  User, 
  Mail, 
  Phone, 
  DollarSign, 
  Weight, 
  CheckCircle,
  Briefcase,
  Sparkles,
  Search,
  CheckCircle2,
  ThumbsUp
} from 'lucide-react';

export default function AccountModal({
  isOpen,
  onClose,
  onSave,
  account = null,
  editingAccount = null,
  prefilledClient = null,
  clients = [],
  availableClients = []
}) {
  const currentEditingAccount = editingAccount || account;
  const allClientsList = useMemo(() => {
    return (clients && clients.length > 0) ? clients : (availableClients || []);
  }, [clients, availableClients]);

  // Helper to split full name into first and last name
  const parseName = (fullName = '') => {
    const trimmed = (fullName || '').trim();
    if (!trimmed) return { first: '', last: '' };
    const parts = trimmed.split(/\s+/);
    if (parts.length === 1) return { first: parts[0], last: '' };
    return { first: parts[0], last: parts.slice(1).join(' ') };
  };

  const [formData, setFormData] = useState({
    account_name: '',
    company: '',
    project_name: '',
    rep_first_name: '',
    rep_last_name: '',
    client_representative: '',
    rep_designation: '',
    rep_email: '',
    rep_phone: '',
    deal_value: '',
    steel_tonnage: '',
    status: 'Active Project',
    notes: '',
    client_id: ''
  });

  const [errors, setErrors] = useState({});
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [leadSearch, setLeadSearch] = useState('');
  const [leadTab, setLeadTab] = useState('leads'); // 'leads' or 'all'

  // Filter existing leads and all clients
  const existingLeads = useMemo(() => {
    return allClientsList.filter(c => c.is_lead);
  }, [allClientsList]);

  const displayedList = useMemo(() => {
    const baseList = leadTab === 'leads' ? existingLeads : allClientsList;
    if (!leadSearch.trim()) return baseList;
    const q = leadSearch.toLowerCase();
    return baseList.filter(c => 
      (c.company && c.company.toLowerCase().includes(q)) ||
      (c.name && c.name.toLowerCase().includes(q)) ||
      (c.email && c.email.toLowerCase().includes(q)) ||
      (c.phone && c.phone.toLowerCase().includes(q))
    );
  }, [leadTab, existingLeads, allClientsList, leadSearch]);

  useEffect(() => {
    if (currentEditingAccount) {
      const { first, last } = parseName(currentEditingAccount.client_representative);
      setFormData({
        account_name: currentEditingAccount.account_name || '',
        company: currentEditingAccount.company || '',
        project_name: currentEditingAccount.project_name || '',
        rep_first_name: currentEditingAccount.rep_first_name || first,
        rep_last_name: currentEditingAccount.rep_last_name || last,
        client_representative: currentEditingAccount.client_representative || `${first} ${last}`.trim(),
        rep_designation: currentEditingAccount.rep_designation || '',
        rep_email: currentEditingAccount.rep_email || '',
        rep_phone: currentEditingAccount.rep_phone || '',
        deal_value: currentEditingAccount.deal_value || '',
        steel_tonnage: currentEditingAccount.steel_tonnage || '',
        status: currentEditingAccount.status || 'Active Project',
        notes: currentEditingAccount.notes || '',
        client_id: currentEditingAccount.client_id ? String(currentEditingAccount.client_id) : ''
      });
    } else if (prefilledClient) {
      const { first, last } = parseName(prefilledClient.name);
      setFormData({
        account_name: `${prefilledClient.company || prefilledClient.name} - Steel Detailing Project`,
        company: prefilledClient.company || prefilledClient.name || '',
        project_name: 'Structural Steel Detailing Package',
        rep_first_name: first,
        rep_last_name: last,
        client_representative: prefilledClient.name || `${first} ${last}`.trim(),
        rep_designation: 'Project Representative',
        rep_email: prefilledClient.email || '',
        rep_phone: prefilledClient.phone || '',
        deal_value: prefilledClient.deal_value || '',
        steel_tonnage: '',
        status: 'Active Project',
        notes: prefilledClient.notes ? `[Converted from Lead]: ${prefilledClient.notes}` : '',
        client_id: prefilledClient.id ? String(prefilledClient.id) : (prefilledClient.client_id ? String(prefilledClient.client_id) : '')
      });
    } else {
      setFormData({
        account_name: '',
        company: '',
        project_name: '',
        rep_first_name: '',
        rep_last_name: '',
        client_representative: '',
        rep_designation: '',
        rep_email: '',
        rep_phone: '',
        deal_value: '',
        steel_tonnage: '',
        status: 'Active Project',
        notes: '',
        client_id: ''
      });
    }
    setErrors({});
    setLeadSearch('');
  }, [currentEditingAccount, prefilledClient, isOpen]);

  if (!isOpen) return null;

  const handleSelectLead = (lead) => {
    const { first, last } = parseName(lead.name);
    setFormData(prev => ({
      ...prev,
      client_id: String(lead.id),
      company: lead.company || lead.name,
      account_name: prev.account_name || `${lead.company || lead.name} - Steel Detailing Project`,
      project_name: prev.project_name || 'Structural Steel Detailing Package',
      rep_first_name: first,
      rep_last_name: last,
      client_representative: lead.name || `${first} ${last}`.trim(),
      rep_designation: prev.rep_designation || 'Project Representative',
      rep_email: lead.email || prev.rep_email || '',
      rep_phone: lead.phone || prev.rep_phone || '',
      deal_value: lead.deal_value || prev.deal_value || '',
      notes: lead.notes ? `[Converted from Lead]: ${lead.notes}` : prev.notes
    }));
  };

  const handleClearLeadSelection = () => {
    setFormData(prev => ({
      ...prev,
      client_id: ''
    }));
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => {
      const next = { ...prev, [name]: value };
      if (name === 'rep_first_name' || name === 'rep_last_name') {
        const first = name === 'rep_first_name' ? value : prev.rep_first_name;
        const last = name === 'rep_last_name' ? value : prev.rep_last_name;
        next.client_representative = `${first} ${last}`.trim();
      }
      return next;
    });

    if (name === 'client_id' && value) {
      const selected = allClientsList.find(c => String(c.id) === value);
      if (selected) {
        handleSelectLead(selected);
      }
    }
  };

  const validate = () => {
    const newErrors = {};
    if (!formData.account_name.trim()) newErrors.account_name = 'Account title is required';
    if (!formData.company.trim()) newErrors.company = 'Company name is required';
    if (!formData.project_name.trim()) newErrors.project_name = 'Project name is required';
    if (!formData.rep_first_name.trim()) newErrors.rep_first_name = 'First name is required';
    if (!formData.rep_last_name.trim()) newErrors.rep_last_name = 'Last name is required';
    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!validate()) return;

    setIsSubmitting(true);
    try {
      const repCombined = `${formData.rep_first_name} ${formData.rep_last_name}`.trim();
      const payload = {
        ...formData,
        client_representative: repCombined,
        deal_value: formData.deal_value ? parseFloat(formData.deal_value) : 0.0,
        steel_tonnage: formData.steel_tonnage ? parseFloat(formData.steel_tonnage) : null,
        client_id: formData.client_id ? parseInt(formData.client_id) : null
      };
      await onSave(payload, currentEditingAccount?.id);
      onClose();
    } catch (err) {
      setErrors({ form: err.message || 'Failed to save account' });
    } finally {
      setIsSubmitting(false);
    }
  };

  // Find currently linked client if any
  const selectedLeadObj = formData.client_id 
    ? allClientsList.find(c => String(c.id) === String(formData.client_id)) 
    : null;

  return (
    <div className="modal-backdrop" onClick={onClose}>
      <div 
        className="modal-container" 
        style={{ maxWidth: '680px', width: '94vw' }} 
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="modal-header">
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
            <div style={{
              width: '36px',
              height: '36px',
              borderRadius: 'var(--radius-md)',
              backgroundColor: 'var(--lead-surface)',
              color: 'var(--lead-action)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              border: '1px solid var(--lead-border)'
            }}>
              <Building2 size={20} />
            </div>
            <div>
              <h2 className="modal-title">
                {currentEditingAccount ? 'Edit Account & Project' : 'Convert to Account / New Project'}
              </h2>
              <p className="modal-subtitle">
                Link projects & client representatives under the company account
              </p>
            </div>
          </div>
          <button className="modal-close-btn" onClick={onClose} aria-label="Close modal">
            <X size={18} />
          </button>
        </div>

        {errors.form && (
          <div style={{
            margin: '1rem 1.5rem 0',
            padding: '0.65rem 0.85rem',
            backgroundColor: 'var(--danger-bg)',
            border: '1px solid var(--danger-border)',
            color: 'var(--danger-color)',
            borderRadius: 'var(--radius-md)',
            fontSize: '0.8rem'
          }}>
            {errors.form}
          </div>
        )}

        {/* Form Body */}
        <form onSubmit={handleSubmit}>
          <div className="modal-body" style={{ maxHeight: '74vh', overflowY: 'auto', paddingRight: '0.75rem' }}>
            
            {/* EXISTING LEADS SECTION (Highlight prominently when creating / converting) */}
            {!currentEditingAccount && allClientsList.length > 0 && (
              <div style={{
                marginBottom: '1.25rem',
                backgroundColor: 'var(--bg-subtle)',
                border: '1px solid var(--border-subtle)',
                borderRadius: 'var(--radius-md)',
                padding: '0.85rem'
              }}>
                <div style={{
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'space-between',
                  marginBottom: '0.65rem',
                  flexWrap: 'wrap',
                  gap: '0.5rem'
                }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.45rem' }}>
                    <Sparkles size={15} color="var(--lead-action)" />
                    <span style={{ fontSize: '0.825rem', fontWeight: 700, color: 'var(--text-primary)' }}>
                      Select from Existing Leads
                    </span>
                    <span style={{
                      fontSize: '0.68rem',
                      fontWeight: 700,
                      padding: '0.1rem 0.45rem',
                      borderRadius: 'var(--radius-full)',
                      backgroundColor: 'var(--lead-bg)',
                      color: 'var(--lead-color)',
                      border: '1px solid var(--lead-border)'
                    }}>
                      {existingLeads.length} Available
                    </span>
                  </div>

                  {/* Tabs: Leads vs All Clients */}
                  <div style={{ display: 'flex', gap: '0.25rem' }}>
                    <button
                      type="button"
                      onClick={() => setLeadTab('leads')}
                      style={{
                        padding: '0.2rem 0.5rem',
                        fontSize: '0.7rem',
                        fontWeight: leadTab === 'leads' ? 700 : 500,
                        backgroundColor: leadTab === 'leads' ? 'var(--bg-surface)' : 'transparent',
                        border: '1px solid',
                        borderColor: leadTab === 'leads' ? 'var(--lead-border)' : 'transparent',
                        color: leadTab === 'leads' ? 'var(--lead-action)' : 'var(--text-muted)',
                        borderRadius: 'var(--radius-sm)',
                        cursor: 'pointer'
                      }}
                    >
                      ★ Qualified Leads ({existingLeads.length})
                    </button>
                    <button
                      type="button"
                      onClick={() => setLeadTab('all')}
                      style={{
                        padding: '0.2rem 0.5rem',
                        fontSize: '0.7rem',
                        fontWeight: leadTab === 'all' ? 700 : 500,
                        backgroundColor: leadTab === 'all' ? 'var(--bg-surface)' : 'transparent',
                        border: '1px solid',
                        borderColor: leadTab === 'all' ? 'var(--border-subtle)' : 'transparent',
                        color: leadTab === 'all' ? 'var(--text-primary)' : 'var(--text-muted)',
                        borderRadius: 'var(--radius-sm)',
                        cursor: 'pointer'
                      }}
                    >
                      All Clients ({allClientsList.length})
                    </button>
                  </div>
                </div>

                {/* Search input for leads */}
                <div style={{ position: 'relative', marginBottom: '0.65rem' }}>
                  <Search size={13} color="var(--text-muted)" style={{ position: 'absolute', left: '9px', top: '9px' }} />
                  <input
                    type="text"
                    placeholder="Search existing lead company, contact, or email..."
                    value={leadSearch}
                    onChange={(e) => setLeadSearch(e.target.value)}
                    className="form-input"
                    style={{
                      height: '32px',
                      paddingLeft: '1.85rem',
                      fontSize: '0.75rem',
                      backgroundColor: 'var(--bg-surface)'
                    }}
                  />
                </div>

                {/* Existing Leads Cards List */}
                <div style={{
                  display: 'grid',
                  gridTemplateColumns: 'repeat(auto-fill, minmax(200px, 1fr))',
                  gap: '0.5rem',
                  maxHeight: '160px',
                  overflowY: 'auto',
                  padding: '2px'
                }}>
                  {displayedList.length === 0 ? (
                    <div style={{
                      gridColumn: '1 / -1',
                      padding: '1rem',
                      textAlign: 'center',
                      fontSize: '0.75rem',
                      color: 'var(--text-muted)'
                    }}>
                      No leads matching "{leadSearch}"
                    </div>
                  ) : (
                    displayedList.map(lead => {
                      const isSelected = String(formData.client_id) === String(lead.id);
                      return (
                        <div
                          key={lead.id}
                          onClick={() => handleSelectLead(lead)}
                          style={{
                            padding: '0.6rem 0.75rem',
                            backgroundColor: isSelected ? 'var(--lead-bg)' : 'var(--bg-surface)',
                            border: `1.5px solid ${isSelected ? 'var(--lead-action)' : 'var(--border-subtle)'}`,
                            borderRadius: 'var(--radius-md)',
                            cursor: 'pointer',
                            transition: 'all 0.15s ease',
                            display: 'flex',
                            flexDirection: 'column',
                            gap: '0.25rem',
                            boxShadow: isSelected ? '0 0 0 1px var(--lead-action)' : 'none'
                          }}
                        >
                          <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', gap: '0.35rem' }}>
                            <strong style={{
                              fontSize: '0.8rem',
                              color: isSelected ? 'var(--lead-action)' : 'var(--text-primary)',
                              whiteSpace: 'nowrap',
                              overflow: 'hidden',
                              textOverflow: 'ellipsis'
                            }}>
                              {lead.company || lead.name}
                            </strong>
                            {isSelected ? (
                              <CheckCircle2 size={14} color="var(--lead-action)" style={{ flexShrink: 0 }} />
                            ) : lead.is_lead ? (
                              <span style={{
                                fontSize: '0.625rem',
                                color: 'var(--lead-action)',
                                fontWeight: 700,
                                flexShrink: 0
                              }}>★ Lead</span>
                            ) : null}
                          </div>

                          <div style={{ fontSize: '0.72rem', color: 'var(--text-secondary)', display: 'flex', alignItems: 'center', gap: '0.25rem' }}>
                            <User size={10} color="var(--text-muted)" />
                            <span style={{ overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                              {lead.name}
                            </span>
                          </div>

                          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginTop: '0.15rem' }}>
                            <span style={{ fontSize: '0.7rem', fontWeight: 700, color: '#10B981' }}>
                              ${lead.deal_value ? lead.deal_value.toLocaleString() : '0'}
                            </span>
                            {lead.positive_approach && (
                              <span style={{ fontSize: '0.625rem', color: '#D97706', display: 'flex', alignItems: 'center', gap: '0.15rem' }}>
                                <ThumbsUp size={9} /> Positive
                              </span>
                            )}
                          </div>
                        </div>
                      );
                    })
                  )}
                </div>

                {/* Selected Lead Indicator Banner */}
                {selectedLeadObj && (
                  <div style={{
                    marginTop: '0.65rem',
                    padding: '0.45rem 0.65rem',
                    backgroundColor: 'var(--lead-bg)',
                    border: '1px solid var(--lead-border)',
                    borderRadius: 'var(--radius-sm)',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'space-between',
                    fontSize: '0.75rem',
                    color: 'var(--lead-color)'
                  }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
                      <CheckCircle2 size={13} color="var(--lead-action)" />
                      <span>
                        Auto-filled from lead: <strong>{selectedLeadObj.company || selectedLeadObj.name}</strong> ({selectedLeadObj.name})
                      </span>
                    </div>
                    <button
                      type="button"
                      onClick={handleClearLeadSelection}
                      style={{
                        background: 'transparent',
                        border: 'none',
                        color: 'var(--lead-action)',
                        fontSize: '0.7rem',
                        fontWeight: 600,
                        cursor: 'pointer',
                        padding: '0 0.25rem'
                      }}
                      title="Clear linked lead and enter custom manual data"
                    >
                      Clear Selection
                    </button>
                  </div>
                )}
              </div>
            )}

            {/* Row 1: Account Title & Parent Company */}
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '1rem' }}>
              <div className="form-group">
                <label className="form-label" htmlFor="acc-name">
                  Account Name <span style={{ color: 'var(--danger-color)' }}>*</span>
                </label>
                <div style={{ position: 'relative' }}>
                  <Briefcase size={15} color="var(--text-muted)" style={{ position: 'absolute', left: '11px', top: '11px' }} />
                  <input
                    id="acc-name"
                    name="account_name"
                    type="text"
                    placeholder="e.g. Novus Tower - Core Steel Detailing"
                    value={formData.account_name}
                    onChange={handleChange}
                    className="form-input"
                    style={{ paddingLeft: '2.25rem' }}
                    required
                  />
                </div>
                {errors.account_name && <p className="form-error">{errors.account_name}</p>}
              </div>

              <div className="form-group">
                <label className="form-label" htmlFor="acc-company">
                  Company / Organization <span style={{ color: 'var(--danger-color)' }}>*</span>
                </label>
                <div style={{ position: 'relative' }}>
                  <Building2 size={15} color="var(--text-muted)" style={{ position: 'absolute', left: '11px', top: '11px' }} />
                  <input
                    id="acc-company"
                    name="company"
                    type="text"
                    placeholder="e.g. Novus Fintech Solutions"
                    value={formData.company}
                    onChange={handleChange}
                    className="form-input"
                    style={{ paddingLeft: '2.25rem' }}
                    required
                  />
                </div>
                {errors.company && <p className="form-error">{errors.company}</p>}
              </div>
            </div>

            {/* Project Name & Status */}
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '1rem' }}>
              <div className="form-group">
                <label className="form-label" htmlFor="acc-project">
                  Project Name <span style={{ color: 'var(--danger-color)' }}>*</span>
                </label>
                <div style={{ position: 'relative' }}>
                  <FolderKanban size={15} color="var(--text-muted)" style={{ position: 'absolute', left: '11px', top: '11px' }} />
                  <input
                    id="acc-project"
                    name="project_name"
                    type="text"
                    placeholder="e.g. Commercial High-Rise Core Framing"
                    value={formData.project_name}
                    onChange={handleChange}
                    className="form-input"
                    style={{ paddingLeft: '2.25rem' }}
                    required
                  />
                </div>
                {errors.project_name && <p className="form-error">{errors.project_name}</p>}
              </div>

              <div className="form-group">
                <label className="form-label" htmlFor="acc-status">Project Status</label>
                <select
                  id="acc-status"
                  name="status"
                  value={formData.status}
                  onChange={handleChange}
                  className="form-select"
                >
                  <option value="Active Project">Active Project</option>
                  <option value="In Detailing">In Detailing</option>
                  <option value="Fabrication Review">Fabrication Review</option>
                  <option value="Completed">Completed</option>
                  <option value="On Hold">On Hold</option>
                </select>
              </div>
            </div>

            {/* Client Representative Info (First Name & Last Name split) */}
            <div style={{
              backgroundColor: 'var(--bg-subtle)',
              border: '1px solid var(--border-subtle)',
              borderRadius: 'var(--radius-md)',
              padding: '1rem',
              marginBottom: '1rem'
            }}>
              <div style={{ 
                fontSize: '0.75rem', 
                fontWeight: 700, 
                color: 'var(--text-primary)', 
                marginBottom: '0.75rem', 
                display: 'flex', 
                alignItems: 'center', 
                gap: '0.4rem' 
              }}>
                <User size={14} color="var(--primary)" />
                <span>Client Representative (Assigned Contact for this Project)</span>
              </div>

              {/* First Name & Last Name & Designation */}
              <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(180px, 1fr))', gap: '0.75rem' }}>
                <div className="form-group" style={{ marginBottom: 0 }}>
                  <label className="form-label" htmlFor="acc-rep-first" style={{ fontSize: '0.75rem' }}>
                    First Name <span style={{ color: 'var(--danger-color)' }}>*</span>
                  </label>
                  <input
                    id="acc-rep-first"
                    name="rep_first_name"
                    type="text"
                    placeholder="e.g. Marcus"
                    value={formData.rep_first_name}
                    onChange={handleChange}
                    className="form-input"
                    required
                  />
                  {errors.rep_first_name && <p className="form-error">{errors.rep_first_name}</p>}
                </div>

                <div className="form-group" style={{ marginBottom: 0 }}>
                  <label className="form-label" htmlFor="acc-rep-last" style={{ fontSize: '0.75rem' }}>
                    Last Name <span style={{ color: 'var(--danger-color)' }}>*</span>
                  </label>
                  <input
                    id="acc-rep-last"
                    name="rep_last_name"
                    type="text"
                    placeholder="e.g. Sterling"
                    value={formData.rep_last_name}
                    onChange={handleChange}
                    className="form-input"
                    required
                  />
                  {errors.rep_last_name && <p className="form-error">{errors.rep_last_name}</p>}
                </div>

                <div className="form-group" style={{ marginBottom: 0 }}>
                  <label className="form-label" htmlFor="acc-rep-desig" style={{ fontSize: '0.75rem' }}>
                    Designation / Title
                  </label>
                  <input
                    id="acc-rep-desig"
                    name="rep_designation"
                    type="text"
                    placeholder="e.g. Chief Structural Engineer"
                    value={formData.rep_designation}
                    onChange={handleChange}
                    className="form-input"
                  />
                </div>
              </div>

              <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '0.75rem', marginTop: '0.75rem' }}>
                <div className="form-group" style={{ marginBottom: 0 }}>
                  <label className="form-label" htmlFor="acc-rep-email" style={{ fontSize: '0.75rem' }}>Rep Email</label>
                  <div style={{ position: 'relative' }}>
                    <Mail size={13} color="var(--text-muted)" style={{ position: 'absolute', left: '10px', top: '10px' }} />
                    <input
                      id="acc-rep-email"
                      name="rep_email"
                      type="email"
                      placeholder="m.sterling@company.com"
                      value={formData.rep_email}
                      onChange={handleChange}
                      className="form-input"
                      style={{ paddingLeft: '2rem' }}
                    />
                  </div>
                </div>

                <div className="form-group" style={{ marginBottom: 0 }}>
                  <label className="form-label" htmlFor="acc-rep-phone" style={{ fontSize: '0.75rem' }}>Rep Phone</label>
                  <div style={{ position: 'relative' }}>
                    <Phone size={13} color="var(--text-muted)" style={{ position: 'absolute', left: '10px', top: '10px' }} />
                    <input
                      id="acc-rep-phone"
                      name="rep_phone"
                      type="text"
                      placeholder="+1 (555) 019-2831"
                      value={formData.rep_phone}
                      onChange={handleChange}
                      className="form-input"
                      style={{ paddingLeft: '2rem' }}
                    />
                  </div>
                </div>
              </div>
            </div>

            {/* Financial & Detailing Metrics */}
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem' }}>
              <div className="form-group">
                <label className="form-label" htmlFor="acc-val">Contract / Deal Value ($)</label>
                <div style={{ position: 'relative' }}>
                  <DollarSign size={14} color="var(--text-muted)" style={{ position: 'absolute', left: '11px', top: '11px' }} />
                  <input
                    id="acc-val"
                    name="deal_value"
                    type="number"
                    step="500"
                    placeholder="e.g. 55000"
                    value={formData.deal_value}
                    onChange={handleChange}
                    className="form-input"
                    style={{ paddingLeft: '2.25rem' }}
                  />
                </div>
              </div>

              <div className="form-group">
                <label className="form-label" htmlFor="acc-tonnage">Estimated Steel Tonnage (Tons)</label>
                <div style={{ position: 'relative' }}>
                  <Weight size={14} color="var(--text-muted)" style={{ position: 'absolute', left: '11px', top: '11px' }} />
                  <input
                    id="acc-tonnage"
                    name="steel_tonnage"
                    type="number"
                    step="10"
                    placeholder="e.g. 350"
                    value={formData.steel_tonnage}
                    onChange={handleChange}
                    className="form-input"
                    style={{ paddingLeft: '2.25rem' }}
                  />
                </div>
              </div>
            </div>

            {/* Scope / Notes */}
            <div className="form-group" style={{ marginBottom: 0 }}>
              <label className="form-label" htmlFor="acc-notes">Scope of Work & Detailing Notes</label>
              <textarea
                id="acc-notes"
                name="notes"
                rows="3"
                placeholder="Connection design specifications, Tekla 3D model milestones, AISC standards..."
                value={formData.notes}
                onChange={handleChange}
                className="form-textarea"
              />
            </div>
          </div>

          {/* Footer */}
          <div className="modal-footer">
            <button
              type="button"
              className="btn btn-secondary"
              onClick={onClose}
              disabled={isSubmitting}
            >
              Cancel
            </button>
            <button
              type="submit"
              className="btn btn-primary"
              disabled={isSubmitting}
              style={{
                backgroundColor: 'var(--lead-action)',
                borderColor: 'var(--lead-action)',
                color: 'white'
              }}
            >
              <CheckCircle size={15} />
              <span>{isSubmitting ? 'Saving...' : currentEditingAccount ? 'Update Account' : 'Create Account & Project'}</span>
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
