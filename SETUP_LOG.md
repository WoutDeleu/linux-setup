# PC Setup Log

This document is split into two parts:
1. **Setup Log** - Record of manual steps performed during setup (for future automation)
2. **Post-Installation Guide** - Steps to complete after running the Ansible playbook

---

# Part 1: Setup Log

Record of manual configuration steps performed. These should be automated in future iterations.

## Installed Software

| Software | Installation Method | Status |
|----------|---------------------|--------|
| Bluetooth (bluez, blueman) | Ansible | Automated |
| arandr | Ansible | Automated |
| Brave Browser | Ansible (curl script) | Automated |
| gphotos-sync | Ansible (pipx) | Automated |

## Manual Steps Performed

- [ ] Connected Bluetooth keyboard via Blueman
- [ ] Configured external monitors via arandr
- [ ] Set up Brave sync chain
- [ ] Configured gphotos-sync with Google API

---

# Part 2: Post-Installation Guide

Complete these steps after running `./bootstrap.sh` or the Ansible playbook.

## 1. Connect Bluetooth Devices

1. Launch Blueman: `blueman-manager`
2. Click "Search" to scan for devices
3. Put device in pairing mode
4. Right-click device → "Pair" → "Trust" → "Connect"

### Enable FastConnectable (optional)

Edit `/etc/bluetooth/main.conf`:
```ini
[General]
FastConnectable = true
```

Restart: `sudo systemctl restart bluetooth`

---

## 2. Configure External Monitors

1. Launch: `arandr`
2. Drag monitors to set position
3. Set resolution for each display
4. Apply and save layout to `~/.screenlayout/`
5. Add to i3 config for persistence:
   ```
   exec --no-startup-id ~/.screenlayout/monitor-layout.sh
   ```

---

## 3. Setup Brave Browser Sync

1. Open Brave
2. Go to Settings → Sync
3. Enter sync chain code from existing device

---

## 4. Configure gphotos-sync

1. Create Google API credentials at [Google Cloud Console](https://console.cloud.google.com/)
2. Enable "Photos Library API"
3. Create OAuth 2.0 credentials (Desktop application)
4. Save credentials:
   ```bash
   mkdir -p ~/.config/gphotos-sync
   mv ~/Downloads/client_secret_*.json ~/.config/gphotos-sync/client_secret.json
   ```
5. Run first sync: `gphotos-sync ~/Pictures/GooglePhotos`

---

## 5. Configure Fn Hotkeys

<!-- TODO: Document Fn hotkey configuration -->

---

## 6. Remap Caps Lock to Escape

```bash
sudo localectl set-x11-keymap us "" "" caps:escape
```
