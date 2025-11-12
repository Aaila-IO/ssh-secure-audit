## SSH Secure Audit  
**Automated SSH Security Auditor for Linux**  
Quickly detect weak ciphers, outdated OpenSSH versions, insecure configurations, and login vulnerabilities — all in one script.

## Overview  
The **SSH Secure Audit** tool scans your Linux server and flags potential misconfigurations that hackers exploit most often:  
- Weak or deprecated SSH ciphers (like DES)  
- Outdated or vulnerable OpenSSH versions  
- Enabled root logins  
- Password-based authentication (instead of key-based)  
- Default SSH port (22) risks  

In simple terms — it tells you **how exposed your SSH setup really is**.

---

## ⚙️ Features  
✅ Detects outdated OpenSSH versions and compares against known CVEs  
✅ Checks for weak ciphers, algorithms, and unsafe authentication methods  
✅ Validates SSH service status, failed logins, and startup configurations  
✅ Lightweight (single-file shell script) — no dependencies required  
✅ Generates clear terminal output and logs  

---

## 🧩 How to Use  

1. **Clone the repo**
   ```bash
   git clone https://github.com/Aaila-IO/ssh-secure-audit.git
   cd ssh-secure-audit


