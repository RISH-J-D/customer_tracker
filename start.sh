#!/usr/bin/env bash
# ClientFlow Tracker - Unified Start Script
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

echo "=========================================================="
echo " Starting ClientFlow Reminder & Follow-up Tracker"
echo "=========================================================="

# 1. Start Python FastAPI backend
echo "▶ Starting Backend API on http://127.0.0.1:8000 ..."
backend/venv/bin/uvicorn app.main:app --app-dir backend --host 0.0.0.0 --port 8000 --reload --reload-dir backend/app &
BACKEND_PID=$!

# 2. Start React Frontend
echo "▶ Starting React Web Application on http://localhost:5173 ..."
npm --prefix frontend run dev &
FRONTEND_PID=$!

trap "kill $BACKEND_PID $FRONTEND_PID 2>/dev/null || true; exit" SIGINT SIGTERM EXIT

echo ""
echo "✔ Web App running at: http://localhost:5173"
echo "✔ Backend API running at: http://localhost:8000"
echo "✔ API Documentation: http://localhost:8000/docs"
echo "✔ Press Ctrl+C to stop both servers."
echo ""

wait
