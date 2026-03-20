#!/usr/bin/env python3
import os
import json
import logging
from datetime import datetime
from http.server import HTTPServer, BaseHTTPRequestHandler

APP_NAME    = os.getenv('APP_NAME',    'minha-app')
APP_PORT    = int(os.getenv('APP_PORT', '8080'))
APP_ENV     = os.getenv('APP_ENV',     'development')
APP_VERSION = os.getenv('APP_VERSION', '0.0.1')
LOG_FILE    = os.getenv('LOG_FILE',    '/app/logs/app.log')

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] %(message)s',
    handlers=[
        logging.FileHandler(LOG_FILE),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

class AppHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/health':
            self._responder(200, {"status": "ok", "app": APP_NAME})
        elif self.path == '/info':
            self._responder(200, {
                "app":     APP_NAME,
                "versao":  APP_VERSION,
                "env":     APP_ENV,
                "hora":    datetime.now().isoformat()
            })
        else:
            self._responder(404, {"erro": "rota nao encontrada"})

    def _responder(self, code, data):
        body = json.dumps(data, ensure_ascii=False).encode()
        self.send_response(code)
        self.send_header('Content-Type', 'application/json')
        self.end_headers()
        self.wfile.write(body)
        logger.info(f"{self.client_address[0]} {self.command} {self.path} {code}")

    def log_message(self, *args): pass

if __name__ == '__main__':
    logger.info(f"Iniciando {APP_NAME} v{APP_VERSION} ({APP_ENV}) na porta {APP_PORT}")
    server = HTTPServer(('', APP_PORT), AppHandler)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        logger.info("Servidor encerrado.")
