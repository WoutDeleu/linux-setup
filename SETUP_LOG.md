# PC Setup Log

This document logs manual setup steps performed on the system. The goal is to document each step in detail so it can later be automated via Ansible.

---

## Bluetooth Setup

### Connecting a Bluetooth Device using Blueman

#### Prerequisites
- Bluetooth adapter (built-in or USB dongle)
- `bluez`, `bluez-tools`, and `blueman` packages installed (via Ansible playbook)

#### Manual Steps

1. **Start the Bluetooth service** (if not already running)
   ```bash
   sudo systemctl start bluetooth
   sudo systemctl enable bluetooth
   ```

2. **Launch Blueman**
   ```bash
   blueman-manager
   ```
   Or find "Bluetooth Manager" in your application menu.

3. **Enable Bluetooth adapter**
   - In Blueman, click the Bluetooth icon in the toolbar to enable the adapter (if disabled)

4. **Search for devices**
   - Click the "Search" button in the toolbar
   - Put your device in pairing mode (hold Bluetooth/pairing button until LED blinks)
   - Wait for your device to appear in the list

5. **Pair the device**
   - Right-click on the device in the list
   - Select "Pair"
   - If prompted for a PIN, enter it on the Bluetooth keyboard and press Enter

6. **Trust the device** (auto-reconnect on boot)
   - Right-click on the device
   - Select "Trust"

7. **Connect**
   - Right-click on the device
   - Select "Connect"

8. **Verify connection**
   - The device should show a connected icon
   - Test the device (type on keyboard, move mouse, etc.)

#### Troubleshooting

- **Device not appearing**: Ensure device is in pairing mode and adapter is enabled
- **Pairing fails**: Remove device and try again
- **Connection drops**: Ensure device is trusted; check `systemctl status bluetooth`
- **Blueman not starting**: Check if `bluez` service is running

---

## Post-Installation Configuration

After running the Ansible playbook, the following manual configurations are required.

### Enable FastConnectable for Bluetooth

FastConnectable reduces the time it takes for devices to reconnect. Edit `/etc/bluetooth/main.conf`:

```bash
sudo nano /etc/bluetooth/main.conf
```

Find and uncomment/modify the `[General]` section:

```ini
[General]
FastConnectable = true
```

Then restart the Bluetooth service:

```bash
sudo systemctl restart bluetooth
```

#### Automation Notes
- Deploy `main.conf` via Ansible template
- Use `lineinfile` or copy a pre-configured file to `/etc/bluetooth/main.conf`

---

## Brave Browser Installation

### Installation

Install Brave browser using the official install script:

```bash
curl -fsS https://dl.brave.com/install.sh | sh
```

This script:
- Adds the Brave repository to your system
- Imports the GPG key
- Installs Brave browser via your package manager

### Post-Installation: Copy Chain Code

After installation, copy the chain code for sync functionality:

1. Open Brave browser
2. Go to Settings → Sync
3. Copy the sync chain code from your existing device
4. Enter the chain code to sync bookmarks, passwords, and settings

#### Automation Notes
- The curl install script can be run via Ansible `shell` module
- Chain code sync requires manual intervention (cannot be automated)
- Consider backing up Brave profile data instead for full automation

---

### Configure Fn Hotkeys

<!-- TODO: Document Fn hotkey configuration -->

---

## Next Steps

<!-- Add more setup steps below as you configure your system -->
