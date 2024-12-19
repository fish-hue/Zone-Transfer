# Zone Transfer Checke

This script checks for DNS zone transfer vulnerabilities for a given domain. It uses the `dig` tool to query authoritative nameservers and attempts a zone transfer (`AXFR`) on each one to determine if any of them are misconfigured to allow unauthorized transfers.

## Features:
- Retrieves the authoritative nameservers for the specified domain.
- Attempts a zone transfer (`AXFR`) on each nameserver.
- Checks whether the zone transfer is successful or not.
- Provides a simple and clear report of the zone transfer results.

## Requirements:
- **`dig`**: This script uses `dig` (Domain Information Groper) to query DNS information. `dig` is commonly pre-installed on most Unix-like systems (Linux, macOS). If it's not installed, you can easily install it using a package manager.

    - For **Ubuntu/Debian**:
      ```bash
      sudo apt-get install dnsutils
      ```
    - For **CentOS/RHEL**:
      ```bash
      sudo yum install bind-utils
      ```
    - For **macOS** (via Homebrew):
      ```bash
      brew install bind
      ```

## Installation:

1. Clone or download the repository containing the script or save the script as a file named `check_zone_transfer.sh`.

2. Make the script executable:
   ```bash
   chmod +x check_zone_transfer.sh
   ```

## Usage:

To use the script, run the following command:

```bash
./check_zone_transfer.sh <domain_name>
```

Replace `<domain_name>` with the domain you want to check.

Example:
```bash
./check_zone_transfer.sh example.com
```

The script will:

1. Retrieve the authoritative nameservers for the domain.
2. Attempt a zone transfer (`AXFR`) with each nameserver.
3. Display the results of the zone transfer attempt for each nameserver:
   - If the zone transfer is successful, it will list the transferred DNS records.
   - If the zone transfer fails, it will indicate that the transfer attempt was unsuccessful.

## Example Output:

```bash
[*] Checking authoritative nameservers for example.com
ns1.example.com.
ns2.example.com.
[*] Attempting zone transfer on nameserver: ns1.example.com
[!] Zone transfer failed on ns1.example.com.
[*] Attempting zone transfer on nameserver: ns2.example.com
[*] Zone transfer succeeded on ns2.example.com:
example.com.    3600    IN    A    192.0.2.1
example.com.    3600    IN    A    198.51.100.1
example.com.    3600    IN    MX   10 mail.example.com.
...
```

## Troubleshooting:
- **No nameservers found**: If the script reports that no nameservers were found for the domain, ensure the domain is valid and properly configured with authoritative nameservers.
  
- **Firewall or DNS security settings**: If the script reports that zone transfer attempts failed, it may be due to the target nameserver blocking unauthorized `AXFR` requests. This is the expected behavior for secure DNS configurations.

## Ethical Considerations:
- **Permission**: Ensure you have permission to perform zone transfer checks against the domain you are testing. Unauthorized scanning or probing of DNS servers can be considered illegal or unethical in certain jurisdictions.
  
- **Use responsibly**: This script is intended for use by network administrators, security professionals, or anyone authorized to check the security of DNS configurations. Always comply with applicable laws and obtain proper authorization before running the script.
