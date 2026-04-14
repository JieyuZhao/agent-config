# NVIDIA DGX Spark, Setup and Operations Notes

## Current state (as of 2026-04-13)

### Completed
- Order received: 2 units (this document currently covers unit A / `spark-37f2`)
- Unit A onboarded via network-device mode; hostname `spark-37f2` (default), admin user `yzhao062`
- SSH access confirmed from Windows laptop over home Wi-Fi, using mDNS name `spark-37f2.local`
- Second admin account created for collaborator: `xiyanghu` (in `sudo` and `docker` groups)
- Tailscale 1.96.4 installed; `tailscaled` systemd service running, status `Needs login` (not yet authenticated)
- Switched boot default to `multi-user.target` (headless) on 2026-04-13; Xorg and gnome-shell no longer running, GPU memory freed

### In progress
- Tailscale authentication: next command is `sudo tailscale up --ssh`
- Xiyang password/SSH key handoff: account exists, temp password not yet set, no SSH key installed

### Pending next steps (when resuming)
1. Run `sudo tailscale up --ssh` on Spark and complete browser auth on Windows
2. Record the static Tailscale IP with `tailscale ip -4`
3. Enable MagicDNS in Tailscale admin console
4. Install Tailscale on Windows laptop; verify off-LAN access by tethering to phone hotspot
5. Set temporary password for `xiyanghu` and force expiry:
   ```
   sudo passwd xiyanghu
   sudo passwd --expire xiyanghu
   ```
6. Collect Xiyang's SSH public key, install to his `~/.ssh/authorized_keys` (see section 9)
7. Send Xiyang the onboarding message (template in section 9)
8. Install Tailscale on Xiyang's machine, share Spark node from admin console
9. Move Spark to office (no network reconfiguration needed because of Tailscale)
10. Unit B: repeat the entire flow once it arrives

### Known issues / gotchas discovered so far
- **Termius paste bug**: bracketed-paste envelope (`^[[200~` ... `^[[201~`) leaks into commands as literal text on this Spark. Workaround: type commands by hand. Fix: `echo 'set enable-bracketed-paste on' >> ~/.inputrc` on Spark, or switch to Windows Terminal + native OpenSSH.
- **DHCP IP drift**: home Wi-Fi assigned Spark different IPs on different days (`192.168.1.141` → `192.168.1.161`). Use mDNS name or Tailscale address, never hardcode the IP.

---

## 1. Order context
- Product: NVIDIA DGX Spark Founders Edition, 4 TB
- Quantity: 2 units
- Current MSRP (April 2026): $4,699 each (raised from $3,999 in late February 2026 due to memory supply constraints)

## 2. Role in daily workflow
Daily driver stays on Windows (PyCharm, Claude Code, Codex, Chrome, Office). Spark is a headless ML appliance, not a desktop replacement. Primary interaction model: PyCharm remote interpreter and SSH from the Windows box.

## 3. Operating system
- Ships with NVIDIA DGX OS (Ubuntu 24.04 LTS for ARM64 / aarch64)
- Kernel observed on `spark-37f2`: `6.17.0-1014-nvidia aarch64`
- DGX OS version observed: 7.5.0
- Preinstalled: CUDA 13.0, cuDNN, NCCL, TensorRT, PyTorch containers, NIM, Docker runtime, NVIDIA driver 580.142
- Windows and macOS cannot be installed:
  - macOS has no ARM-for-non-Apple-hardware build and no NVIDIA GPU drivers
  - Windows on ARM has no Grace/Blackwell driver support
  - Spark is a single-OS appliance by design

## 4. OS restoration
- Built-in recovery partition reflashes to factory state from the UEFI menu
- Official DGX OS images are on the NVIDIA Enterprise portal for USB reinstall
- Warranty support covers firmware-level recovery
- Safe to experiment with kernels and drivers; reversible within an hour

## 5. First-boot setup
The quick start card prints two credentials:
- Host SSID: the temporary Wi-Fi network the Spark broadcasts on first power-on
- WPA2 password: password for that Wi-Fi access point

These are used once during onboarding, then never again. Flow:
1. Power on Spark (no display needed)
2. From a laptop or phone, join the `spark-XXXX` Wi-Fi using the printed password
3. Open the browser wizard at the printed URL
4. Set timezone, create an admin Linux user account, join the real network
5. The temporary AP shuts off after onboarding completes

Important: the Wi-Fi password on the card is NOT the SSH password. The SSH password is the one you create for your admin account during step 4.

## 6. Setup mode
Chosen mode for both units: network device (headless). Rationale: Spark's value is as a CUDA server reached over SSH, not as a second desktop. A monitor can still be plugged in later if needed.

## 7. Local network access (on-LAN only)
- Spark auto-advertises its hostname via mDNS as `spark-XXXX.local`
- Windows 11 recent builds resolve `.local` names natively; if resolution fails, install Apple Bonjour Print Services
- The mDNS name is stable across reboots; raw IP is not required and should not be hardcoded
- **Important limitation**: mDNS is link-local. `spark-37f2.local` only resolves when the client is on the same Wi-Fi / broadcast domain as the Spark. For off-LAN access, use Tailscale (section 10).
- Fallback if mDNS is flaky on LAN: add a DHCP reservation on the router to pin the IP

## 8. SSH authentication

### Which password to use
- Quick start card passwords: Wi-Fi AP only, used once
- Admin user password you created during first-boot setup: what you use for SSH from then on

### Initial SSH test
```
ssh user@spark-a.local
```
Enter your admin password when prompted.

### Switch to key-based auth (do this right away)
1. On Windows, generate a key if none exists:
   ```
   ssh-keygen -t ed25519
   ```
2. Copy public key to Spark:
   ```
   type %USERPROFILE%\.ssh\id_ed25519.pub | ssh user@spark-a.local "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
   ```
3. Test: `ssh spark-a` should now log in without prompting
4. Repeat for each unit

### SSH config on Windows
`%USERPROFILE%\.ssh\config`:
```
Host spark-a
    HostName spark-a.local
    User <your-user>
    IdentityFile ~/.ssh/id_ed25519

Host spark-b
    HostName spark-b.local
    User <your-user>
    IdentityFile ~/.ssh/id_ed25519
```

### Optional hardening (after keys work)
Disable password SSH:
```
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl reload ssh
```
From then on, only SSH keys can log in.

## 9. User management

### Create a new user (collaborator or admin)
```bash
sudo adduser <username>
sudo usermod -aG sudo,docker <username>
id <username>
```
- `adduser` prompts for password and optional fields
- `sudo` group grants admin rights; omit for student accounts
- `docker` group grants access to NVIDIA container runtime (CUDA containers)
- `id` verifies group membership

### Force password change on first login
```bash
sudo passwd --expire <username>
```
On next login the user is required to set a new password before they get a shell. Equivalent: `sudo chage -d 0 <username>`.

### Install a user's SSH public key
Ask them for `~/.ssh/id_ed25519.pub` on their machine, then:
```bash
sudo -u <username> mkdir -p /home/<username>/.ssh
sudo -u <username> tee /home/<username>/.ssh/authorized_keys > /dev/null <<'EOF'
ssh-ed25519 AAAA...paste-their-key... user@hostname
EOF
sudo -u <username> chmod 700 /home/<username>/.ssh
sudo -u <username> chmod 600 /home/<username>/.ssh/authorized_keys
```
Using `sudo -u <username>` makes files owned by them from the start, so no separate `chown` step.

### Reset a forgotten password
```bash
sudo passwd <username>
```
Prompts you for a new password twice. Pair with `sudo passwd --expire <username>` to force the user to change it again after you hand it over.

### Remove a user
```bash
sudo deluser --remove-home <username>
```
Also unshare any Tailscale node access in the admin console.

### Onboarding message template (for collaborator / admin)
```
Hi <name>,

You now have an admin account on our new NVIDIA DGX Spark.

Connection:
  Host:     spark-37f2.local   (when on our Wi-Fi)
            or spark-37f2      (via Tailscale from anywhere, once set up)
  Username: <username>
  Temp password: <FILL IN>

To log in:
  ssh <username>@spark-37f2.local

On your first login, the system will require you to change the
temporary password. Set a new one and you are in.

Quick orientation:
  - Home directory: /home/<username> (on a 4 TB NVMe)
  - You have sudo and docker group access
  - Full NVIDIA CUDA stack preinstalled
  - OS: DGX OS 7.5.0 (Ubuntu 24.04 LTS, ARM64)
  - Hardware: NVIDIA GB10 Grace Blackwell, 128 GB unified memory

Let me know once you are logged in.

<your name>
```
Deliver the temp password through an encrypted channel, not plain email.

## 10. Remote access via Tailscale (NVIDIA-official path)

This is the NVIDIA-documented remote-access approach at https://build.nvidia.com/spark/tailscale. It is treated as a supported component of DGX OS, not a third-party hack. Tailscale gives Spark a stable overlay IP in the `100.x.y.z` CGNAT range that follows the device between networks, so off-LAN access from anywhere works without port forwarding, DDNS, or a public IP.

### Why Tailscale over alternatives
- Free Personal plan is enough for you + a collaborator (3 users, 100 devices)
- Works through NAT; no router configuration needed
- Survives network changes: when you move Spark from home to office, the Tailscale address stays the same
- NVIDIA Sync (the Windows GUI) has first-party Tailscale integration

### Install on Spark
```bash
curl -fsSL https://tailscale.com/install.sh | sh
```
Installs the ARM64 package and registers `tailscaled` as a systemd service that auto-starts on boot.

If `dpkg` complains about being interrupted from a prior operation:
```bash
sudo dpkg --configure -a
sudo apt-get install -f
sudo apt-get update
sudo apt-get install -y tailscale tailscale-archive-keyring
```

### Authenticate
```bash
sudo tailscale up --ssh
```
Prints a one-time authentication URL. Copy it into Chrome on your Windows laptop (where you are already signed into https://login.tailscale.com), click **Connect**. The Spark joins your tailnet.

The `--ssh` flag enables Tailscale SSH: optional, lets you authenticate SSH sessions via tailnet identity and ACLs instead of managing OpenSSH keys. Disable later with a plain `sudo tailscale up` if undesired.

### Record the static address
```bash
tailscale ip -4
tailscale status
```
- First command prints Spark's stable `100.x.y.z` IP. Write it down; it never changes for this device.
- Second command shows the full tailnet view.

### Enable MagicDNS (one-time, in admin console)
Go to https://login.tailscale.com/admin/dns → toggle **MagicDNS** on. Every tailnet device is then reachable by short hostname, e.g., `spark-37f2`.

### Windows client setup
Download from https://tailscale.com/download/windows, install, sign in with the same account. Windows tray icon shows Spark when connected.

### Verify off-LAN access
Tether Windows laptop to phone hotspot so it leaves home Wi-Fi, then:
```
ssh yzhao062@spark-37f2
```
If this connects, remote access is proven working before Spark ever moves offices.

### Update Windows SSH config
```
Host spark
    HostName spark-37f2
    User yzhao062
    IdentityFile ~/.ssh/id_ed25519
```
From then on, `ssh spark` works from any terminal (Claude Code, Codex, PyCharm remote interpreter), regardless of network.

### Moving Spark between networks (home → office)
No reconfiguration needed. When Spark boots at the office, `tailscaled` auto-starts, reconnects to the coordination server, and keeps the same `100.x.y.z` / `spark-37f2` address. You can SSH in from anywhere while still on the drive to the office.

Office firewalls: Tailscale tries direct peer-to-peer (UDP 41641), then STUN NAT traversal, then falls back to TCP 443 DERP relays. The 443 fallback works through almost any enterprise firewall.

## 11. Multi-user scaling for students

The free Personal plan caps at 3 users. For a research group with more members, three clean paths.

### Option A: Tailscale Node Sharing (recommended start)
- Keep the free Personal tailnet
- For each student, share Spark as a node from the admin console (**Machines → spark-37f2 → Share...**)
- Student creates their own free Personal tailnet and accepts the share
- They see only the Spark; none of your other tailnet devices
- Free for everyone, scales to unlimited students
- Revoke by unsharing in the admin console when they leave the lab

### Option B: Tailscale paid + 50% education discount
- Starter plan: normally $6/user/month, $3/user/month with the education discount
- Request the discount by emailing Tailscale support with documentation of institutional affiliation
- Unlocks centralized ACLs, tagged device groups, audit logs, and Tailscale SSH with identity-based access control
- Worth switching when share management becomes tedious (roughly 4+ active students) or when you want audit trails

### Option C: Self-hosted Headscale
- Open-source reimplementation of Tailscale's coordination server
- Free, unlimited users, full client compatibility
- Operational cost: TLS certs, backups, upgrades on a server you run
- Probably not worth it unless you specifically want no third-party SaaS

### Linux-level user management (always required)
Tailscale is only the network layer. You still need one Linux account per student (section 9). The lifecycle:
1. Create Linux account with `adduser`
2. Add to `docker` group (skip `sudo` unless they are an admin)
3. Install their SSH public key
4. Share the Spark node with them via Tailscale (or add them to the tailnet with ACL rules)
5. When they leave: `sudo deluser --remove-home <user>` on Spark and unshare in the Tailscale admin console

### Practical scaling concerns beyond networking
- **GPU contention**: Spark has a single GB10 GPU. Concurrent training jobs contend for it. Start with informal coordination (Slack, shared calendar). If that breaks down, add NVIDIA MPS for cooperative sharing, or a small queue tool.
- **Disk quotas**: one student filling `/home` wrecks the box for everyone. Install `quota`:
  ```bash
  sudo apt install quota
  # Edit /etc/fstab to add usrquota,grpquota to the root mount options
  sudo quotacheck -cum /
  sudo quotaon /
  sudo edquota -u <username>   # set soft / hard limits
  ```
  Or create a shared `/data` directory with rotation policies.
- **Shared monitoring**: install `nvitop` system-wide so students can self-check GPU state before launching a job. A "look before you launch" norm prevents most conflicts.

## 12. Power consumption and running costs

### Specs
| State | Power |
|---|---|
| Peak total system | 240 W |
| GB10 SoC TDP (CPU + GPU) | 140 W |
| Rest of system (ConnectX-7, SSD, USB-C) | 100 W |
| Under full CPU + GPU load | ~200 W |
| CPU-only load | 120–130 W |
| Idle (headless, post-update) | ~22 W |
| Idle (display attached) | ~25 W |
| Idle (pre-2026 firmware) | ~37 W |

Keep firmware current; the 2026 update fixed a ConnectX-7 hot-plug bug that held idle draw at 37 W.

### LADWP cost (Los Angeles residential, ~$0.30/kWh effective rate)

Per Spark, 24/7:
| Usage pattern | Avg draw | Per month | Per year |
|---|---|---|---|
| Headless idle only | 22 W | $4.75 | $58 |
| Light use (1 h training/day) | 30 W | $6.50 | $79 |
| Moderate (4 h training/day) | 52 W | $11.25 | $137 |
| Heavy (8 h training/day) | 81 W | $17.60 | $214 |
| Pegged 24/7 (unlikely) | 200 W | $43.20 | $526 |

Two units together, moderate usage: ~$22/month, ~$275/year.

### Reducing idle power
- Switch to `multi-user.target` to stop Xorg and gnome-shell (saves ~3 W and ~200 MiB memory, frees ~140 MiB GPU memory). See section 13 for full details, trade-offs, and verification steps.
- Keep display disconnected (saves additional ~3 W)
- Leave Tailscale running (negligible power, big usability gain)

### Monitoring commands
- `nvidia-smi` — GPU power, temp, utilization (one-shot)
- `nvidia-smi -l 1` — live updating every second
- `nvidia-smi dmon -s pucvmet -d 1` — streaming dashboard view
- `nvidia-smi --query-gpu=timestamp,power.draw,temperature.gpu,utilization.gpu,memory.used --format=csv -l 1` — CSV for scripting
- `pip install nvitop && nvitop` — interactive TUI (best day-to-day tool)
- `cat /sys/class/hwmon/hwmon*/power*_input` — raw sensor rails (microwatts)

### Quirks of `nvidia-smi` on GB10
- **Memory-Usage "Not Supported"**: expected. Spark uses unified LPDDR5X shared between Grace CPU and Blackwell GPU, so `nvidia-smi` cannot show a GPU-specific slice. Use `free -h` or framework APIs (`torch.cuda.memory_allocated()`) instead.
- **Power cap "N/A"**: expected. The SoC shares a power budget between CPU and GPU at the firmware level; there is no discrete per-GPU cap like on an H100.

## 13. Boot mode: headless vs graphical

DGX OS boots to `graphical.target` by default, which means `gdm3`, `Xorg`, and `gnome-shell` all start even when no monitor is attached. For a headless appliance this wastes memory, GPU memory, and idle power. Switching the systemd default to `multi-user.target` stops all of that.

### Comparison

| | `graphical.target` (default) | `multi-user.target` (headless) |
|---|---|---|
| What runs | SSH, networking, Docker, Tailscale, plus `gdm3`, `Xorg`, `gnome-shell`, GNOME desktop stack | SSH, networking, Docker, Tailscale, systemd services |
| Attached monitor shows | GNOME login screen → desktop | Text login prompt on tty1 |
| Memory held by GUI | 140–500 MiB | 0 |
| GPU memory held at idle | ~140 MiB (Xorg + gnome-shell compositing) | 0 |
| Idle power | ~25 W | ~22 W |
| Boot time | ~40–60 s | ~15–25 s |
| SSH remote access | Works identically | Works identically |

### Benefits of headless for an ML appliance
- More unified memory for models: the GUI holds 200–500 MiB that PyTorch could otherwise use. Every MiB matters on a unified-memory system.
- More GPU memory: the compositor releases ~140 MiB that was held just to draw an empty desktop.
- ~3 W lower idle draw (~$8/year per Spark at LADWP rates). Small in isolation, free to claim.
- ~2x faster reboot (skips gdm3, Xorg startup, and GNOME session init).
- Fewer background daemons, fewer surprise updates, fewer processes holding file locks.
- Unambiguously "an appliance" not "a desktop" — reduces the temptation to RDP in and poke around.

### What you give up
- **Local GNOME desktop on an attached monitor.** A plugged-in display now shows a text login prompt on tty1 instead of the graphical login screen. For an SSH-only workflow this is a non-issue.
- **GUI-only NVIDIA tools**: Nsight Systems GUI, `nvidia-settings` GUI, etc. All have CLI equivalents (`nsys` on the command line, most settings via `nvidia-smi`). You run the GUI versions on your Windows laptop connecting to Spark remotely.
- **Default GNOME remote desktop** stops working. You can temporarily bring the desktop back with `sudo systemctl isolate graphical.target`, or install Sunshine + Moonlight for on-demand streaming of a headless-friendly session.
- **Nothing else.** No package changes, no data loss. CUDA, Docker, Python, tmux, vim all work identically.

### Switch to headless (permanent)
```bash
sudo systemctl set-default multi-user.target
sudo reboot
```
After reboot, SSH back in as normal. The box is now headless from this point forward, including after power cycles.

### Switch to headless (immediate, no reboot)
```bash
sudo systemctl isolate multi-user.target
```
Switches the running system to multi-user mode on the spot. Kills Xorg and gnome-shell without touching SSH or Docker. Not persistent — the next reboot follows whatever the default target is. Combine with the permanent switch above if you want "right now" and "every boot after".

### Revert to graphical
```bash
sudo systemctl set-default graphical.target
sudo reboot
```
Fully reversible. No data loss, no package changes.

### Verify headless took effect
```bash
systemctl get-default          # should print: multi-user.target
pgrep -a Xorg                  # should print nothing
pgrep -a gnome-shell           # should print nothing
nvidia-smi                     # Processes section should no longer list Xorg or gnome-shell
free -h                        # should show ~200–500 MiB more available than before
```

### Temporarily bring the GUI back for a one-off task
```bash
sudo systemctl isolate graphical.target
```
Starts `gdm3`, `Xorg`, and GNOME on the spot. Reverts to text-mode at next reboot (because the default is still `multi-user.target`). Useful when you need a GUI session without changing the permanent default.

## 14. Clustering the two units
- NVIDIA ships a "Connect Two Sparks" flow for stacking
- Uses ConnectX interfaces on the back for a direct high-speed link between the two machines
- Separate from the office LAN; needed only for multi-node jobs
- Guide: https://build.nvidia.com/spark/connect-two-sparks/stacked-sparks

## 15. Other tools (optional)
- **NVIDIA Sync**: Windows GUI device manager with first-party Tailscale integration. Nice if you want a clickable device list instead of `ssh`.
- **Sunshine + Moonlight**: low-latency virtual desktop streaming if you ever need a GUI session on Spark (e.g., for Nsight Systems, or viewing TensorBoard in a browser without port forwarding).

## 16. Fit assessment
Strong fit:
- Local prototyping and inference box: 128 GB unified memory holds quantized models up to ~200B params locally
- CUDA-native stack ports directly to cluster or cloud
- Quiet desktop form factor suitable for an office

Not a fit:
- Not a training cluster replacement: memory bandwidth and FP16 throughput are well below H100 / H200
- Not a Windows or macOS daily driver (cannot run those OSes at all)
- Two units justified only if workflow becomes "prototype on Spark, scale on cluster"; risk is under-use if most compute stays on university clusters or cloud

## 17. Primary references
- DGX Spark User Guide (PDF): https://docs.nvidia.com/dgx/dgx-spark/dgx-spark.pdf
- Initial Setup, First Boot: https://docs.nvidia.com/dgx/dgx-spark/first-boot.html
- Set Up Local Network Access: https://build.nvidia.com/spark/connect-to-your-spark
- Set Up Tailscale on Your Spark (official): https://build.nvidia.com/spark/tailscale
- Connect Two Sparks: https://build.nvidia.com/spark/connect-two-sparks/stacked-sparks
- Spark Stacking: https://docs.nvidia.com/dgx/dgx-spark/spark-clustering.html
- Hardware Overview: https://docs.nvidia.com/dgx/dgx-spark/hardware.html
- NVIDIA Sync: https://docs.nvidia.com/dgx/dgx-spark/nvidia-sync.html
- Remote Access Playbook (DeepWiki): https://deepwiki.com/NVIDIA/dgx-spark-playbooks/2.3-setting-up-remote-access-with-tailscale
- Price change announcement (Feb 2026): https://forums.developer.nvidia.com/t/2-23-2026-price-change-announcement/361713
- LADWP Residential Electric Rates: https://www.ladwp.com/account/understanding-your-rates/residential-electric-rates
- Tailscale Node Sharing: https://tailscale.com/docs/features/sharing
- Tailscale Free Plans and Discounts: https://tailscale.com/kb/1154/free-plans-discounts
