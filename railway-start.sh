#!/bin/bash
# Railway start script (optional)
# Railway will auto-detect, but this can be used for custom setup

# Get port from environment variable (Railway sets this automatically)
PORT=${PORT:-8010}

# Start application
exec uvicorn docutranslate.app:app --host 0.0.0.0 --port $PORT
