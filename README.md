# 🌐 DevOps 3-Tier Web Application on Azure

🚀 A complete **Cloud & DevOps project** developed during the **Saudi Digital Academy × Ironhack Bootcamp**.  
This project demonstrates full automation and modern DevOps practices using **Terraform**, **Docker**, and **GitHub Actions CI/CD** — all running securely on **Azure** with private networking.

---

## 🏗️ Infrastructure as Code (Terraform)
All Azure resources are created and managed using **Terraform**.

### ☁️ Key Components
- 🧱 **Resource Group** → `project2-teaf`
- 🌐 **Virtual Network** with 4 Subnets:
  - `frontend-subnet`
  - `backend-subnet`
  - `data-subnet`
  - `ops-subnet` *(contains the Private VM)*
- 🧩 **Application Gateway (WAF v2)** → the only public entry point  
- 🔒 **Private VM** without Public IP for secure internal deployment  
- 🗄️ **Azure SQL / PostgreSQL** with **Private Endpoint**
- 📊 **Monitoring Stack**: Application Insights + Log Analytics

> ✨ All networking and compute components are private by design, ensuring end-to-end isolation and security.

---

## 🐳 Application Deployment (Docker)

Each tier of the app is containerized and orchestrated with **Docker Compose**:

| Layer | Technology | Description |
|-------|-------------|-------------|
| 🎨 Frontend | React + Vite | Responsive web UI |
| ⚙️ Backend | Java (Maven) / Node.js | API logic & routing |
| 🗃️ Database | PostgreSQL | Data persistence |

> All services communicate through an internal Docker network for seamless interaction.

---

## ⚙️ Continuous Integration / Continuous Deployment (GitHub Actions)

Two automated pipelines are configured on a **Self-Hosted Runner (Private VM)** 🧠

### 🧩 1. Terraform CI/CD
Automates infrastructure lifecycle:
Terraform Init → Validate → Plan → Apply


### 🚀 2. Application CI/CD
Builds and deploys the containers automatically:
Setup Java → Build Backend → Setup Node → Build Frontend → Deploy → Healthcheck


> Both workflows ensure that infrastructure and code are deployed continuously, securely, and consistently.

---

## 🗂️ Project Structure

```bash
devops-project2-ih-teaf/
├── .github/
│ └── workflows/
│ ├── Infra.yml # CI/CD for Terraform
│ └── deploy.yml # CI/CD for app deployment
│
├── backend/ # Backend API service (Java / Maven)
│ ├── Dockerfile
│ ├── .env.save
│
├── frontend/ # Frontend web app (React + Vite)
│ ├── Dockerfile
│ ├── .env.save
│
├── infra/
│ └── infra/
│ └── terraform/ # Infrastructure as Code (IaC)
│ ├── main.tf
│ ├── appgw.tf
│ ├── database.tf
│ ├── monitoring.tf
│ ├── outputs.tf
│ ├── variables.tf
│ ├── versions.tf
│ ├── terraform.tfvars
│ ├── terraform.tfstate
│ ├── terraform.tfstate.backup
│ ├── tfplan
│ └── .terraform.lock.hcl
│
├── docker-compose.yml # Container orchestration
├── environment.env # Environment variables
├── environment.env.example # Example environment file
├── .gitignore # Git ignore list
└── README.md # Documentation
```

🧭 The structure cleanly separates Infrastructure, Application, and Automation,
following modern DevOps best practices.

## 📸 Architecture Overview

```text
[ Internet ]
│
▼
🌐 Application Gateway (WAF v2)
│
▼
🖥️ Private VM (Docker Host)
├── Frontend (React)
├── Backend (Java API)
└── PostgreSQL Database (Private Endpoint)
```

All components live inside an Azure VNet for complete isolation
and are monitored through Azure Monitor.


## 🌟 Key Highlights

✅ Full 3-Tier Architecture (Frontend, Backend, Database)  
✅ Private Networking with Secure Access  
✅ Automated Infrastructure (Terraform)  
✅ Containerized Application (Docker)  
✅ End-to-End CI/CD (GitHub Actions)  
✅ Real-World Cloud Implementation (Azure)


## 🧠 Tech Stack

| Category | Tools |
|-----------|--------|
| ☁️ **Cloud** | Microsoft Azure |
| 🏗️ **IaC** | Terraform |
| 🐳 **Containers** | Docker, Docker Compose |
| ⚙️ **CI/CD** | GitHub Actions |
| 💻 **Frontend** | React + Vite |
| 🔧 **Backend** | Java (Maven) / Node.js |
| 🗄️ **Database** | PostgreSQL / Azure SQL |
| 🔒 **Security** | Private Subnet + WAF v2 |
| 📊 **Monitoring** | Azure Monitor + Application Insights |

## 👩🏻‍💻 About the Developer
👤 Teaf Alahmadi  
Cloud & DevOps Engineer | Azure Enthusiast

## ✨ “Automate everything, deploy securely, and keep learning!” 🚀


