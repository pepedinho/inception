all : up 

up :
	mkdir -p ~/itahri/data/mariadb
	mkdir -p ~/itahri/data/wordpress
	docker compose -f srcs/docker-compose.yml up --build

down : 
	docker compose -f srcs/docker-compose.yml down

delete :
	sudo rm -rf ~/itahri/data/*

clean :
	docker container rm -f mariadb
	docker container rm -f wordpress
	docker container rm -f nginx
	docker system prune -af

fclean: delete clean

log :
	docker compose -f srcs logs

re : clean all
