all:
	@if [ ! -f srcs/.env ]; then \
		echo "Error: srcs/.env file not found!"; \
		echo "Please create the .env file in the srcs directory before running docker-compose"; \
        exit 1; \
    fi
	cd srcs && docker-compose up -d

clean:
	@if [ -n "$$(docker ps -qa)" ]; then docker stop $$(docker ps -qa); fi
	@if [ -n "$$(docker ps -qa)" ]; then docker rm $$(docker ps -qa); fi
	@if [ -n "$$(docker images -qa)" ]; then docker rmi -f $$(docker images -qa); fi
	@if [ -n "$$(docker volume ls -q)" ]; then docker volume rm $$(docker volume ls -q); fi
	@if [ -n "$$(docker network ls -q | grep -v 'bridge\|host\|none')" ]; then docker network rm $$(docker network ls -q | grep -v 'bridge\|host\|none'); fi