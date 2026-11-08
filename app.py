from flask import Flask, jsonify

app = Flask(__name__)


@app.get("/")
def home():
    return jsonify(
        message="Welcome to my DevSecOps Security Lab",
        status="running",
    )


@app.get("/health")
def health():
    return jsonify(status="ok")
