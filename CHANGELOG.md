# Changelog

## 2.1.12 — 2026-11-27

- Removed the yellow reference/remark banner from the topology UI.
- Added locked-by-default editing mode with explicit Unlock / Lock controls for users with the existing Edit realm.
- Added Undo (up to 40 grouped changes) and Ctrl/Cmd+Z.
- Added a 10-second continuous ICMP failure grace period before an ICMP-monitored device becomes Offline. First miss is Recovering; a successful response clears the timer.
- Added a 10-second UI refresh option and ICMP no-reply duration in the device details.
- Preserved production topology data during upgrades; public release contains only a blank topology example.
