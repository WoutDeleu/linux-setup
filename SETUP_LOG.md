# PC Setup Log

This document logs manual setup steps performed on the system. The goal is to document each step in detail so it can later be automated via Ansible.

---

## Post-Installation Configuration

After running the Ansible playbook, the following manual configurations are required.

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

---

## Next Steps

<!-- Add more setup steps below as you configure your system -->
