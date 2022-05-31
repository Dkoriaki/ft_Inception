COMPOSE_FILE	=	./srcs/docker-compose.yml

HOST_PRESENT	=	$(shell cat /etc/hosts | grep dkoriaki.42.fr > /dev/null; echo $$)

all:
ifneq ($(HOST_PRESENT),0)
	@sudo sed -i 's/127.0.0.1	localhost/127.0.0.1	 dkoriaki.42.fr/g' /etc/hosts
endif
	@mkdir -p /home/dkoriaki/data/wordpress_data
	@mkdir -p /home/dkoriaki/data/mariadb_data
	docker-compose -f ${COMPOSE_FILE} build
up:
	docker-compose -f ${COMPOSE_FILE}  up -d

build:
	docker-compose -f ${COMPOSE_FILE} build

down:
	docker-compose -f ${COMPOSE_FILE} down

clean:
	docker-compose -f ${COMPOSE_FILE} down
	@sudo rm -rf /home/dkoriaki/data/wordpress_data
	@sudo rm -rf /home/dkoriaki/data/mariadb_data

fclean: clean
	docker system prune --all --volumes --force

re: fclean all

.PHONY : all up build down clean fclean re
