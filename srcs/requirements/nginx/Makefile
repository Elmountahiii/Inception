IMAGE_NAME = nginx
CONTAINER_NAME = nginx

build:
	docker build -t $(IMAGE_NAME) .

run:
	docker run --name "$(CONTAINER_NAME)" -d -p 443:443 "$(IMAGE_NAME)"

shell:
	docker exec -it $(CONTAINER_NAME) bash

stop:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true

restart: stop build run

clean:
	docker rmi $(IMAGE_NAME) || true