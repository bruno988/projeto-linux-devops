#!/bin/bash
set -euo pipefail

APP_DIR="/app"
SERVICE="minha-app"
LOG="/app/logs/deploy.log"
HEALTH_URL="http://localhost:8080/health"
MAX_WAIT=30

timestamp() { date '+%Y-%m-%d %H:%M:%S'; }

log() {
  local msg="[$(timestamp)] [INFO]  $*"
  echo "$msg"
  echo "$msg" >> $LOG
}

log_err() {
  local msg="[$(timestamp)] [ERROR] $*"
  echo "$msg" >&2
  echo "$msg" >> $LOG
}

log_ok() {
  local msg="[$(timestamp)] [OK]    $*"
  echo "$msg"
  echo "$msg" >> $LOG
}

healthcheck() {
  local tentativa=0
  log "Aguardando aplicacao subir..."
  while [ $tentativa -lt $MAX_WAIT ]; do
    if curl -sf $HEALTH_URL > /dev/null 2>&1; then
      log_ok "Aplicacao respondendo! OK"
      return 0
    fi
    tentativa=$(( tentativa + 1 ))
    sleep 1
  done
  log_err "Aplicacao nao respondeu em ${MAX_WAIT}s"
  return 1
}

trap 'log_err "Deploy falhou na linha $LINENO"' ERR

log "================================"
log "Deploy iniciado por: $(whoami)"
log "================================"

log "Criando backup da versao atual..."
BACKUP=$APP_DIR/backups/pre-deploy_$(date +%Y%m%d_%H%M%S).tar.gz
tar -czf $BACKUP -C $APP_DIR/src . 2>/dev/null || true
log "Backup: $BACKUP"

log "Reiniciando $SERVICE..."
sudo systemctl restart $SERVICE
log "Servico reiniciado."

if healthcheck; then
  log_ok "==========================="
  log_ok "Deploy concluido com sucesso"
  log_ok "==========================="
else
  log_err "Deploy falhou!"
  exit 1
fi
