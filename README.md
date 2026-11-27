# Cacti Live Topology

DimasDP Live Network Topology plugin for the Cacti Network Monitoring System.

- **Repository:** `masdims/cacti-live-topology`
- **Deployed version to preserve:** 2.1.6
- **Target Cacti instance:** Cacti 1.2.24
- **Visibility:** Public

## Purpose

This plugin provides a live network-topology view integrated with Cacti's managed host inventory. The deployed dashboard also uses its node inventory to summarize monitored and unmapped devices.

## Source integrity

The repository has been initialized for the deployed plugin. The exact active `dimasdptopology` source archive from the Cacti server is required before adding the v2.1.6 source and release package.

An older MVP 1.0 archive exists in the separate `masdims/cacti-backup` repository. It is not used as a substitute for the deployed v2.1.6 source.

## Planned repository contents

- `dimasdptopology/` — installable Cacti plugin source
- `install.sh` — installation and backup helper
- `README.md` — requirements, installation, configuration, and rollback notes
- `release/` — versioned release archives and checksums
