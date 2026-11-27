# DimasDP Live Network Topology for Cacti

Cacti plugin for viewing and editing network topology with live device status from the Cacti host inventory.

## Latest release: v2.1.12

- Cacti compatibility declared by source: **1.2.24**
- Plugin directory: `dimasdptopology`
- Main page: `live_topology.php`
- Release archive: `dimasdptopology-v2.1.12.tar.gz`

### v2.1.12 changes

- Removed the yellow reference/remark warning banner from the topology editor.
- Added **Unlock to edit / Lock editing**. Users with the existing Cacti **Edit Live Network Topology** realm enter in locked/view mode; editing must be explicitly unlocked.
- Added **Undo** with up to 40 recent grouped changes and Ctrl/Cmd+Z. Undo restores the prior canvas state and auto-saves it.
- ICMP-monitored devices become **Recovering** on the first missed echo reply and **Offline** only after failed probes persist for at least 10 seconds.
- A successful ICMP reply immediately restores **Online** and clears the failure timer.
- Added a **Refresh 10s** option for faster visual status updates.
- Added a detail-panel display of the current ICMP no-reply duration and the 10-second offline threshold.

The 10-second ICMP grace period and the UI refresh interval are separate. Choose Refresh 10s to observe the Recovering transition promptly. With a longer refresh interval, the next screen update may arrive after the 10-second grace period has already elapsed.

## Previous source version note

The first uploaded archive was named `dimasdptopology-v2.1.6.tar.gz`, while its internal `dimasdptopology/INFO` declared **2.1.11**. That source was preserved as the historical v2.1.11 baseline. The latest source package in this repository is v2.1.12.

## Reconstruct the latest release archive

On Linux:

```bash
cd release
bash ./assemble-v2.1.12.sh
```

This creates `dimasdptopology-v2.1.12.tar.gz`, validates the gzip/tar structure, and checks SHA-256:

`799038066800120ec18ca4650f5126f8d2c8b0a1048dd32044a478e110c92781`

## Installation / upgrade

After reconstructing the archive:

```bash
sudo mkdir -p /opt/dimasdp
sudo tar -xzf release/dimasdptopology-v2.1.12.tar.gz -C /opt/dimasdp
cd /opt/dimasdp/dimasdptopology-v2.1.12
sudo bash ./install.sh /var/www/html/cacti
```

The installer creates a timestamped backup under `/var/backups/cacti/dimasdptopology/`, preserves numeric UID:GID ownership to avoid invalid group-name errors, and **preserves an existing production** `plugins/dimasdptopology/data/topology.json`. It creates an empty topology file from `topology.example.json` only when no non-empty production file exists.

After installation, verify the version in Cacti **Console → Configuration → Plugin Management** and check the editor:

1. A user with Edit permission should see **View mode · locked** and an **Unlock to edit** button.
2. Unlocking should enable layout edits, node/link changes, import, and canvas expansion.
3. Undo should revert the last grouped change. Ctrl/Cmd+Z is also supported.
4. For an ICMP node, the first missed echo reply should show **Recovering**; it should change to **Offline** only after 10 seconds of continued failed probes.
5. Choose **Refresh 10s** when observing the transition.

## ICMP regression test

Run:

```bash
php tests/icmp-state-test.php
```

The test covers first failure, a 9-second failure, the 10-second threshold, and stale-observation reset.

## Public repository data policy

This repository is **Public** and deliberately excludes production topology data. The published package contains `dimasdptopology/data/topology.example.json`, an empty starter workspace.

Do not commit production `topology.json`, device/site names, internal IP maps, Cacti host IDs, coordinates, SNMP communities, passwords, API tokens, or other operational network details. Keep production topology backups private.

The deployment-specific `assets/topology-reference-gray.jpg` is also excluded from the public archive.
