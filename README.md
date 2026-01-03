\# Vikunja Goal Tracker Setup



Personal goal tracking system running on Raspberry Pi 5.



\## Overview



This setup provides:

\- \*\*Vikunja\*\*: FOSS task/goal management system

\- \*\*PostgreSQL\*\*: Backend database

\- \*\*Future\*\*: Rust-based personal dashboard with custom visualizations (in progress!)



\## Hardware Requirements



\- Raspberry Pi 5 (tested on 8GB model)

\- Minimum 16GB SD card (or better: external SSD)

\- Active internet connection for initial setup



\## Prerequisites



\*\*On Raspberry Pi 5 (Linux):\*\*



Install Docker and Docker Compose:



\\`\\`\\`bash

\# Update system

sudo apt update \&\& sudo apt upgrade -y



\# Install Docker

curl -fsSL https://get.docker.com -o get-docker.sh

sudo sh get-docker.sh

sudo usermod -aG docker $USER



\# Install Docker Compose

sudo apt install docker-compose -y



\# Log out and back in for group changes to take effect

\\`\\`\\`



\*\*On Windows (for development/testing):\*\*



\- Install Docker Desktop from docker.com

\- Ensure WSL2 is enabled



\## Installation



\### On Windows (Development)



1\. \*\*Clone or download this repository\*\*



\\`\\`\\`powershell

git clone https://github.com/YOUR\_USERNAME/vikunja-setup.git

cd vikunja-setup

\\`\\`\\`



2\. \*\*Update passwords in docker-compose.yml\*\*



Generate secure passwords:



\\`\\`\\`powershell

\# Generate database password

-join ((48..57) + (65..90) + (97..122) | Get-Random -Count 24 | ForEach-Object {\[char]$\_})



\# Generate JWT secret (32 chars)

-join ((48..57) + (65..90) + (97..122) | Get-Random -Count 32 | ForEach-Object {\[char]$\_})

\\`\\`\\`



Replace in `docker-compose.yml`:

\- `POSTGRES\_PASSWORD` and `VIKUNJA\_DATABASE\_PASSWORD` (must match!)

\- `VIKUNJA\_SERVICE\_JWTSECRET`



3\. \*\*Run setup script\*\*



\\`\\`\\`powershell

.\\setup.ps1

\\`\\`\\`



4\. \*\*Start Vikunja\*\*



\\`\\`\\`powershell

docker-compose up -d

\\`\\`\\`



5\. \*\*Access Vikunja\*\*



Open browser: `http://localhost:8080`



\### On Raspberry Pi 5 (Production)



1\. \*\*Transfer files to your Pi\*\*



\\`\\`\\`bash

\# From your Windows machine

scp -r vikunja-setup/ pi@YOUR\_PI\_IP:~/

\\`\\`\\`



2\. \*\*SSH into your Pi\*\*



\\`\\`\\`bash

ssh pi@YOUR\_PI\_IP

cd ~/vikunja-setup

\\`\\`\\`



3\. \*\*Convert setup.ps1 to setup.sh\*\*



The PowerShell script needs to be converted to bash. Create `setup.sh`:



\\`\\`\\`bash

nano setup.sh

\\`\\`\\`



(We'll provide a bash version in the repo)



4\. \*\*Make it executable and run\*\*



\\`\\`\\`bash

chmod +x setup.sh

./setup.sh

\\`\\`\\`



5\. \*\*Start Vikunja\*\*



\\`\\`\\`bash

docker-compose up -d

\\`\\`\\`



6\. \*\*Access on your network\*\*



From any device: `http://YOUR\_PI\_IP:8080`



\## Recommended Project Structure



Once logged in, create these top-level \*\*Projects\*\*:



\### 1. Technical Goals

\- ML Basketball Predictions (LSTM + temporal patterns)

\- Ham Radio License Progress (DEF CON August 2025)

\- Home Lab Infrastructure



\### 2. Career

\- Job Search (Target: September 2025)

\- Portfolio Projects

\- Networking \& Applications



\### 3. Health \& Fitness

\- Lean Out Goal (Target: June 2025)

\- Powerlifting Nutrition

\- Weekly Metrics Tracking



\## Task Examples



\*\*Health - Weekly Weigh-In:\*\*

\- \*\*Title:\*\* "Sunday Morning Weigh-In"

\- \*\*Recurrence:\*\* Every Sunday at 8am

\- \*\*Description:\*\* "XXX lbs" (format for easy parsing later)

\- \*\*Labels:\*\* #metrics, #health



\*\*Ham Radio - Study Progress:\*\*

\- \*\*Title:\*\* "General Class Practice Exam"

\- \*\*Recurrence:\*\* Weekly

\- \*\*Description:\*\* "Score: XX/35 correct"

\- \*\*Labels:\*\* #defcon, #study



\*\*Job Search - Applications:\*\*

\- \*\*Title:\*\* "Submit 5 Applications"

\- \*\*Recurrence:\*\* Weekly

\- \*\*Due Date:\*\* Every Friday

\- \*\*Labels:\*\* #career, #september-goal



\## Monitoring



\\`\\`\\`bash

\# Check if containers are running

docker-compose ps



\# View logs (see what's happening)

docker-compose logs -f



\# View just API logs

docker-compose logs -f api



\# Restart services

docker-compose restart



\# Stop everything

docker-compose down



\# Stop and remove all data (DANGEROUS!)

docker-compose down -v

\\`\\`\\`



\## Data Backup



Your data lives in:

\- `./db/` - PostgreSQL database (all your tasks/goals)

\- `./files/` - Uploaded attachments



\*\*Backup regularly:\*\*



\\`\\`\\`bash

\# Create timestamped backup

tar -czf vikunja-backup-$(date +%Y%m%d).tar.gz db/ files/



\# Restore from backup

tar -xzf vikunja-backup-20250102.tar.gz

\\`\\`\\`



\*\*Pro tip:\*\* Set up a weekly cron job for automatic backups!



\## Mobile Access



\### Local Network Only (Current Setup)



1\. Install Vikunja mobile app:

&nbsp;  - iOS: App Store

&nbsp;  - Android: Google Play Store



2\. Configure server URL: `http://YOUR\_PI\_IP:8080`



3\. Login with your credentials



4\. \*\*Works offline!\*\* - Updates sync when reconnected to WiFi



\### Remote Access (Phase 2 - Coming Soon)



WireGuard VPN setup will enable:

\- Cellular access when away from home

\- Secure encrypted tunnel

\- Access to all home services (Frigate, Vikunja, etc.)



\## Troubleshooting



\*\*Container won't start:\*\*

\\`\\`\\`bash

\# Check logs for errors

docker-compose logs api

docker-compose logs db

\\`\\`\\`



\*\*Can't access web interface:\*\*

\- Verify Pi's IP: `hostname -I`

\- Check port 8080 not blocked by firewall

\- Ensure containers running: `docker-compose ps`



\*\*Database connection errors:\*\*

\- Passwords must match in docker-compose.yml:

&nbsp; - `POSTGRES\_PASSWORD`

&nbsp; - `VIKUNJA\_DATABASE\_PASSWORD`

\- Check database is healthy: `docker-compose logs db`



\*\*"Permission denied" errors:\*\*

\- Ensure `db/` and `files/` directories exist

\- Check ownership: `ls -la`



\## Resource Usage on Pi 5



Expected consumption:

\- \*\*RAM:\*\* ~300-400MB (PostgreSQL + Vikunja)

\- \*\*CPU:\*\* <5% idle, ~10-15% during sync

\- \*\*Disk:\*\* ~100MB initial, grows with task data



Should run comfortably alongside:

\- Frigate camera system

\- WireGuard VPN

\- Other lightweight services



\## Roadmap



\### Phase 1: ✅ Vikunja Core Setup (Current)

\- \[x] Docker Compose configuration

\- \[x] PostgreSQL backend

\- \[x] Local web access

\- \[ ] Basic project structure created

\- \[ ] Mobile app configured



\### Phase 2: 🔄 WireGuard Integration (Next)

\- \[ ] Secure remote access configuration

\- \[ ] Mobile access over cellular

\- \[ ] Certificate management

\- \[ ] Integration with existing WireGuard setup



\### Phase 3: 🚀 Rust Visualization Dashboard (Future)

\- \[ ] Vikunja REST API client

\- \[ ] Time-series data extraction

\- \[ ] Weight tracking visualization

\- \[ ] Study progress charts (ham radio exam prep)

\- \[ ] Job search funnel metrics

\- \[ ] Custom D3.js or Plotters visualizations

\- \[ ] Real-time goal projection algorithms

\- \[ ] LSTM integration for trend prediction



\## Future Tech Stack (Phase 3)



\*\*Rust components:\*\*

\- `reqwest` - HTTP client for Vikunja API

\- `serde` / `serde\_json` - JSON parsing

\- `tokio` - Async runtime

\- `sqlx` or `diesel` - PostgreSQL ORM

\- `plotters` or `D3.js` - Visualization engine

\- `actix-web` or `axum` - Web framework for dashboard



\*\*Why Rust?\*\*

\- Learning opportunity aligned with career goals

\- Performance for data processing

\- Strong typing for API contracts

\- Great for embedded/Pi deployment



\## Vikunja API Access



API endpoint: `http://YOUR\_PI\_IP:3456/api/v1`



\*\*Get API token:\*\*

1\. Login to web interface

2\. Settings → API Tokens

3\. Create new token

4\. Save it securely!



\*\*Example API call:\*\*

\\`\\`\\`bash

curl -H "Authorization: Bearer YOUR\_TOKEN" \\

&nbsp; http://YOUR\_PI\_IP:3456/api/v1/tasks

\\`\\`\\`



\*\*Useful endpoints:\*\*

\- `GET /api/v1/tasks` - All tasks

\- `GET /api/v1/lists` - All lists/projects

\- `GET /api/v1/lists/{id}/tasks` - Tasks in specific list

\- `POST /api/v1/tasks` - Create new task



Full API docs: https://vikunja.io/docs/api/



\## Contributing



This is a personal project, but feel free to fork and adapt!



If you build something cool on top of this, I'd love to hear about it.



\## License



MIT License - See Vikunja's license for core software.



Configuration and setup scripts in this repo are free to use.



\## Links



\- \[Vikunja Documentation](https://vikunja.io/docs/)

\- \[Vikunja GitHub](https://github.com/go-vikunja/vikunja)

\- \[Docker Hub - Vikunja](https://hub.docker.com/r/vikunja/vikunja)

\- \[My GitHub](https://github.com/YOUR\_USERNAME)



---



\*\*Project Status:\*\* Phase 1 - Core Setup



\*\*Last Updated:\*\* January 2025



\*\*Maintainer:\*\* Mike - ML Engineer \& Ham Radio Enthusiast 📻

