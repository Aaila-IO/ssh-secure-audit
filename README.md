### SSH Secure Audit

Automated SSH Security Auditor for Linux
Identify OpenSSH weaknesses, detect known CVE vulnerabilities, and secure misconfigurations — all in one lightweight script.

### Overview

The SSH Secure Audit tool was built to tackle a growing issue in Linux environments — unnoticed SSH vulnerabilities.
Recent CVE disclosures (like CVE-2024-6387) revealed that many servers still run outdated or unsafe OpenSSH versions without realizing it.
This tool scans your system to detect weak cryptographic ciphers, vulnerable OpenSSH builds, and risky SSH configurations before attackers can exploit them.

It automatically flags:

Outdated OpenSSH versions with known CVEs

Weak or deprecated ciphers (for example, DES or RC4)

Enabled root logins or password-based authentication

Default port 22 usage, which increases brute-force exposure

In short — it gives you a real-time security snapshot of how resilient your SSH setup is against modern attacks.
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
2. Run the Audit
   ```bash
   sudo ./audit.sh

![Script Output](https://raw.githubusercontent.com/Aaila-IO/ssh-secure-audit/60d461ff1edca2c0b27128f08a78ee6605494b2f/images/Script%20output.jpeg)

### 3. View Reports

All reports are stored in the `/reports` folder automatically.  
You can check them using:
All reports are stored in the `/reports` folder automatically.  
You can check them using:

```bash
   cd reports
   cat audit_<timestamp>.log
```
![reports](https://raw.githubusercontent.com/Aaila-IO/ssh-secure-audit/60d461ff1edca2c0b27128f08a78ee6605494b2f/images/reports.jpeg)
![Log Ex. 1](https://raw.githubusercontent.com/Aaila-IO/ssh-secure-audit/60d461ff1edca2c0b27128f08a78ee6605494b2f/images/Log%20Ex.%201.jpeg)
![Log Ex. 2](https://raw.githubusercontent.com/Aaila-IO/ssh-secure-audit/60d461ff1edca2c0b27128f08a78ee6605494b2f/images/Log%20Ex.%202.jpeg)

---

### ⭐ Support & Contributions

If you found **SSH Secure Audit** helpful, please consider giving it a ⭐ on GitHub —  
it helps more people discover and improve their server security!

Contributions, feedback, and ideas are always welcome.  
Simply open an issue or submit a pull request!



