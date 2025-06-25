# 🚀 Guia de Deploy com Terraform no Google Cloud usando Cloud Shell

Este guia explica como realizar login no GCP via Cloud Shell, clonar este repositório e aplicar os recursos definidos em Terraform.

---

## ✅ Pré-requisitos

- Acesso à uma conta com permissão no projeto GCP
- Projeto já criado no GCP
- Permissão para criar recursos (papel **Editor** ou **Owner**)
- Cloud Shell habilitado

---

## 1️⃣ Acessar o Cloud Shell

1. Vá para [https://console.cloud.google.com](https://console.cloud.google.com)
2. Clique no ícone do terminal ("`>_`") no topo direito
3. Aguarde a inicialização (~10 segundos)

---

## 2️⃣ Fazer Login e Selecionar Projeto

```bash
gcloud auth login
gcloud config set project [ID_DO_PROJETO]
gcloud config list
```

Substitua `[ID_DO_PROJETO]` pelo ID real do seu projeto GCP.

---

## 3️⃣ Clonar o Repositório

```bash
git clone https://github.com/barberosanto/bootcamp.git
cd bootcamp
```

---

## 4️⃣ Inicializar o Terraform

```bash
terraform init
```

---

## 5️⃣ Validar a Configuração

```bash
terraform validate
```

---

## 6️⃣ Visualizar o Plano de Execução

```bash
terraform plan
```

---

## 7️⃣ Aplicar o Terraform

```bash
terraform apply
```

Digite `yes` quando solicitado para confirmar.

---

## 8️⃣ Verificar Recursos Criados

```bash
gcloud compute networks list
gcloud container clusters list
```

---

## 🔧 Edição de Variáveis

Para editar os valores de variáveis:

```bash
nano terraform.tfvars
```

---

## ⚠️ Problemas Comuns

- **Permissão negada:** Verifique seu papel IAM no projeto.
- **APIs não ativadas:** Execute:
```bash
gcloud services enable compute.googleapis.com container.googleapis.com
```