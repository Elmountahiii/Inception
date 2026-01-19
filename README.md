# Inception

A comprehensive Docker infrastructure project that sets up a fully functional WordPress website with NGINX, MariaDB, and additional services, all orchestrated using Docker Compose.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Services](#services)
  - [Mandatory Services](#mandatory-services)
  - [Bonus Services](#bonus-services)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Makefile Commands](#makefile-commands)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## Overview

Inception is a system administration and DevOps project that involves setting up a small infrastructure composed of different services using Docker containers. Each service runs in its own dedicated container, and all containers are built from Debian 11 (with the exception of some bonus services).

The project demonstrates knowledge of:
- Docker and Docker Compose
- Container orchestration
- Web server configuration (NGINX with TLS)
- Database management (MariaDB)
- Content Management Systems (WordPress)
- Networking between containers
- Volume management and data persistence

## Architecture

The infrastructure consists of multiple Docker containers connected through a custom bridge network:

```
                                    ┌─────────────────┐
                                    │   Client/User   │
                                    └────────┬────────┘
                                             │
                         ┌───────────────────┼───────────────────┐
                         │                   │                   │
                    Port 443             Port 80           Port 3001
                    (HTTPS)              (HTTP)          (Monitoring)
                         │                   │                   │
                    ┌────▼────┐         ┌────▼────┐       ┌─────▼──────┐
                    │  NGINX  │         │ Static  │       │  Uptime    │
                    │   TLS   │         │  Page   │       │   Kuma     │
                    └────┬────┘         └─────────┘       └────────────┘
                         │
                         │
                    ┌────▼─────┐
                    │WordPress │◄────────┐
                    │ PHP-FPM  │         │
                    └────┬─────┘         │
                         │               │
                  ┌──────┴──────┐   ┌────▼────┐
                  │             │   │   FTP   │
             ┌────▼────┐   ┌────▼───▼───┐     │
             │ MariaDB │   │   Redis    │     │
             │Database │   │   Cache    │     │
             └─────────┘   └────────────┘     │
                  │                            │
             ┌────▼─────┐                     │
             │ Adminer  │◄────────────────────┘
             │  (DB UI) │
             └──────────┘
```

All services are connected through a custom Docker bridge network (`mynetwork`) for secure inter-container communication.

## Services

### Mandatory Services

#### NGINX
- **Purpose**: Web server and reverse proxy
- **Port**: 443 (HTTPS)
- **Features**:
  - TLSv1.2 or TLSv1.3 configuration
  - Self-signed SSL certificate
  - Reverse proxy to WordPress
- **Base Image**: Debian 11

#### WordPress
- **Purpose**: Content Management System
- **Port**: 9000 (FastCGI)
- **Features**:
  - PHP-FPM 7.4
  - WP-CLI for WordPress installation and configuration
  - Automatic setup with admin and regular user
- **Base Image**: Debian 11

#### MariaDB
- **Purpose**: Database management system
- **Port**: 3306
- **Features**:
  - Database persistence through volumes
  - Automatic database and user creation
  - Secure configuration
- **Base Image**: Debian 11

### Bonus Services

#### Redis
- **Purpose**: Object caching for WordPress
- **Port**: 6379
- **Features**:
  - Improves WordPress performance
  - Data persistence
- **Base Image**: Debian 11

#### Adminer
- **Purpose**: Database management interface
- **Port**: 8080
- **Features**:
  - Web-based database administration
  - Direct connection to MariaDB
- **Base Image**: Debian 11

#### Static Webpage
- **Purpose**: Static website service
- **Port**: 80
- **Features**:
  - Serves static content
  - Independent from WordPress
- **Base Image**: Debian 11

#### Uptime Kuma
- **Purpose**: Monitoring and uptime tracking
- **Port**: 3001
- **Features**:
  - Service monitoring
  - Status page
- **Base Image**: Alpine/Node.js

#### FTP Server
- **Purpose**: File transfer protocol server
- **Ports**: 21 (control), 21100-21110 (passive mode)
- **Features**:
  - Access to WordPress volume
  - Secure FTP connection
- **Base Image**: Debian 11

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- **Docker**: Version 20.10 or higher
- **Docker Compose**: Version 1.29 or higher
- **Make**: GNU Make utility
- **Git**: For cloning the repository
- **Operating System**: Linux (recommended) or macOS

### System Requirements

- Minimum 2GB RAM
- 10GB free disk space
- Root or sudo privileges for Docker operations

## Installation

1. Clone the repository:
```bash
git clone https://github.com/Elmountahiii/Inception.git
cd Inception
```

2. Create the required data directories:
```bash
sudo mkdir -p /home/yel-moun/data/mariadb
sudo mkdir -p /home/yel-moun/data/wordpress
sudo mkdir -p /home/yel-moun/data/redis
```

Note: You may need to modify the volume paths in `srcs/docker-compose.yml` to match your system's directory structure.

3. Create the environment file:
```bash
cp srcs/.env.example srcs/.env
```

## Configuration

Edit the `srcs/.env` file with your configuration:

```env
# Database Configuration
DATABASE_NAME=wordpress_db
DATABASE_USER=wp_user
DATABASE_PASSWORD=secure_password
ROOT_PASSWORD=root_password

# Domain Configuration
DOMAIN_NAME=yel-moun.42.fr

# WordPress Admin Configuration
ADMIN_USER=admin
ADMIN_PASSWORD=admin_password
ADMIN_EMAIL=admin@example.com

# WordPress User Configuration
USER_NAME=user
USER_EMAIL=user@example.com
USER_PASSWORD=user_password

# WordPress Configuration
WORDPRESS_TITLE=My Inception Site

# FTP Configuration
FTP_USER=ftp_user
FTP_PASSWORD=ftp_password
```

**Important**: 
- Replace all passwords with strong, unique values
- Update the domain name to match your setup
- Never commit the `.env` file to version control

## Usage

The project includes a Makefile with several commands for easy management:

### Starting the Infrastructure

Build and start all services:
```bash
make all
```

This command will:
- Check for the existence of the `.env` file
- Build all Docker images
- Start all containers in detached mode

### Managing Services

Start existing containers without rebuilding:
```bash
make up
```

Stop all running containers:
```bash
make down
```

### Accessing Services

Once all containers are running, you can access:

- **WordPress Site**: https://yel-moun.42.fr (or your configured domain)
- **Adminer**: http://localhost:8080
- **Static Page**: http://localhost:80
- **Uptime Kuma**: http://localhost:3001
- **FTP Server**: ftp://localhost:21

Note: You may need to add your domain to `/etc/hosts`:
```bash
echo "127.0.0.1 yel-moun.42.fr" | sudo tee -a /etc/hosts
```

### Cleaning Up

Remove all containers, images, volumes, and networks:
```bash
make clean
```

**Warning**: This command will delete all Docker containers, images, volumes, and custom networks on your system. Use with caution.

## Project Structure

```
Inception/
├── Makefile                           # Build and management commands
├── README.md                          # Project documentation
└── srcs/
    ├── .env                          # Environment variables (not in repo)
    ├── docker-compose.yml            # Container orchestration config
    └── requirements/
        ├── mariadb/
        │   ├── Dockerfile
        │   └── conf/
        │       ├── 50-server.cnf
        │       └── entrypoint.sh
        ├── nginx/
        │   ├── Dockerfile
        │   └── conf/
        │       └── nginx.conf
        ├── wordpress/
        │   ├── Dockerfile
        │   └── conf/
        │       ├── www.conf
        │       └── entrypoint.sh
        └── bonus/
            ├── adminer/
            │   └── Dockerfile
            ├── ftp/
            │   ├── Dockerfile
            │   └── conf/
            ├── redis/
            │   └── Dockerfile
            ├── static/
            │   └── Dockerfile
            └── uptimekuma/
                └── Dockerfile
```

## Makefile Commands

| Command | Description |
|---------|-------------|
| `make all` | Build and start all containers |
| `make up` | Start all containers without rebuilding |
| `make down` | Stop and remove all containers |
| `make clean` | Remove all containers, images, volumes, and networks |

## Troubleshooting

### Common Issues

#### Port Already in Use
If you encounter port binding errors:
```bash
# Check what's using the port
sudo lsof -i :443
sudo lsof -i :3306

# Stop the conflicting service or change the port mapping in docker-compose.yml
```

#### Permission Denied on Volumes
If containers cannot write to volumes:
```bash
# Fix directory permissions
sudo chown -R $USER:$USER /home/yel-moun/data
sudo chmod -R 755 /home/yel-moun/data
```

#### Container Fails to Start
Check container logs:
```bash
docker logs mariadb
docker logs wordpress
docker logs nginx
```

#### .env File Not Found
Ensure the `.env` file exists in the `srcs/` directory:
```bash
ls -la srcs/.env
```

#### DNS Resolution Issues
Add the domain to your hosts file:
```bash
echo "127.0.0.1 yel-moun.42.fr" | sudo tee -a /etc/hosts
```

#### WordPress Installation Issues
If WordPress fails to install:
1. Check MariaDB is running: `docker ps | grep mariadb`
2. Verify database credentials in `.env`
3. Check WordPress container logs: `docker logs wordpress`

### Useful Docker Commands

View all running containers:
```bash
docker ps
```

View all containers (including stopped):
```bash
docker ps -a
```

Execute command in a container:
```bash
docker exec -it <container_name> bash
```

View container logs:
```bash
docker logs <container_name>
```

Inspect a container:
```bash
docker inspect <container_name>
```

## License

This project is part of the 42 School curriculum. Please respect academic integrity policies when using this code.
