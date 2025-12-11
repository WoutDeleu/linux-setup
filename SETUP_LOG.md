# PC Setup Log

This document logs manual setup steps performed on the system. The goal is to document each step in detail so it can later be automated via Ansible.

---

## Bluetooth Setup

### Connecting a Bluetooth Keyboard

#### Prerequisites
- Bluetooth adapter (built-in or USB dongle)
- `bluez` and `bluez-utils` packages installed

#### Manual Steps

1. **Start the Bluetooth service**
   ```bash
   sudo systemctl start bluetooth
   sudo systemctl enable bluetooth  # Enable on boot
   ```

2. **Enter the Bluetooth control utility**
   ```bash
   bluetoothctl
   ```

3. **Power on the Bluetooth adapter**
   ```
   [bluetooth]# power on
   ```

4. **Enable the agent for pairing**
   ```
   [bluetooth]# agent on
   [bluetooth]# default-agent
   ```

5. **Start scanning for devices**
   ```
   [bluetooth]# scan on
   ```
   - Put your keyboard in pairing mode (usually hold the Bluetooth/pairing button until LED blinks)
   - Wait for your keyboard to appear in the scan results
   - Note the MAC address (format: `XX:XX:XX:XX:XX:XX`)

6. **Pair with the keyboard**
   ```
   [bluetooth]# pair XX:XX:XX:XX:XX:XX
   ```
   - If prompted for a PIN, type it on the Bluetooth keyboard and press Enter

7. **Trust the device** (allows auto-reconnect)
   ```
   [bluetooth]# trust XX:XX:XX:XX:XX:XX
   ```

8. **Connect to the device**
   ```
   [bluetooth]# connect XX:XX:XX:XX:XX:XX
   ```

9. **Verify connection**
   ```
   [bluetooth]# info XX:XX:XX:XX:XX:XX
   ```
   - Should show `Connected: yes`

10. **Exit bluetoothctl**
    ```
    [bluetooth]# exit
    ```

#### Troubleshooting

- **Keyboard not appearing in scan**: Ensure keyboard is in pairing mode (LED blinking)
- **Pairing fails**: Try `remove XX:XX:XX:XX:XX:XX` then pair again
- **Connection drops**: Check `trust` was set; try `bluetoothctl connect XX:XX:XX:XX:XX:XX`
- **Bluetooth service not running**: `sudo systemctl status bluetooth`

#### Automation Notes

To automate this later:
- Install packages: `bluez`, `bluez-utils`
- Enable service: `bluetooth.service`
- For auto-pairing, consider storing trusted device MACs and using `bluetoothctl` in non-interactive mode
- Example non-interactive commands:
  ```bash
  echo -e "power on\nagent on\ndefault-agent\nscan on" | bluetoothctl
  echo -e "pair XX:XX:XX:XX:XX:XX\ntrust XX:XX:XX:XX:XX:XX\nconnect XX:XX:XX:XX:XX:XX" | bluetoothctl
  ```

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

### Configure Fn Hotkeys

Some keyboards require configuration to make Fn keys work correctly (media keys, brightness, etc.).

#### Check current Fn mode
```bash
cat /sys/module/hid_apple/parameters/fnmode
```

Values:
- `0` = Fn key disabled
- `1` = Press Fn + F1-F12 for media keys (F1-F12 are function keys by default)
- `2` = Press Fn + F1-F12 for function keys (media keys by default)

#### Temporarily change Fn mode
```bash
echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
```

#### Make it persistent
Create a modprobe config file:

```bash
sudo nano /etc/modprobe.d/hid_apple.conf
```

Add:
```
options hid_apple fnmode=2
```

Rebuild initramfs (Fedora):
```bash
sudo dracut --force
```

#### Automation Notes
- Deploy `/etc/modprobe.d/hid_apple.conf` via Ansible
- Run `dracut --force` as a handler after file change

---

## Next Steps

<!-- Add more setup steps below as you configure your system -->
