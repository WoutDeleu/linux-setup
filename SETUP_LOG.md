# PC Setup Log

This document logs manual setup steps performed on the system. The goal is to document each step in detail so it can later be automated via Ansible.

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

## Next Steps

<!-- Add more setup steps below as you configure your system -->
