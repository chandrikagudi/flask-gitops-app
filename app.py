import os
from flask import Flask, jsonify

app = Flask(__name__)

# Reads the version from environment variables to showcase canary rollouts
APP_VERSION = os.getenv("APP_VERSION", "v1.0.0")

@app.route("/")
def index():
    return jsonify({
        "status": "healthy",
        "service": "order-processor",
        "version": APP_VERSION
    }), 200

@app.route("/healthz")
def health():
    return jsonify({"status": "ok"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)