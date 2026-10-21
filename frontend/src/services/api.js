// API client service communicating with FastAPI backend
const RAW_API_URL = import.meta.env.VITE_API_URL || '';
const API_BASE = RAW_API_URL ? `${RAW_API_URL.replace(/\/+$/, '')}/api` : '/api';

function getAuthHeaders(existingHeaders = {}) {
  const headers = { ...existingHeaders };
  try {
    const userStr = localStorage.getItem('currentUser');
    if (userStr) {
      const user = JSON.parse(userStr);
      if (user.name) headers['X-User-Name'] = user.name;
      if (user.username) headers['X-User-Username'] = user.username;
    }
  } catch (e) {
    // quiet fallback
  }
  return headers;
}

export const api = {
  // Authentication & Users
  async login(username, password) {
    const res = await fetch(`${API_BASE}/auth/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ username, password })
    });
    if (!res.ok) {
      const err = await res.json().catch(() => ({}));
      throw new Error(err.detail || 'Invalid username or password');
    }
    const data = await res.json();
    if (data.user) {
      localStorage.setItem('currentUser', JSON.stringify(data.user));
    }
    return data;
  },

  async getUsers() {
    const res = await fetch(`${API_BASE}/auth/users`);
    if (!res.ok) throw new Error('Failed to fetch users');
    return res.json();
  },

  async getCurrentUser() {
    const res = await fetch(`${API_BASE}/auth/me`, {
      headers: getAuthHeaders()
    });
    if (!res.ok) throw new Error('Failed to fetch current user');
    return res.json();
  },

  // Activity Logs
  async getLogs(params = {}) {
    const query = new URLSearchParams();
    if (params.limit) query.set('limit', params.limit);
    if (params.action) query.set('action', params.action);
    if (params.entity_type) query.set('entity_type', params.entity_type);
    if (params.user) query.set('user', params.user);
    if (params.search) query.set('search', params.search);

    const res = await fetch(`${API_BASE}/logs?${query.toString()}`);
    if (!res.ok) throw new Error('Failed to fetch activity logs');
    return res.json();
  },

  async getLogStats() {
    const res = await fetch(`${API_BASE}/logs/stats`);
    if (!res.ok) throw new Error('Failed to fetch activity log stats');
    return res.json();
  },

  // Clients
  async getClients(params = {}) {
    const query = new URLSearchParams();
    if (params.is_lead !== undefined) query.set('is_lead', params.is_lead);
    if (params.status) query.set('status', params.status);
    if (params.category) query.set('category', params.category);
    if (params.positive_only) query.set('positive_only', 'true');
    if (params.search) query.set('search', params.search);

    const res = await fetch(`${API_BASE}/clients?${query.toString()}`);
    if (!res.ok) throw new Error('Failed to fetch clients');
    return res.json();
  },

  async getClient(id) {
    const res = await fetch(`${API_BASE}/clients/${id}`);
    if (!res.ok) throw new Error('Failed to fetch client details');
    return res.json();
  },

  async createClient(data) {
    const res = await fetch(`${API_BASE}/clients`, {
      method: 'POST',
      headers: getAuthHeaders({ 'Content-Type': 'application/json' }),
      body: JSON.stringify(data)
    });
    if (!res.ok) throw new Error('Failed to create client');
    return res.json();
  },

  async updateClient(id, data) {
    const res = await fetch(`${API_BASE}/clients/${id}`, {
      method: 'PUT',
      headers: getAuthHeaders({ 'Content-Type': 'application/json' }),
      body: JSON.stringify(data)
    });
    if (!res.ok) throw new Error('Failed to update client');
    return res.json();
  },

  async addClientNote(clientId, content, createdAt = null) {
    const res = await fetch(`${API_BASE}/clients/${clientId}/notes`, {
      method: 'POST',
      headers: getAuthHeaders({ 'Content-Type': 'application/json' }),
      body: JSON.stringify({ content, created_at: createdAt })
    });
    if (!res.ok) throw new Error('Failed to add note');
    return res.json();
  },

  async updateClientNote(clientId, noteId, content, createdAt = null) {
    const res = await fetch(`${API_BASE}/clients/${clientId}/notes/${noteId}`, {
      method: 'PUT',
      headers: getAuthHeaders({ 'Content-Type': 'application/json' }),
      body: JSON.stringify({ content, created_at: createdAt })
    });
    if (!res.ok) throw new Error('Failed to update note');
    return res.json();
  },

  async deleteClientNote(clientId, noteId) {
    const res = await fetch(`${API_BASE}/clients/${clientId}/notes/${noteId}`, {
      method: 'DELETE',
      headers: getAuthHeaders()
    });
    if (!res.ok) throw new Error('Failed to delete note');
    return res.json();
  },

  async deleteClient(id) {
    const res = await fetch(`${API_BASE}/clients/${id}`, {
      method: 'DELETE',
      headers: getAuthHeaders()
    });
    if (!res.ok) throw new Error('Failed to delete client');
    return res.json();
  },

  async promoteToLead(id) {
    const res = await fetch(`${API_BASE}/clients/${id}/promote-to-lead`, {
      method: 'PATCH',
      headers: getAuthHeaders()
    });
    if (!res.ok) throw new Error('Failed to promote client to lead');
    return res.json();
  },

  async toggleAccountConversion(id) {
    const res = await fetch(`${API_BASE}/clients/${id}/toggle-account`, {
      method: 'PATCH',
      headers: getAuthHeaders()
    });
    if (!res.ok) throw new Error('Failed to update account conversion');
    return res.json();
  },

  async toggleProspect(id) {
    const res = await fetch(`${API_BASE}/clients/${id}/toggle-prospect`, {
      method: 'PATCH',
      headers: getAuthHeaders()
    });
    if (!res.ok) throw new Error('Failed to update prospect flag');
    return res.json();
  },

  async logFollowup(id, { note, nextFollowupAt }) {
    const res = await fetch(`${API_BASE}/clients/${id}/log-followup`, {
      method: 'POST',
      headers: getAuthHeaders({ 'Content-Type': 'application/json' }),
      body: JSON.stringify({ note: note || null, next_followup_at: nextFollowupAt || null })
    });
    if (!res.ok) throw new Error('Failed to save follow-up');
    return res.json();
  },

  async toggleNegative(id) {
    const res = await fetch(`${API_BASE}/clients/${id}/toggle-negative`, {
      method: 'PATCH',
      headers: getAuthHeaders()
    });
    if (!res.ok) throw new Error('Failed to update negative mark');
    return res.json();
  },

  async togglePositive(id) {
    const res = await fetch(`${API_BASE}/clients/${id}/toggle-positive`, {
      method: 'PATCH',
      headers: getAuthHeaders()
    });
    if (!res.ok) throw new Error('Failed to toggle positive approach');
    return res.json();
  },

  // Followups & Meetups
  async getFollowups(params = {}) {
    const query = new URLSearchParams();
    if (params.today_only) query.set('today_only', 'true');
    if (params.upcoming_only) query.set('upcoming_only', 'true');
    if (params.client_id) query.set('client_id', params.client_id);
    if (params.type) query.set('type', params.type);
    if (params.status) query.set('status', params.status);
    if (params.priority) query.set('priority', params.priority);

    const res = await fetch(`${API_BASE}/followups?${query.toString()}`);
    if (!res.ok) throw new Error('Failed to fetch followups');
    return res.json();
  },

  async createFollowup(data) {
    const res = await fetch(`${API_BASE}/followups`, {
      method: 'POST',
      headers: getAuthHeaders({ 'Content-Type': 'application/json' }),
      body: JSON.stringify(data)
    });
    if (!res.ok) throw new Error('Failed to schedule followup');
    return res.json();
  },

  async updateFollowup(id, data) {
    const res = await fetch(`${API_BASE}/followups/${id}`, {
      method: 'PUT',
      headers: getAuthHeaders({ 'Content-Type': 'application/json' }),
      body: JSON.stringify(data)
    });
    if (!res.ok) throw new Error('Failed to update followup');
    return res.json();
  },

  async completeFollowup(id, { isPositive = false, convertToLead = false, notes = '' } = {}) {
    const query = new URLSearchParams({
      is_positive: String(isPositive),
      convert_to_lead: String(convertToLead),
    });
    if (notes) query.set('notes', notes);

    const res = await fetch(`${API_BASE}/followups/${id}/complete?${query.toString()}`, {
      method: 'PATCH',
      headers: getAuthHeaders()
    });
    if (!res.ok) throw new Error('Failed to complete followup');
    return res.json();
  },

  async deleteFollowup(id) {
    const res = await fetch(`${API_BASE}/followups/${id}`, {
      method: 'DELETE',
      headers: getAuthHeaders()
    });
    if (!res.ok) throw new Error('Failed to delete followup');
    return res.json();
  },

  // Dashboard & Schedule
  async getDashboardStats() {
    const res = await fetch(`${API_BASE}/dashboard/stats`);
    if (!res.ok) throw new Error('Failed to fetch dashboard stats');
    return res.json();
  },

  async getTodaySchedule() {
    const res = await fetch(`${API_BASE}/dashboard/today`);
    if (!res.ok) throw new Error('Failed to fetch today schedule');
    return res.json();
  },

  // Notifications
  async getNotifications() {
    const res = await fetch(`${API_BASE}/notifications`);
    if (!res.ok) throw new Error('Failed to fetch notifications');
    return res.json();
  },

  async markNotificationRead(id) {
    const res = await fetch(`${API_BASE}/notifications/${id}/read`, {
      method: 'POST'
    });
    return res.json();
  },

  async markAllNotificationsRead() {
    const res = await fetch(`${API_BASE}/notifications/mark-all-read`, {
      method: 'POST'
    });
    return res.json();
  },

  async checkReminders() {
    const res = await fetch(`${API_BASE}/notifications/check-reminders`);
    if (!res.ok) throw new Error('Failed to check reminders');
    return res.json();
  },

  // Export & Import URLs - Clients & Leads
  getExportUrl(format) {
    return `${API_BASE}/export/${format}`;
  },

  getImportTemplateUrl() {
    return `${API_BASE}/export/template`;
  },

  async importExcel(file) {
    const formData = new FormData();
    formData.append('file', file);
    const res = await fetch(`${API_BASE}/export/import-excel`, {
      method: 'POST',
      headers: getAuthHeaders(),
      body: formData
    });
    if (!res.ok) {
      const errData = await res.json().catch(() => ({}));
      throw new Error(errData.detail || 'Failed to import Excel spreadsheet');
    }
    return res.json();
  },

  // Database status (PostgreSQL / SQLite info for pgAdmin controls)
  async getDbStatus() {
    const res = await fetch(`${API_BASE}/db-status`);
    if (!res.ok) throw new Error('Failed to fetch database status');
    return res.json();
  }
};
