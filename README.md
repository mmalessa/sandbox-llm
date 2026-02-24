# sandbox-llm

A minimal sandbox for experimenting with local LLMs via [Ollama](https://ollama.com/).

## What's inside

- **Ollama** running in Docker, exposing an OpenAI-compatible API on port `11434`
- Ready-made HTTP requests for emotion/sentiment analysis using `llama3.1:8b`
- A `Makefile` for convenient container and model management

## Prerequisites

- Docker & Docker Compose

## Quick start

```bash
# Start the Ollama container
make up

# Pull the default model
make fetch-models

# Stop everything
make down
```

## Example: Emotion analysis

The `.http/emotions.http` file contains sample requests that send text to the local LLM and receive a structured JSON response with sentiment, detected emotions, intensity, and a short explanation.

## Models

The default model is `llama3.1:8b`. You can uncomment additional models in the `Makefile` (e.g. `qwen3:1.7b`, `mistral:7b-instruct`, `nomic-embed-text`) or pull any model from the [Ollama library](https://ollama.com/library).
