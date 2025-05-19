all:
	@if [ ! -f srcs/.env ]; then \
        echo "Error: srcs/.env file not found!"; \
        echo "Please create the .env file in the srcs directory before running docker-compose"; \
        exit 1; \
    fi
	cd srcs && docker-compose up -d --build

down:
	@echo "Stopping and removing containers..."
	cd srcs && docker-compose down

up:
	@echo "Stopping and removing containers..."
	cd srcs && docker-compose up -d

clean:
	@echo "Stopping all running containers..."
	@if [ -n "$$(docker ps -qa)" ]; then docker stop $$(docker ps -qa); fi
	@echo "Removing all containers..."
	@if [ -n "$$(docker ps -qa)" ]; then docker rm $$(docker ps -qa); fi
	@echo "Removing all images..."
	@if [ -n "$$(docker images -qa)" ]; then docker rmi -f $$(docker images -qa); fi
	@echo "Removing all volumes..."
	@if [ -n "$$(docker volume ls -q)" ]; then docker volume rm $$(docker volume ls -q); fi
	@echo "Removing all custom networks..."
	@if [ -n "$$(docker network ls -q | grep -v 'bridge\|host\|none')" ]; then docker network rm $$(docker network ls -q | grep -v 'bridge\|host\|none'); fi
	@echo "Cleanup complete!"