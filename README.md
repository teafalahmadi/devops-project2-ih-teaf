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
