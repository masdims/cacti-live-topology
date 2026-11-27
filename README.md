# DimasDP Live Network Topology for Cacti

A Cacti plugin for viewing and editing network topology with live device status read from the Cacti host inventory.

## Release metadata

The uploaded source archive had the filename `dimasdptopology-v2.1.6.tar.gz`, while its internal `dimasdptopology/INFO` declares **version 2.1.11**. The repository preserves the metadata contained in the uploaded source and does not silently relabel it.

- Internal plugin version: **2.1.11**
- Cacti compatibility declared by source: **1.2.24**
- Plugin directory: `dimasdptopology`
- Main page: `live_topology.php`

Confirm the version shown by your production Cacti Plugin Management before creating release tags.

## Privacy / production data

This is a **public repository**. The production `data/topology.json` was excluded from the public package because it contains operational network information: 133 device/node records, 141 links, internal IP addresses, device/site names, Cacti host IDs and coordinates.

The published package includes an empty `data/topology.example.json` instead. Keep the real production `data/topology.json` backed up privately and do not commit it here.

The reference image `assets/topology-reference-gray.jpg` was also omitted from the public package because it is deployment-specific and is not referenced by the included PHP/JS source.

## Reconstruct the verified source archive

The complete sanitized source package is stored in `release/` as Base64 parts. On Linux:

```bash
cd release
bash ./assemble.sh
```

The script creates `dimasdptopology-public-v2.1.11.tar.gz`, checks the gzip/tar structure, and validates SHA-256:

`12e60c8b8a7ba433ffec5f11f23f78c58c590c8add6e179604509b95efb12e6b`

## Installation

On the Cacti server:

```bash
sudo mkdir -p /opt/dimasdp
sudo tar -xzf release/dimasdptopology-public-v2.1.11.tar.gz -C /opt/dimasdp
cd /opt/dimasdp
sudo bash ./install.sh /var/www/html/cacti
```

The installer backs up the current plugin and overlays the public source. It **preserves an existing** `plugins/dimasdptopology/data/topology.json`; if none exists, it creates an empty one from `topology.example.json`.

After installation, check Cacti **Console → Configuration → Plugin Management** and enable the plugin if it is not already active. Grant the intended users the View/Edit Live Network Topology realms.

## Source layout inside the archive

- `dimasdptopology/setup.php` — plugin metadata, hooks, realms and lifecycle
- `dimasdptopology/live_topology.php` — topology interface and editor
- `dimasdptopology/ajax.php` — live status and layout API
- `dimasdptopology/edit_topology.php` — editor access entry point
- `dimasdptopology/assets/` — navigation helper and tab icon
- `dimasdptopology/data/topology.example.json` — blank starter workspace

## Security

- Never commit a production topology JSON or backup to this public repository.
- Do not store SNMP communities, credentials, API tokens or server-specific secrets in the repository.
- Restrict access to production topology backups.
