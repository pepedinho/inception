MAGENTA = \033[35m
RESET = \033[0m

BLEU_CLAIR = \033[36m 
BLEU_FONCE = \033[34m

all : up

up : dock
	
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
	docker volume rm srcs_mariadb srcs_wordpress

log :
	docker compose -f srcs logs

re : clean all

dock: 
	@echo "$(BLEU_CLAIR)⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀$(RESET)"
	@echo "$(BLEU_CLAIR)⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀$(RESET)"
	@echo "$(BLEU_CLAIR)⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠛⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀$(RESET)"
	@echo "$(BLEU_CLAIR)⠀⠀⠀⠀⠀⠀⢰⣶⣶⣶⠀⣶⣶⣶⣶⠀⢰⣶⣶⣶⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀$(RESET)"
	@echo "$(BLEU_CLAIR)⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⠀⣿⣿⣿⣿⠀⢸⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀$(RESET)"
	@echo -n "$(BLEU_CLAIR)⠀⢠⣤⣤⣤⠀⢠⣤⣤⣤⠀⣤⣤⣤⣤⠀⢠⣤⣤⣤⠀$(RESET)"
	@echo "$(BLEU_FONCE)⣰⣿⣿⣦⡀⠀⠀⠀$(RESET)"
	@echo -n "$(BLEU_CLAIR)⠀⢸⣿⣿⣿⠀⢸⣿⣿⣿⠀⣿⣿⣿⣿⠀⢸⣿⣿⣿⠀$(RESET)"
	@echo "$(BLEU_FONCE)⣿⣿⠹⣿⣷⣀ ⠀⠀ _                      _   _$(RESET)"
	@echo -n "$(BLEU_CLAIR)⠀⠘⠛⠛⠛⠀⠘⠛⠛⠛⠀⠛⠛⠛⠛⠀⠘⠛⠛⠛$(RESET)"
	@echo "$(BLEU_FONCE)⢀⣿⣿⡀⠙⠿⠿⣿⣶⣆(_)                    | | (_)$(RESET)"
	@echo "$(BLEU_FONCE)⣴⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣿⣿⣿⠟⢁⣤⣴⣶⣾⡿⠋  _ _ __   ___ ___ _ __ | |_ _  ___  _ __$(RESET)"
	@echo "$(BLEU_FONCE)⣿⣿⣿⣛⣛⣛⣛⣿⣟⣛⣛⣻⣿⣟⣛⣛⣻⣿⣟⣋⣉⣠⣤⣾⣿⣟⣻⣍⠀⠀ | | '_ \ / __/ _ \ '_ \| __| |/ _ \| '_ \\ $(RESET)"
	@echo "$(BLEU_FONCE)⢹⣿⣿⣀⣀⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⠋⠀⠀⠀⠀⠀ | | | | | (_|  __/ |_) | |_| | (_) | | | |$(RESET)"
	@echo "$(BLEU_FONCE)⠈⢻⣿⣿⣿⡿⠿⠿⠿⠛⠉⠀⠀⠀⠀⠀⢀⣠⣴⣿⣿⣿⠟⠁       |_|_| |_|\___\___| .__/ \__|_|\___/|_| |_|⠀⠀⠀⠀⠀⠀$(RESET)"
	@echo "$(BLEU_FONCE)⠀⠀⠙⢿⣿⣿⣶⣦⣤⣤⣤⣤⣤⣴⣶⣿⣿⣿⣿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀                  | |$(RESET)"
	@echo "$(BLEU_FONCE)⠀⠀⠀⠀⠈⠙⠛⠛⠿⠿⠿⠿⠿⠛⠛⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                  |_|$(RESET)"
	@echo "$(BLEU_FONCE)$(RESET)"


.PHONY: all up ectoplasma down delete clean fclean log re
