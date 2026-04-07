# sandbox-llm

A minimal sandbox for experimenting with local LLMs via [Ollama](https://ollama.com/).

## What's inside

- **Ollama** running in Docker, exposing an OpenAI-compatible API on port `11434`
- Ready-made HTTP requests for emotion/sentiment analysis using `llama3.1:8b`
- A `Makefile` for convenient container and model management

## Prerequisites

- Docker & Docker Compose
- NVIDIA GPU with drivers >= 525 (for CUDA 12)
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

Verify GPU access before starting:

```bash
docker run --rm --gpus all nvidia/cuda:12.0-base nvidia-smi
```

## Quick start

```bash
# Start the Ollama container (with GPU support)
make up

# Pull the default model
make fetch-models

# Verify GPU is visible inside the container
docker exec ollama nvidia-smi

# Stop everything
make down
```

## Example: Emotion analysis

The `.http/emotions.http` file contains sample requests that send text to the local LLM and receive a structured JSON response with sentiment, detected emotions, intensity, and a short explanation.

## Model Usage

You can pull any model from the [Ollama library](https://ollama.com/library) or add models to the `Makefile` targets.

| Model                   | Purpose                                                                                      |
| ----------------------- | -------------------------------------------------------------------------------------------- |
| **qwen3-coder:30b-32k** | 🥇 Primary coding model — writing, refactoring, repo analysis, file-level tasks (daily driver) |
| **qwen3:8b-16k**        | 🧠 Planning & reasoning — architecture, debugging, decision-making                            |
| **glm4:8k**             | ⚡ Quick responses — simple questions, short tasks, fast iteration                             |
| **llama3.1:8b**         | 🧯 Fallback — last resort when other models are unavailable (no tool calling)                 |

## OpenCode configuration file
https://opencode.ai/


`~/config/opencode/opencode.json`
```json
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "ollama": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Ollama (local)",
      "options": {
        "baseURL": "http://localhost:11434/v1",
        "timeout": 600000
      },
      "models": {
        "qwen3-coder:30b-32k": {
          "tools": true,
          "maxTokens": 4096
        },
        "qwen3:8b-16k": {
          "tools": true
        },
        "glm4:8k": {
          "tools": true
        },
        "llama3.1:8b": {
          "tools": false
        }
      }
    }
  }
}
```