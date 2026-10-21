import { Capacitor } from '@capacitor/core';
import { LocalNotifications } from '@capacitor/local-notifications';

class NotificationService {
  constructor() {
    this.hasRequestedPermission = false;
    this.isCapacitorNative = Capacitor.isNativePlatform();
  }

  // Request browser & native notification permissions
  async requestPermission() {
    try {
      if (this.isCapacitorNative) {
        const result = await LocalNotifications.requestPermissions();
        return result.display === 'granted';
      }

      if ('Notification' in window) {
        const permission = await Notification.requestPermission();
        return permission === 'granted';
      }
    } catch (e) {
      console.warn('Notification permission request error:', e);
    }
    return false;
  }

  // Play pleasant notification sound via Web Audio API synth
  playChime() {
    try {
      const AudioContext = window.AudioContext || window.webkitAudioContext;
      if (!AudioContext) return;
      const ctx = new AudioContext();
      
      const osc1 = ctx.createOscillator();
      const osc2 = ctx.createOscillator();
      const gainNode = ctx.createGain();

      osc1.type = 'sine';
      osc1.frequency.setValueAtTime(587.33, ctx.currentTime); // D5
      osc1.frequency.exponentialRampToValueAtTime(880, ctx.currentTime + 0.15); // A5

      osc2.type = 'triangle';
      osc2.frequency.setValueAtTime(880, ctx.currentTime);
      osc2.frequency.exponentialRampToValueAtTime(1174.66, ctx.currentTime + 0.25); // D6

      gainNode.gain.setValueAtTime(0.12, ctx.currentTime);
      gainNode.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + 0.4);

      osc1.connect(gainNode);
      osc2.connect(gainNode);
      gainNode.connect(ctx.destination);

      osc1.start();
      osc2.start();
      osc1.stop(ctx.currentTime + 0.45);
      osc2.stop(ctx.currentTime + 0.45);
    } catch (e) {
      // Audio autoplay may be constrained until user interaction
    }
  }

  // Send a system / local notification
  async send({ title, body, id = Date.now() }) {
    this.playChime();

    // 1. If running as Native Android APK via Capacitor
    if (this.isCapacitorNative) {
      try {
        await LocalNotifications.schedule({
          notifications: [
            {
              title,
              body,
              id: Math.floor(Math.random() * 100000),
              schedule: { at: new Date(Date.now() + 500) },
              sound: 'beep.wav',
              actionTypeId: '',
              extra: null
            }
          ]
        });
        return;
      } catch (err) {
        console.warn('Native notification failed:', err);
      }
    }

    // 2. If running on Desktop Browser Web Notifications API
    if ('Notification' in window && Notification.permission === 'granted') {
      try {
        new Notification(title, {
          body,
          icon: '/tendon-mark.png',
          badge: '/favicon-64.png'
        });
      } catch (err) {
        console.warn('Browser notification error:', err);
      }
    }
  }
}

export const notificationService = new NotificationService();
