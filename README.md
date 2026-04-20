# 🏗️ Infraestrutura AWS como Código — Terraform

> Infraestrutura completa na AWS criada automaticamente via código Terraform — sem clicar no console.

🔗 **[API ao vivo](http://54.232.211.241:8000)**  
📁 **[Repositório](https://github.com/Flavio-Paixao/terraform-aws)**

---

## 🏗️ O que foi criado

Com apenas `terraform apply` toda essa infraestrutura é criada automaticamente:

```
terraform apply → EC2 + Security Group + Elastic IP + Deploy automático
```

```
┌─────────────────────────────────────────────┐
│           terraform apply                   │
│                                             │
│  ┌──────────────┐   ┌──────────────────┐   │
│  │ Security     │   │   EC2 t3.micro   │   │
│  │ Group        │──▶│   Ubuntu 22.04   │   │
│  │ (Firewall)   │   │   + API Django   │   │
│  └──────────────┘   └──────────────────┘   │
│                              │              │
│                     ┌────────────────┐      │
│                     │  Elastic IP    │      │
│                     │  (IP Fixo)     │      │
│                     └────────────────┘      │
└─────────────────────────────────────────────┘
```

---

## ☁️ Recursos AWS Criados

| Recurso | Descrição |
|---|---|
| **EC2 t3.micro** | Servidor virtual Ubuntu 22.04 |
| **Security Group** | Firewall com portas 22, 80, 443 e 8000 |
| **Elastic IP** | IP fixo associado à instância |
| **Key Pair** | Chave SSH para acesso ao servidor |

- **Região:** `sa-east-1` (São Paulo)
- **Deploy automático:** API Django instalada via User Data

---

## 📁 Estrutura do Projeto

```
terraform-aws/
├── main.tf          # Recursos principais (EC2, SG, EIP)
├── variables.tf     # Variáveis configuráveis
├── outputs.tf       # Outputs após apply
├── providers.tf     # Configuração do provider AWS
└── .gitignore       # Arquivos ignorados pelo Git
```

---

## 🚀 Como usar

### Pré-requisitos
- Terraform instalado
- AWS CLI configurado com credenciais

### Comandos

```bash
# Inicializar o Terraform
terraform init

# Ver o que será criado
terraform plan

# Criar a infraestrutura
terraform apply

# Destruir tudo
terraform destroy
```

### Outputs após apply

```
api_url           = "http://SEU_IP:8000"
instance_id       = "i-xxxxxxxxxxxxxxxxx"
public_ip         = "SEU_IP"
security_group_id = "sg-xxxxxxxxxxxxxxxxx"
```

---

## 💡 Por que Terraform?

| Método Tradicional | Com Terraform |
|---|---|
| Clicar no console AWS | Escrever código |
| Processo manual e demorado | `terraform apply` em segundos |
| Difícil de replicar | Replicável em qualquer conta |
| Sem histórico de mudanças | Versionado no Git |
| Difícil de destruir tudo | `terraform destroy` |

---

## 👨‍💻 Sobre

**Flávio da Paixão Nunes** — Desenvolvedor Backend Python | AWS Cloud  
Estudante de Engenharia de Software (Ampli/Anhanguera) — 2º ano  
Santos, São Paulo - SP

[![LinkedIn](https://img.shields.io/badge/LinkedIn-flaviopx-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/flaviopx)
[![GitHub](https://img.shields.io/badge/GitHub-Flavio--Paixao-black?style=flat&logo=github)](https://github.com/Flavio-Paixao)
[![Portfolio](https://img.shields.io/badge/Portf%C3%B3lio-AWS-orange?style=flat&logo=amazonaws)](https://projeto-aws-681892816208-sa-east-1-an.s3.sa-east-1.amazonaws.com/index.html)

---

## 🚀 Stack

![Terraform](https://img.shields.io/badge/Terraform-IaC-purple?style=flat&logo=terraform)
![AWS EC2](https://img.shields.io/badge/AWS-EC2-orange?style=flat&logo=amazonaws)
![AWS IAM](https://img.shields.io/badge/AWS-IAM-orange?style=flat&logo=amazonaws)
![Python](https://img.shields.io/badge/Python-Django-blue?style=flat&logo=python)
