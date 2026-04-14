# NVIDIA DGX Spark, Setup and Operations Notes

## 1. Order context
- Product: NVIDIA DGX Spark Founders Edition, 4 TB
- Quantity: 2 units
- Current MSRP (April 2026): $4,699 each (raised from $3,999 in late February 2026 due to memory supply constraints)

## 2. Role in daily workflow
Daily driver stays on Windows (PyCharm, Claude Code, Codex, Chrome, Office). Spark is a headless ML appliance, not a desktop replacement. Primary interaction model: PyCharm remote interpreter and SSH from the Windows box.

## 3. Operating system
- Ships with NVIDIA DGX OS (Ubuntu 24.04 LTS for ARM64 / aarch64)
- Preinstalled: CUDA toolkit, cuDNN, NCCL, TensorRT, PyTorch containers, NIM, Docker runtime
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

## 6. Setup mode (pick one during onboarding)
- Standalone: monitor, keyboard, mouse attached; used as a local Linux desktop
- Network device (headless): no display; managed over SSH from the Windows box

Chosen mode: network device (headless). Rationale: Spark's value is as a CUDA server reached over SSH, not as a second desktop. Switching to standalone later is still possible by attaching a display.

## 7. Network access
- Spark auto-advertises its hostname via mDNS as `spark-XXXX.local` (the `XXXX` suffix is printed on the quick start card)
- Windows 11 recent builds resolve `.local` names natively; if resolution fails, install Apple Bonjour Print Services
- The mDNS name is stable across reboots; raw IP is not required and should not be hardcoded
- Fallback if mDNS is flaky: add a DHCP reservation on the router to pin the IP, then SSH by IP
- True static IP via Netplan is also possible (Spark runs Ubuntu 24.04 underneath) but not recommended as a first resort

## 8. SSH authentication

### Which password to use
- Quick start card passwords: Wi-Fi AP only, used once
- Admin user password you created during step 4 of onboarding: what you use for SSH from then on

### Initial SSH test
```
ssh user@spark-a.local
```
Enter your admin password when prompted.

### Switch to key-based auth (recommended, do this right away)
1. On Windows, generate a key if none exists:
   ```
   ssh-keygen -t ed25519
   ```
   Creates `%USERPROFILE%\.ssh\id_ed25519` and `id_ed25519.pub`.
2. Copy the public key to Spark:
   ```
   type %USERPROFILE%\.ssh\id_ed25519.pub | ssh user@spark-a.local "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
   ```
   Enter the admin password once during this step.
3. Test: `ssh spark-a` should now log in with no password prompt
4. Repeat for `spark-b`

### Optional hardening after key auth works
On Spark, edit `/etc/ssh/sshd_config`:
```
PasswordAuthentication no
```
Then:
```
sudo systemctl reload ssh
```
From then on, only your key can log in; password attacks against the admin account are no longer possible.

### SSH config on Windows
Add to `%USERPROFILE%\.ssh\config`:
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
From then on, `ssh spark-a` and `ssh spark-b` work from any terminal (Claude Code, Codex, PyCharm remote interpreter).

### Keep your admin password somewhere safe
Even with key auth in place, you still need the admin password occasionally for `sudo` commands on Spark itself. Store it in a password manager.

## 9. Clustering the two units
- NVIDIA ships a "Connect Two Sparks" flow for stacking
- Uses ConnectX interfaces on the back for a direct high-speed link between the two machines
- Separate from the office LAN; needed only for multi-node jobs

## 10. Optional tools
- NVIDIA Sync: GUI device manager for discovering and connecting to Sparks from Windows
- Sunshine + Moonlight: low-latency virtual desktop streaming if a GUI session is ever needed on Spark (useful for Nsight Systems, TensorBoard, etc.)

## 11. Fit assessment

Strong fit:
- Local prototyping and inference box: 128 GB unified memory holds quantized models up to ~200B params locally
- CUDA-native stack ports directly to cluster or cloud
- Quiet desktop form factor suitable for an office

Not a fit:
- Not a training cluster replacement: memory bandwidth and FP16 throughput are well below H100/H200
- Not a Windows or macOS daily driver (cannot run those OSes at all)
- Two units justified only if workflow becomes "prototype on Spark, scale on cluster"; risk is under-use if most compute stays on university clusters or cloud

## 12. Recommended setup checklist (when units arrive)
1. Unbox both units; keep the quick start cards (they hold Wi-Fi credentials and recovery references)
2. Power on unit A; complete network-device onboarding via laptop/phone; set hostname `spark-a` and an admin user
3. Repeat for unit B with hostname `spark-b`
4. From Windows, confirm `ssh user@spark-a.local` and `ssh user@spark-b.local` both work
5. If mDNS resolution fails, install Bonjour Print Services on Windows
6. Generate an ed25519 key on Windows if none exists
7. Copy the public key to both units, confirm key-based login
8. Add `Host spark-a` and `Host spark-b` blocks to `%USERPROFILE%\.ssh\config`
9. Harden both units: set `PasswordAuthentication no` in sshd_config and reload ssh
10. Store both admin passwords in a password manager
11. Point PyCharm remote interpreter at `spark-a` (and `spark-b` as a second config) for initial smoke test
12. Only if needed later: set DHCP reservations on the router for both units
13. Only if needed later: follow the Connect Two Sparks guide to link them via ConnectX for multi-node work

## 13. Primary references
- DGX Spark User Guide (PDF): https://docs.nvidia.com/dgx/dgx-spark/dgx-spark.pdf
- Initial Setup, First Boot: https://docs.nvidia.com/dgx/dgx-spark/first-boot.html
- Set Up Local Network Access: https://build.nvidia.com/spark/connect-to-your-spark
- Connect Two Sparks: https://build.nvidia.com/spark/connect-two-sparks/stacked-sparks
- Spark Stacking: https://docs.nvidia.com/dgx/dgx-spark/spark-clustering.html
- Price change announcement (Feb 2026): https://forums.developer.nvidia.com/t/2-23-2026-price-change-announcement/361713
