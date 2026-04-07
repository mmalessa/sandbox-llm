#!/usr/bin/env bash

set -e

echo "👉 Pulling base models..."
ollama pull llama3.1:8b
ollama pull qwen3-coder:30b
ollama pull qwen3:8b
ollama pull glm4:latest
ollama pull qwen3:1.7b

echo ""
echo "👉 Preparing models..."

create_model_if_not_exists() {
  local model_name="$1"
  local base_model="$2"
  local ctx="$3"
  local file="/tmp/${model_name}.modelfile"

  # 👉 jeśli ctx = 0 → pomijamy
  if [ "$ctx" -eq 0 ]; then
    echo "⏭️ Skipping ${model_name} (ctx=0)"
    return
  fi

  if ollama list | grep -q "${model_name}"; then
    echo "✔ ${model_name} already exists"
  else
    echo "⚙️ Creating ${model_name} (ctx=${ctx})..."

    cat <<EOF > "${file}"
FROM ${base_model}
PARAMETER num_ctx ${ctx}
EOF

    ollama create "${model_name}" -f "${file}"
  fi
}

# 🔥 konfiguracja modeli
create_model_if_not_exists "qwen3-coder:30b-32k" "qwen3-coder:30b" 32768
create_model_if_not_exists "qwen3:8b-16k" "qwen3:8b" 16384
create_model_if_not_exists "glm4:8k" "glm4:latest" 8192

echo ""
echo "✅ All models ready."
