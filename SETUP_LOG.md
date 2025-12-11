# PC Setup Log

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

### Configure External Monitors

Use `arandr` (installed via Ansible) to configure display layout:

1. **Launch arandr**
   ```bash
   arandr
   ```

2. **Configure displays**
   - Drag monitors to set their position (left/right/above/below)
   - Click on a monitor to set resolution and orientation
   - Uncheck "Same as" to disable mirroring

3. **Apply configuration**
   - Click "Apply" to test the layout
   - Click "Layout" → "Save As" to save the configuration as a script

4. **Make configuration persistent**
   - Save the layout script to `~/.screenlayout/`
   - Add the script to your i3 config or `.xinitrc` to run on startup:
     ```bash
     ~/.screenlayout/monitor-layout.sh
     ```

#### Automation Notes
- Save `.screenlayout/*.sh` scripts to dotfiles
- Add startup command to i3 config via stow

### Configure Fn Hotkeys

<!-- TODO: Document Fn hotkey configuration -->

---

## Next Steps

<!-- Add more setup steps below as you configure your system -->

