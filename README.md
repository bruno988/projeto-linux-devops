# Projeto Linux DevOps

Servidor Linux configurado do zero na AWS EC2.

## Estrutura
```
/
├── scripts/
│   ├── deploy.sh   → script de deploy automatizado
│   └── backup.sh   → backup com rotação de 7 dias
├── src/
│   └── server.py   → servidor HTTP Python porta 8080
└── config/
    └── .env        → variáveis de ambiente
```

## Endpoints
- GET /health → status da aplicação
- GET /info   → informações da aplicação

## Como usar
```bash
# Deploy
./scripts/deploy.sh

# Backup manual
./scripts/backup.sh
```
