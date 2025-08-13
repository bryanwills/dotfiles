# Secure Rclone Configuration

This directory contains a secure setup for rclone that keeps sensitive credentials out of version control.

## Files

- `rclone.conf.template` - Template configuration with environment variable placeholders
- `setup-env.sh` - Script to create the .env file with your credentials
- `generate-config.sh` - Script to generate the secure rclone.conf from template
- `.gitignore` - Prevents sensitive files from being committed
- `README.md` - This file

## Setup Instructions

### 1. Initial Setup

```bash
# Make scripts executable
chmod +x setup-env.sh generate-config.sh

# Create .env file with your credentials
./setup-env.sh
```

### 2. Update Credentials

Edit the `.env` file and replace the placeholder values with your actual Google OAuth credentials:

```bash
# Edit the .env file
nano .env  # or use your preferred editor
```

Make sure to update:
- `RCLONE_CLIENT_ID` - Your Google OAuth client ID
- `RCLONE_CLIENT_SECRET` - Your Google OAuth client secret
- `RCLONE_ACCESS_TOKEN` - Current access token (will auto-refresh)
- `RCLONE_REFRESH_TOKEN` - Refresh token for automatic renewal
- `RCLONE_TOKEN_EXPIRY` - Token expiry timestamp
- `RCLONE_TOKEN_EXPIRES_IN` - Token expiry in seconds

### 3. Generate Secure Config

```bash
# Generate the secure rclone.conf
./generate-config.sh
```

This will create a `rclone.conf` file with your actual credentials, but the file will be ignored by git.

### 4. Using Rclone

```bash
# Load environment variables
source .env

# Run rclone commands
rclone listremotes
rclone ls gdrive:
```

## Security Notes

- **Never commit the `.env` file** - it's already in `.gitignore`
- **Never commit the `rclone.conf` file** - it's also in `.gitignore`
- The template and scripts are safe to commit
- Keep your `.env` file secure and restrict access to it

## Token Management

The Google OAuth tokens will automatically refresh when they expire. If you need to regenerate tokens:

1. Delete the current tokens from `.env`
2. Run `rclone config` to re-authenticate
3. Copy the new tokens to `.env`
4. Run `./generate-config.sh` to update the config

## Troubleshooting

### envsubst not found
Install the gettext package:
- **macOS**: `brew install gettext`
- **Ubuntu/Debian**: `sudo apt-get install gettext-base`
- **CentOS/RHEL**: `sudo yum install gettext`

### Permission denied
Make sure the scripts are executable:
```bash
chmod +x setup-env.sh generate-config.sh
```

## Alternative Manual Setup

If you prefer to set up manually:

1. Create `.env` file with your credentials
2. Run: `source .env && envsubst < rclone.conf.template > rclone.conf`
3. Use rclone normally

## File Structure After Setup

```
rclone/
├── .env                    # Your credentials (not in git)
├── rclone.conf            # Generated config (not in git)
├── rclone.conf.template   # Template with placeholders
├── setup-env.sh           # Setup script
├── generate-config.sh     # Config generation script
├── .gitignore             # Git ignore rules
└── README.md              # This file
```
