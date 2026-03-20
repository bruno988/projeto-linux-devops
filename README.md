# Projeto Linux DevOps 🚀

## Quem sou eu

Olá! Sou o Bruno e este é meu projeto DevOps.

Venho da área de infraestrutura de redes e estou migrando
para o mundo DevOps. Acredito que raiz forte é tudo —
por isso estou construindo uma base sólida antes de voar alto.

## Minha Jornada

Atualmente na **Fase 1 — Linux**, cobrindo:

- ✅ Fundamentos e navegação
- ✅ Permissões e usuários
- ✅ Processos e serviços (systemd)
- ✅ Shell scripting com Bash
- 🔄 Git e GitHub (agora!)
- ⏳ Docker
- ⏳ AWS
- ⏳ Terraform
- ⏳ Kubernetes

## O que tem neste projeto

Servidor Linux configurado do zero na AWS EC2 aplicando
tudo que aprendi — usuário dedicado, serviço systemd,
script de deploy automatizado e backup com cron.

## Estrutura
```
/
├── scripts/
│   ├── deploy.sh   → deploy automatizado com healthcheck
│   └── backup.sh   → backup com rotação de 7 dias
├── src/
│   └── server.py   → servidor HTTP Python porta 8080
└── config/
    └── .env        → variáveis de ambiente
```

## Endpoints da aplicação

- GET /health → status da aplicação
- GET /info   → informações e versão

## Sempre subindo! 🚀
