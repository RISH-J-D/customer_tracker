// Phone fields are free text ("1) 555-123-4567 - Office   2) …", "a / b").
// Put each number on its own line and keep each number unbroken (non-breaking hyphens and area-code space).
export const splitPhoneNumbers = (phone) =>
  String(phone)
    .split(/\s*[\/;]\s*|\s*,\s+|\s{3,}|\s+(?=\d\)\s)/)
    .map(part => part.trim().replace(/(\d)-(?=\d)/g, '$1\u2011').replace(/\)\s+(?=\d)/g, ')\u00A0'))
    .filter(Boolean);
