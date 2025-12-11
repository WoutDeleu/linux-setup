# PC Setup Log

This document logs manual setup steps performed on the system. The goal is to document each step in detail so it can later be automated via Ansible.

---

## Post-Installation Configuration

After running the Ansible playbook, the following manual configurations are required.

### Configure gphotos-sync

gphotos-sync is installed via pipx. You need to authenticate with Google to use it.

1. **Create Google API credentials**
   - Go to [Google Cloud Console](https://console.cloud.google.com/)
   - Create a new project (or use existing)
   - Enable the "Photos Library API"
   - Go to "Credentials" → "Create Credentials" → "OAuth 2.0 Client ID"
   - Choose "Desktop application"
   - Download the JSON file

2. **Setup credentials**
   ```bash
   mkdir -p ~/.config/gphotos-sync
   mv ~/Downloads/client_secret_*.json ~/.config/gphotos-sync/client_secret.json
   ```

3. **Run first sync to authenticate**
   ```bash
   gphotos-sync ~/Pictures/GooglePhotos
   ```
   - A browser window will open for Google authentication
   - Grant access to your Google Photos

4. **Setup automatic sync (optional)**
   Create a cron job or systemd timer:
   ```bash
   crontab -e
   ```
   Add:
   ```
   0 2 * * * /home/$(whoami)/.local/bin/gphotos-sync ~/Pictures/GooglePhotos
   ```

#### Automation Notes
- `client_secret.json` can be stored in Ansible Vault and deployed
- OAuth token stored in `~/.config/gphotos-sync/` after first auth
- Cron job can be added via Ansible `cron` module

---

## Next Steps

<!-- Add more setup steps below as you configure your system -->
