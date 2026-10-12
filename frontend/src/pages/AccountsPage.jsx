import React, { useState, useMemo, useEffect } from 'react';
import { 
  Building2, 
  FolderKanban, 
  User, 
  Plus, 
  Search, 
  Filter, 
  DollarSign, 
  Weight, 
  Calendar, 
  Edit3, 
  Trash2, 
  Mail, 
  Phone, 
  CheckCircle2, 
  Clock, 
  AlertCircle, 
  Briefcase, 
  Layers, 
  Table as TableIcon, 
  LayoutGrid, 
  ChevronDown, 
  ChevronRight, 
  ChevronLeft, 
  ExternalLink,
  UploadCloud 
} from 'lucide-react';
import ExportDropdown from '../components/ExportDropdown';

export default function AccountsPage({
  accounts = [],
  onOpenNewAccount,
  onEditAccount,
  onDeleteAccount,
  onScheduleFollowup,
  clients = [],
  availableClients = [],
  onOpenExportModal,
  onOpenImportModal
}) {
  const [search, setSearch] = useState('');
  const [statusFilter, setStatusFilter] = useState('all');
  const [companyFilter, setCompanyFilter] = useState('all');
  const [viewMode, setViewMode] = useState('grouped'); // 'grouped' or 'table'
  const [expandedCompanies, setExpandedCompanies] = useState({});
  const [page, setPage] = useState(1);
  const [pageSize, setPageSize] = useState(25);

  useEffect(() => {
    setPage(1);
  }, [search, statusFilter, companyFilter, viewMode]);

  // Unique companies list for filtering
  const uniqueCompanies = useMemo(() => {
    const set = new Set();
    accounts.forEach(a => {
      if (a.company) set.add(a.company);
    });
    return Array.from(set).sort();
  }, [accounts]);

  // Filtered accounts
  const filteredAccounts = useMemo(() => {
    return accounts.filter(acc => {
      const matchSearch = !search.trim() || 
        acc.account_name.toLowerCase().includes(search.toLowerCase()) ||
        acc.company.toLowerCase().includes(search.toLowerCase()) ||
        acc.project_name.toLowerCase().includes(search.toLowerCase()) ||
        acc.client_representative.toLowerCase().includes(search.toLowerCase()) ||
        (acc.rep_email && acc.rep_email.toLowerCase().includes(search.toLowerCase())) ||
        (acc.notes && acc.notes.toLowerCase().includes(search.toLowerCase()));

      const matchStatus = statusFilter === 'all' || acc.status === statusFilter;
      const matchCompany = companyFilter === 'all' || acc.company.toLowerCase() === companyFilter.toLowerCase();

      return matchSearch && matchStatus && matchCompany;
    });
  }, [accounts, search, statusFilter, companyFilter]);

  // Group accounts by company
  const groupedByCompany = useMemo(() => {
    const groups = {};
    filteredAccounts.forEach(acc => {
      const comp = acc.company || 'Independent Projects';
      if (!groups[comp]) {
        groups[comp] = {
          company: comp,
          items: [],
          totalValue: 0,
          totalTonnage: 0,
          representatives: new Set()
        };
      }
      groups[comp].items.push(acc);
      groups[comp].totalValue += acc.deal_value || 0;
      groups[comp].totalTonnage += acc.steel_tonnage || 0;
      if (acc.client_representative) {
        groups[comp].representatives.add(acc.client_representative);
      }
    });
    return Object.values(groups);
  }, [filteredAccounts]);

  // Pagination computations
  const totalItems = viewMode === 'grouped' ? groupedByCompany.length : filteredAccounts.length;
  const totalPages = Math.ceil(totalItems / pageSize) || 1;

  const paginatedGroups = useMemo(() => {
    return groupedByCompany.slice((page - 1) * pageSize, page * pageSize);
  }, [groupedByCompany, page, pageSize]);

  const paginatedAccounts = useMemo(() => {
    return filteredAccounts.slice((page - 1) * pageSize, page * pageSize);
  }, [filteredAccounts, page, pageSize]);

  // Overall metrics
  const totalValue = useMemo(() => accounts.reduce((sum, a) => sum + (a.deal_value || 0), 0), [accounts]);
  const activeCount = useMemo(() => accounts.filter(a => a.status === 'Active Project' || a.status === 'In Detailing').length, [accounts]);
  const totalTonnage = useMemo(() => accounts.reduce((sum, a) => sum + (a.steel_tonnage || 0), 0), [accounts]);

  const toggleCompany = (companyName) => {
    setExpandedCompanies(prev => ({
      ...prev,
      [companyName]: prev[companyName] === false ? true : false
    }));
  };

  const getStatusBadge = (status) => {
    switch (status) {
      case 'Active Project':
        return { bg: 'rgba(16, 185, 129, 0.1)', color: '#10B981', border: 'rgba(16, 185, 129, 0.25)' };
      case 'In Detailing':
        return { bg: 'rgba(59, 130, 246, 0.1)', color: '#3B82F6', border: 'rgba(59, 130, 246, 0.25)' };
      case 'Fabrication Review':
        return { bg: 'rgba(139, 92, 246, 0.1)', color: '#8B5CF6', border: 'rgba(139, 92, 246, 0.25)' };
      case 'Completed':
        return { bg: 'rgba(5, 150, 105, 0.12)', color: '#059669', border: 'rgba(5, 150, 105, 0.25)' };
      case 'On Hold':
        return { bg: 'rgba(239, 68, 68, 0.1)', color: '#EF4444', border: 'rgba(239, 68, 68, 0.25)' };
      default:
        return { bg: 'var(--bg-subtle)', color: 'var(--text-secondary)', border: 'var(--border-subtle)' };
    }
  };

  return (
    <div className="page-container" style={{ paddingBottom: '3rem' }}>
      {/* Top Banner & Header */}
      <div style={{
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
        flexWrap: 'wrap',
        gap: '1rem',
        marginBottom: '1.25rem'
      }}>
        <div>
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
            <div style={{
              width: '38px',
              height: '38px',
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
              <h2 style={{ fontSize: '1.35rem', fontWeight: 800, color: 'var(--text-primary)', margin: 0 }}>
                Accounts & Projects
              </h2>
              <p style={{ fontSize: '0.785rem', color: 'var(--text-muted)', margin: 0, marginTop: '2px' }}>
                Corporate clients with multiple detailing projects and distinct client representatives
              </p>
            </div>
          </div>
        </div>

        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', flexWrap: 'wrap' }}>
          {/* Import Excel Button for Accounts */}
          {onOpenImportModal && (
            <button 
              className="btn btn-secondary" 
              onClick={onOpenImportModal}
              title="Import accounts and projects from Excel (.xlsx) or CSV"
            >
              <UploadCloud size={14} />
              <span>Import Excel</span>
            </button>
          )}

          {/* Export Dropdown for Accounts */}
          <ExportDropdown 
            type="accounts" 
            onOpenModal={onOpenExportModal} 
          />

          <button 
            className="btn btn-primary"
            onClick={onOpenNewAccount}
            style={{
              backgroundColor: 'var(--lead-action)',
              borderColor: 'var(--lead-action)',
              color: 'white',
              display: 'flex',
              alignItems: 'center',
              gap: '0.45rem'
            }}
          >
            <Plus size={16} />
            <span>New Account / Project</span>
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
            Total Accounts
          </div>
          <div style={{ fontSize: '1.65rem', fontWeight: 800, color: 'var(--text-primary)', marginTop: '0.2rem' }}>
            {accounts.length}
          </div>
          <div style={{ fontSize: '0.7rem', color: 'var(--text-secondary)', marginTop: '0.2rem' }}>
            Across {uniqueCompanies.length} Corporate Companies
          </div>
        </div>

        <div className="card" style={{ padding: '0.95rem 1.15rem' }}>
          <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', fontWeight: 600, textTransform: 'uppercase' }}>
            Active Projects
          </div>
          <div style={{ fontSize: '1.65rem', fontWeight: 800, color: 'var(--lead-action)', marginTop: '0.2rem' }}>
            {activeCount}
          </div>
          <div style={{ fontSize: '0.7rem', color: 'var(--text-secondary)', marginTop: '0.2rem' }}>
            In Active Detailing & Fabrication
          </div>
        </div>

        <div className="card" style={{ padding: '0.95rem 1.15rem' }}>
          <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', fontWeight: 600, textTransform: 'uppercase' }}>
            Total Contract Value
          </div>
          <div style={{ fontSize: '1.65rem', fontWeight: 800, color: '#10B981', marginTop: '0.2rem' }}>
            ${totalValue.toLocaleString()}
          </div>
          <div style={{ fontSize: '0.7rem', color: 'var(--text-secondary)', marginTop: '0.2rem' }}>
            Won & Active Pipeline
          </div>
        </div>

        <div className="card" style={{ padding: '0.95rem 1.15rem' }}>
          <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', fontWeight: 600, textTransform: 'uppercase' }}>
            Estimated Tonnage
          </div>
          <div style={{ fontSize: '1.65rem', fontWeight: 800, color: 'var(--primary)', marginTop: '0.2rem' }}>
            {totalTonnage.toLocaleString()} Tons
          </div>
          <div style={{ fontSize: '0.7rem', color: 'var(--text-secondary)', marginTop: '0.2rem' }}>
            Structural Steel Detailing Scope
          </div>
        </div>
      </div>

      {/* Search & Filter Toolbar */}
      <div className="card" style={{ padding: '0.85rem 1rem', marginBottom: '1.25rem' }}>
        <div style={{
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          flexWrap: 'wrap',
          gap: '0.75rem'
        }}>
          {/* Search Box */}
          <div style={{ flex: '1 1 240px', position: 'relative' }}>
            <Search size={14} color="var(--text-muted)" style={{ position: 'absolute', left: '10px', top: '10px' }} />
            <input
              type="text"
              placeholder="Search projects, companies, or client representatives..."
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="form-input"
              style={{ paddingLeft: '2rem', paddingRight: '1rem', fontSize: '0.825rem', height: '36px' }}
            />
          </div>

          <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', flexWrap: 'wrap' }}>
            {/* Company Filter */}
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
              <Building2 size={13} color="var(--text-muted)" />
              <select
                value={companyFilter}
                onChange={(e) => setCompanyFilter(e.target.value)}
                className="form-select"
                style={{ fontSize: '0.8rem', height: '36px', padding: '0.25rem 0.65rem' }}
              >
                <option value="all">All Companies ({uniqueCompanies.length})</option>
                {uniqueCompanies.map(c => (
                  <option key={c} value={c}>{c}</option>
                ))}
              </select>
            </div>

            {/* Status Filter */}
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
              <Filter size={13} color="var(--text-muted)" />
              <select
                value={statusFilter}
                onChange={(e) => setStatusFilter(e.target.value)}
                className="form-select"
                style={{ fontSize: '0.8rem', height: '36px', padding: '0.25rem 0.65rem' }}
              >
                <option value="all">All Statuses</option>
                <option value="Active Project">Active Project</option>
                <option value="In Detailing">In Detailing</option>
                <option value="Fabrication Review">Fabrication Review</option>
                <option value="Completed">Completed</option>
                <option value="On Hold">On Hold</option>
              </select>
            </div>

            {/* View Mode Switcher */}
            <div style={{
              display: 'flex',
              backgroundColor: 'var(--bg-subtle)',
              border: '1px solid var(--border-subtle)',
              borderRadius: 'var(--radius-md)',
              padding: '2px'
            }}>
              <button
                onClick={() => setViewMode('grouped')}
                style={{
                  border: 'none',
                  background: viewMode === 'grouped' ? 'var(--bg-surface)' : 'transparent',
                  color: viewMode === 'grouped' ? 'var(--text-primary)' : 'var(--text-muted)',
                  padding: '0.35rem 0.65rem',
                  borderRadius: 'var(--radius-sm)',
                  cursor: 'pointer',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.3rem',
                  fontSize: '0.75rem',
                  fontWeight: viewMode === 'grouped' ? 600 : 500,
                  boxShadow: viewMode === 'grouped' ? 'var(--shadow-xs)' : 'none'
                }}
                title="Company-Grouped Cards"
              >
                <Layers size={13} />
                <span>By Company</span>
              </button>
              <button
                onClick={() => setViewMode('table')}
                style={{
                  border: 'none',
                  background: viewMode === 'table' ? 'var(--bg-surface)' : 'transparent',
                  color: viewMode === 'table' ? 'var(--text-primary)' : 'var(--text-muted)',
                  padding: '0.35rem 0.65rem',
                  borderRadius: 'var(--radius-sm)',
                  cursor: 'pointer',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.3rem',
                  fontSize: '0.75rem',
                  fontWeight: viewMode === 'table' ? 600 : 500,
                  boxShadow: viewMode === 'table' ? 'var(--shadow-xs)' : 'none'
                }}
                title="Flat Table View"
              >
                <TableIcon size={13} />
                <span>Table</span>
              </button>
            </div>
          </div>
        </div>
      </div>

      {/* Main Content Area */}
      {filteredAccounts.length === 0 ? (
        <div className="card" style={{ padding: '3.5rem 1.5rem', textAlign: 'center' }}>
          <Building2 size={38} color="var(--text-muted)" style={{ margin: '0 auto 0.75rem auto', opacity: 0.6 }} />
          <h3 style={{ fontSize: '1.05rem', fontWeight: 700, color: 'var(--text-primary)', marginBottom: '0.35rem' }}>
            No accounts found
          </h3>
          <p style={{ fontSize: '0.8rem', color: 'var(--text-muted)', marginBottom: '1.25rem' }}>
            {search || statusFilter !== 'all' || companyFilter !== 'all'
              ? 'Try adjusting your search query or company filters.'
              : 'Converted leads turn into accounts with multiple projects and representatives.'}
          </p>
          <button
            className="btn btn-primary btn-sm"
            onClick={onOpenNewAccount}
            style={{
              backgroundColor: 'var(--lead-action)',
              borderColor: 'var(--lead-action)',
              color: 'white'
            }}
          >
            <Plus size={14} />
            <span>Add First Account</span>
          </button>
        </div>
      ) : viewMode === 'grouped' ? (
        /* Company-Grouped Accordion View */
        <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>
          {paginatedGroups.map(group => {
            const isCollapsed = expandedCompanies[group.company] === false;
            return (
              <div 
                key={group.company}
                className="card"
                style={{ padding: 0, overflow: 'hidden' }}
              >
                {/* Company Header Row */}
                <div 
                  onClick={() => toggleCompany(group.company)}
                  style={{
                    padding: '1rem 1.25rem',
                    backgroundColor: 'var(--bg-subtle)',
                    borderBottom: isCollapsed ? 'none' : '1px solid var(--border-subtle)',
                    cursor: 'pointer',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'space-between',
                    flexWrap: 'wrap',
                    gap: '0.75rem',
                    transition: 'background-color 0.15s ease'
                  }}
                >
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
                    <div style={{ color: 'var(--text-muted)' }}>
                      {isCollapsed ? <ChevronRight size={16} /> : <ChevronDown size={16} />}
                    </div>
                    <div style={{
                      width: '32px',
                      height: '32px',
                      borderRadius: 'var(--radius-md)',
                      backgroundColor: 'var(--lead-surface)',
                      color: 'var(--lead-action)',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      fontWeight: 800,
                      fontSize: '0.85rem'
                    }}>
                      {group.company[0]}
                    </div>
                    <div>
                      <div style={{ fontSize: '1rem', fontWeight: 800, color: 'var(--text-primary)', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                        <span>{group.company}</span>
                        <span style={{
                          fontSize: '0.68rem',
                          fontWeight: 700,
                          padding: '0.1rem 0.5rem',
                          borderRadius: 'var(--radius-full)',
                          backgroundColor: 'var(--bg-surface)',
                          color: 'var(--text-secondary)',
                          border: '1px solid var(--border-subtle)'
                        }}>
                          {group.items.length} {group.items.length === 1 ? 'Project' : 'Projects'}
                        </span>
                      </div>
                      <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', marginTop: '2px' }}>
                        {group.representatives.size} Client Representative(s): {Array.from(group.representatives).join(', ')}
                      </div>
                    </div>
                  </div>

                  <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }} onClick={(e) => e.stopPropagation()}>
                    <div style={{ textAlign: 'right' }}>
                      <div style={{ fontSize: '0.95rem', fontWeight: 800, color: '#10B981' }}>
                        ${group.totalValue.toLocaleString()}
                      </div>
                      <div style={{ fontSize: '0.68rem', color: 'var(--text-muted)' }}>
                        {group.totalTonnage > 0 ? `${group.totalTonnage.toLocaleString()} Tons` : 'Combined Value'}
                      </div>
                    </div>

                    <button
                      className="btn btn-secondary btn-sm"
                      onClick={() => onOpenNewAccount(group.items[0])}
                      title={`Add another project for ${group.company}`}
                      style={{ fontSize: '0.75rem', height: '30px' }}
                    >
                      <Plus size={13} />
                      <span>Add Project</span>
                    </button>
                  </div>
                </div>

                {/* Projects List under this Company */}
                {!isCollapsed && (
                  <div style={{ padding: '0.75rem 1.25rem', display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
                    {group.items.map(acc => {
                      const badge = getStatusBadge(acc.status);
                      return (
                        <div
                          key={acc.id}
                          style={{
                            padding: '0.85rem 1rem',
                            backgroundColor: 'var(--bg-surface)',
                            border: '1px solid var(--border-subtle)',
                            borderRadius: 'var(--radius-md)',
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'space-between',
                            flexWrap: 'wrap',
                            gap: '1rem',
                            transition: 'all 0.15s ease'
                          }}
                          className="project-subcard"
                        >
                          {/* Project info & Account Name */}
                          <div style={{ flex: '1 1 280px' }}>
                            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', marginBottom: '0.25rem', flexWrap: 'wrap' }}>
                              <h4 style={{ fontSize: '0.9rem', fontWeight: 700, color: 'var(--text-primary)', margin: 0 }}>
                                {acc.project_name}
                              </h4>
                              <span style={{
                                fontSize: '0.65rem',
                                fontWeight: 700,
                                padding: '0.1rem 0.45rem',
                                borderRadius: 'var(--radius-full)',
                                backgroundColor: badge.bg,
                                color: badge.color,
                                border: `1px solid ${badge.border}`
                              }}>
                                {acc.status}
                              </span>
                            </div>
                            <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)', marginBottom: '0.35rem' }}>
                              Account: <strong style={{ color: 'var(--text-secondary)' }}>{acc.account_name}</strong>
                            </div>
                            {acc.notes && (
                              <p style={{ fontSize: '0.72rem', color: 'var(--text-muted)', margin: 0, fontStyle: 'italic', lineHeight: '1.3' }}>
                                {acc.notes}
                              </p>
                            )}
                          </div>

                          {/* Client Representative Assigned to this Project */}
                          <div style={{
                            padding: '0.45rem 0.75rem',
                            backgroundColor: 'var(--bg-subtle)',
                            borderRadius: 'var(--radius-md)',
                            border: '1px solid var(--border-subtle)',
                            minWidth: '220px'
                          }}>
                            <div style={{ display: 'flex', alignItems: 'center', gap: '0.4rem', marginBottom: '0.2rem' }}>
                              <User size={13} color="var(--primary)" />
                              <strong style={{ fontSize: '0.78rem', color: 'var(--text-primary)' }}>
                                {acc.client_representative}
                              </strong>
                              {acc.rep_designation && (
                                <span style={{ fontSize: '0.68rem', color: 'var(--text-muted)' }}>
                                  ({acc.rep_designation})
                                </span>
                              )}
                            </div>
                            <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', fontSize: '0.7rem', color: 'var(--text-muted)' }}>
                              {acc.rep_email && (
                                <a href={`mailto:${acc.rep_email}`} style={{ color: 'var(--text-muted)', textDecoration: 'none', display: 'flex', alignItems: 'center', gap: '0.25rem' }}>
                                  <Mail size={11} />
                                  <span>{acc.rep_email}</span>
                                </a>
                              )}
                              {acc.rep_phone && (
                                <span style={{ display: 'flex', alignItems: 'center', gap: '0.25rem' }}>
                                  <Phone size={11} />
                                  <span>{acc.rep_phone}</span>
                                </span>
                              )}
                            </div>
                          </div>

                          {/* Project Financials & Actions */}
                          <div style={{ display: 'flex', alignItems: 'center', gap: '1.25rem' }}>
                            <div style={{ textAlign: 'right' }}>
                              <div style={{ fontSize: '0.95rem', fontWeight: 800, color: 'var(--text-primary)' }}>
                                ${acc.deal_value ? acc.deal_value.toLocaleString() : '0'}
                              </div>
                              <div style={{ fontSize: '0.68rem', color: 'var(--text-muted)' }}>
                                {acc.steel_tonnage ? `${acc.steel_tonnage} Tons Steel` : 'Fixed Contract'}
                              </div>
                            </div>

                            <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
                              <button
                                className="btn btn-secondary btn-icon"
                                onClick={() => onEditAccount(acc)}
                                title="Edit project & representative"
                                style={{ width: '30px', height: '30px' }}
                              >
                                <Edit3 size={13} />
                              </button>
                              <button
                                className="btn btn-secondary btn-icon"
                                onClick={() => onDeleteAccount(acc.id)}
                                title="Delete account project"
                                style={{ width: '30px', height: '30px', color: 'var(--danger-color)' }}
                              >
                                <Trash2 size={13} />
                              </button>
                            </div>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                )}
              </div>
            );
          })}
        </div>
      ) : (
        /* Structured Table View */
        <div className="table-responsive">
          <table className="custom-table">
            <thead>
              <tr>
                <th>Account & Project</th>
                <th>Company</th>
                <th>Client Representative</th>
                <th>Contact</th>
                <th>Value ($)</th>
                <th>Tonnage</th>
                <th>Status</th>
                <th style={{ textAlign: 'right' }}>Actions</th>
              </tr>
            </thead>
            <tbody>
              {paginatedAccounts.map(acc => {
                const badge = getStatusBadge(acc.status);
                return (
                  <tr key={acc.id}>
                    <td>
                      <div style={{ fontWeight: 700, color: 'var(--text-primary)', fontSize: '0.85rem' }}>
                        {acc.project_name}
                      </div>
                      <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)' }}>
                        {acc.account_name}
                      </div>
                    </td>
                    <td>
                      <strong style={{ color: 'var(--text-primary)', fontSize: '0.8rem' }}>
                        {acc.company}
                      </strong>
                    </td>
                    <td>
                      <div style={{ fontSize: '0.8rem', fontWeight: 600 }}>
                        {acc.client_representative}
                      </div>
                      {acc.rep_designation && (
                        <div style={{ fontSize: '0.68rem', color: 'var(--text-muted)' }}>
                          {acc.rep_designation}
                        </div>
                      )}
                    </td>
                    <td style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                      <div>{acc.rep_email || '—'}</div>
                      <div>{acc.rep_phone || ''}</div>
                    </td>
                    <td>
                      <strong style={{ color: '#10B981', fontSize: '0.85rem' }}>
                        ${acc.deal_value ? acc.deal_value.toLocaleString() : '0'}
                      </strong>
                    </td>
                    <td style={{ fontSize: '0.78rem', color: 'var(--text-secondary)' }}>
                      {acc.steel_tonnage ? `${acc.steel_tonnage} T` : '—'}
                    </td>
                    <td>
                      <span style={{
                        fontSize: '0.65rem',
                        fontWeight: 700,
                        padding: '0.15rem 0.45rem',
                        borderRadius: 'var(--radius-full)',
                        backgroundColor: badge.bg,
                        color: badge.color,
                        border: `1px solid ${badge.border}`
                      }}>
                        {acc.status}
                      </span>
                    </td>
                    <td style={{ textAlign: 'right' }}>
                      <div style={{ display: 'inline-flex', gap: '0.3rem' }}>
                        <button
                          className="btn btn-secondary btn-icon"
                          onClick={() => onEditAccount(acc)}
                          title="Edit Account"
                          style={{ width: '28px', height: '28px' }}
                        >
                          <Edit3 size={13} />
                        </button>
                        <button
                          className="btn btn-secondary btn-icon"
                          onClick={() => onDeleteAccount(acc.id)}
                          title="Delete Account"
                          style={{ width: '28px', height: '28px', color: 'var(--danger-color)' }}
                        >
                          <Trash2 size={13} />
                        </button>
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      )}

      {/* Pagination Controls */}
      {filteredAccounts.length > 0 && (
        <div style={{
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          flexWrap: 'wrap',
          gap: '0.75rem',
          marginTop: '1.5rem',
          padding: '0.85rem 1.15rem',
          backgroundColor: 'var(--bg-surface)',
          borderRadius: 'var(--radius-md)',
          border: '1px solid var(--border-subtle)',
          boxShadow: 'var(--shadow-xs)'
        }}>
          <div style={{ fontSize: '0.8rem', color: 'var(--text-secondary)' }}>
            Showing <strong>{((page - 1) * pageSize) + 1}</strong>–<strong>{Math.min(page * pageSize, totalItems)}</strong> of <strong>{totalItems.toLocaleString()}</strong> {viewMode === 'grouped' ? 'companies' : 'projects'}
          </div>

          <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', flexWrap: 'wrap' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', fontSize: '0.75rem', color: 'var(--text-muted)' }}>
              <span>Per page:</span>
              <select
                value={pageSize}
                onChange={(e) => { setPageSize(Number(e.target.value)); setPage(1); }}
                className="form-select"
                style={{ fontSize: '0.75rem', height: '30px', padding: '0.1rem 0.5rem' }}
              >
                <option value={25}>25</option>
                <option value={50}>50</option>
                <option value={100}>100</option>
              </select>
            </div>

            <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
              <button
                className="btn btn-secondary btn-sm"
                disabled={page <= 1}
                onClick={() => setPage(p => Math.max(1, p - 1))}
                style={{ fontSize: '0.75rem', height: '30px', padding: '0 0.65rem', display: 'flex', alignItems: 'center', gap: '0.25rem' }}
              >
                <ChevronLeft size={13} />
                <span>Prev</span>
              </button>

              <span style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--text-primary)', padding: '0 0.5rem' }}>
                Page {page} of {totalPages}
              </span>

              <button
                className="btn btn-secondary btn-sm"
                disabled={page >= totalPages}
                onClick={() => setPage(p => Math.min(totalPages, p + 1))}
                style={{ fontSize: '0.75rem', height: '30px', padding: '0 0.65rem', display: 'flex', alignItems: 'center', gap: '0.25rem' }}
              >
                <span>Next</span>
                <ChevronRight size={13} />
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
