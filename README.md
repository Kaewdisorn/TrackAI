# 🛰️ TrackAI

**TrackAI** is a real-time location tracking platform with simulation and monitoring capabilities.  
It demonstrates full-stack engineering and AI integration via FastAPI.

---

## 🌟 Features

- 📍 **Simulation Web Client** – Simulates vehicles/devices sending GPS data  
- 🗺️ **Monitoring Web Client** – Real-time dashboard for tracking and replaying routes  
- 💾 **Offline Support (Hive)** – Local storage for GPS history, preferences, and offline replay  
- ⚡ **Backend Microservices** –  
  - Dart Shelf → Real-time GPS APIs & WebSockets  
  - Node.js → Monitoring & Analytics APIs  
  - FastAPI → AI-powered predictions & anomaly detection  
- 🗄️ **Database** – PostgreSQL + PostGIS for spatial data  
- 🔗 **Redis** – Real-time caching & pub/sub  
- 🐳 **Docker & Swarm** – Containerized deployment and scaling  
- 🌐 **HAProxy** – Load balancing across backend services  
- 🚀 **Varnish** – High-performance caching for static and API responses  

---

## ⚙️ Tech Stack

- **Frontend**: Flutter Web (simulation & monitoring UIs)  
- **Backend Services**:  
  - **Dart Shelf** → Real-time GPS data & WebSockets  
  - **Node.js (NestJS/Fastify)** → Monitoring dashboards, analytics APIs  
  - **FastAPI (Python)** → AI/ML (ETA prediction, anomaly detection, clustering)  
- **Database**: PostgreSQL + PostGIS  
- **Cache & Messaging**: Redis  
- **Local Storage**: Hive (offline support on clients)  
- **Load Balancing**: HAProxy  
- **Caching Layer**: Varnish  
- **Deployment**: Docker, Docker Swarm  
