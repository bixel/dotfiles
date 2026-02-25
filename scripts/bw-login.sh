#!/bin/bash
# filepath: /Users/kevin_heinicke/repos/apollo/bw-login.sh

# Bitwarden CLI Login Manager with macOS Keychain Integration
# Usage: ./bw-login.sh

set -e

KEYCHAIN_SERVICE="bitwarden-cli"
KEYCHAIN_ACCOUNT="session-key"

# Function to check if already logged in
check_login_status() {
    bw status | grep -q '"status":"unlocked"'
}

# Function to get session key from keychain
get_session_from_keychain() {
    security find-generic-password -s "$KEYCHAIN_SERVICE" -a "$KEYCHAIN_ACCOUNT" -w 2>/dev/null || echo ""
}

# Function to store session key in keychain
store_session_in_keychain() {
    local session_key="$1"
    # Delete existing entry if it exists
    security delete-generic-password -s "$KEYCHAIN_SERVICE" -a "$KEYCHAIN_ACCOUNT" 2>/dev/null || true
    # Add new entry
    security add-generic-password -s "$KEYCHAIN_SERVICE" -a "$KEYCHAIN_ACCOUNT" -w "$session_key"
}

# Function to validate session key
validate_session() {
    local session_key="$1"
    BW_SESSION="$session_key" bw status | grep -q '"status":"unlocked"'
}

# Main logic
main() {
    echo "Checking Bitwarden CLI login status..."
    
    # Check if already logged in and unlocked
    if check_login_status; then
        echo "✅ Already logged in and unlocked"
        return 0
    fi
    
    # Try to get session from keychain
    stored_session=$(get_session_from_keychain)
    
    if [ -n "$stored_session" ]; then
        echo "Found stored session, validating..."
        if validate_session "$stored_session"; then
            echo "✅ Using stored session from keychain"
            export BW_SESSION="$stored_session"
            echo "Session exported as BW_SESSION environment variable"
            return 0
        else
            echo "⚠️  Stored session is invalid, removing from keychain"
            security delete-generic-password -s "$KEYCHAIN_SERVICE" -a "$KEYCHAIN_ACCOUNT" 2>/dev/null || true
        fi
    fi
    
    # Need to login
    echo "Logging in to Bitwarden..."
    
    # Check if we need to login to the server first
    if bw status | grep -q '"status":"unauthenticated"'; then
        echo "Please enter your Bitwarden credentials:"
        bw login
    fi
    
    # Unlock the vault
    echo "Unlocking vault..."
    session_key=$(bw unlock --raw)
    
    if [ $? -eq 0 ] && [ -n "$session_key" ]; then
        echo "✅ Successfully logged in"
        
        # Store session in keychain
        store_session_in_keychain "$session_key"
        echo "✅ Session stored in macOS Keychain"
        
        # Export session for current shell
        export BW_SESSION="$session_key"
        echo "✅ Session exported as BW_SESSION environment variable"
        
        echo ""
        echo "To use this session in your current shell, run:"
        echo "export BW_SESSION=\"$session_key\""
    else
        echo "❌ Failed to login or unlock vault"
        exit 1
    fi
}

main "$@"