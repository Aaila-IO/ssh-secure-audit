#!/bin/bash
# SH Secure Audit v0.1
# Author: Aaila
# Description: Basic SSH configuration and security audit tool for CentOS

# Create a logs directory if not exists
log_dir="./reports"
mkdir -p "$log_dir"

# Create a timestamped log file
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
log_file="$log_dir/audit_$timestamp.log"

# Redirect all output (stdout + stderr) to both console and log file
exec > >(tee -a "$log_file") 2>&1


echo "-------------------------------------------"
echo "SSH Secure Audit v0.1"
echo "-------------------------------------------"

# 1. Check OpenSSH version version=$(ssh -V 2>&1)
echo "[*] OpenSSH Version Detected: $version"

# 1.1 Check for CVE-2024-6387 vulnerability (RegreSSHion)
# Vulnerable range: OpenSSH 8.5p1 → 9.8p1 on glibc systems
echo "[*] Checking for known vulnerabilities (CVE-2024-6387)..."

# Extract numeric part (like 7.4, 8.9, 9.8)
version_num=$(echo "$version" | grep -oE '[0-9]+\.[0-9]+' | head -n1)

# Convert to float safely (ignore non-numeric)
if [[ -n "$version_num" ]]; then
    compare=$(echo "$version_num >= 8.5 && $version_num <= 9.8" | bc -l)
    if [[ "$compare" -eq 1 ]]; then
        echo "[!] Detected OpenSSH version $version_num - potentially vulnerable to CVE-2024-6387"
        echo "    → Patch or upgrade to OpenSSH 9.8p2 or later recommended."
    else
        echo "[+] No known CVE-2024-6387 vulnerability detected for this version."
    fi
else
    echo "[!] Unable to parse OpenSSH version for vulnerability check."
fi



# 2. Check if root login is allowed
permit_root=$(grep -i "^PermitRootLogin" /etc/ssh/sshd_config | awk '{print $2}')
if [[ "$permit_root" == "yes" ]]; then
    echo "[!] Root login is ENABLED - High Risk"
else
    echo "[+] Root login is DISABLED - Good"
fi

# 3. Check if password authentication is allowed
password_auth=$(grep -i "^PasswordAuthentication" /etc/ssh/sshd_config | awk '{print $2}')
if [[ "$password_auth" == "yes" ]]; then
    echo "[!] Password Authentication ENABLED - Consider using key-based authentication"
else
    echo "[+] Password Authentication DISABLED - Secure"
fi

# 4. Count failed SSH login attempts
failed_attempts=$(grep "Failed password" /var/log/secure | wc -l)
echo "[*] Failed SSH Login Attempts: $failed_attempts"

# 5. Check SSH port configuration
ssh_port=$(grep -i "^Port" /etc/ssh/sshd_config | awk '{print $2}')

if [[ -z "$ssh_port" ]]; then
    echo "[*] SSH Port not explicitly set. Using default port 22."
    ssh_port="22"
else
    echo "[*] SSH Port configured as: $ssh_port"
fi

if [[ "$ssh_port" == "22" ]]; then
    echo "[!] SSH is running on default port 22 - Consider changing it to reduce automated attacks"
else
    echo "[+] SSH is using a non-default port ($ssh_port) - Good practice"
fi


# 6. Check if SSH service is active and enabled
echo "-------------------------------------------"
echo "[*] Checking SSH service status..."

# Check if sshd service is running
if systemctl is-active --quiet sshd; then
    echo "[+] SSH service is RUNNING"
else
    echo "[!] SSH service is NOT running"
fi

# Check if sshd is enabled on boot
if systemctl is-enabled --quiet sshd; then
    echo "[+] SSH service is ENABLED to start on boot"
else
    echo "[!] SSH service is DISABLED on boot"
fi

# 7. Check for weak or deprecated ciphers and MACs
echo "-------------------------------------------"
echo "[*] Checking for weak or deprecated SSH ciphers..."

weak_ciphers_found=0

# List of weak keywords to check
weak_keywords=("arcfour" "md5" "cbc" "des" "3des")

# Search sshd_config for each weak keyword
for keyword in "${weak_keywords[@]}"; do
    if grep -qi "$keyword" /etc/ssh/sshd_config; then
        echo "[!] Weak cipher or algorithm detected: $keyword"
        weak_ciphers_found=1
    fi
done

if [[ $weak_ciphers_found -eq 0 ]]; then
    echo "[+] No weak ciphers detected - Secure configuration"
fi

# 1.1 Check for CVE-2024-6387 vulnerability (RegreSSHion)
# Vulnerable versions: OpenSSH 8.5p1 → 9.8p1 on glibc systems
echo "[*] Checking for known vulnerabilities (CVE-2024-6387)..."

# Extract numeric part (8.9p1 → 8.9)
version_num=$(echo "$version" | grep -oE '[0-9]+\.[0-9]+')

# Compare version
if [[ $(echo "$version_num >= 8.5" | bc) -eq 1 && $(echo "$version_num <= 9.8" | bc) -eq 1 ]]; then
    echo "[!] Detected OpenSSH version $version_num - potentially vulnerable to CVE-2024-6387"
    echo "    → Patch or upgrade to OpenSSH 9.8p2 or later recommended."
else
    echo "[+] No known CVE-2024-6387 vulnerability detected for this version."
fi
