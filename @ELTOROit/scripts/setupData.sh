#!/bin/zsh
set -e
clear

echo "🌱 Seeding data..."
echo "   Inserting accounts and contacts..."
sf apex run --file scripts/seed-accounts-contacts.apex > etLogs/SH_seed-accounts-contacts.json
echo "   Inserting TODOs..."
sf apex run --file scripts/seed-todos.apex > etLogs/SH_seed-todos.json
echo "   Inserting cases..."
sf apex run --file scripts/seed-cases.apex > etLogs/SH_seed-cases.json
echo "   ✓ Data seeded"
echo ""
