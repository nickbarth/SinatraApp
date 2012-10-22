include conf/Makefile.conf

server:
	rm -rf public/assets/
	thin start -p $(PORT)

prod_start:
	cp $(CONFIG) /etc/nginx/conf.d/
	service nginx reload
	mkdir ./logs/ 2>/dev/null; true
	mkdir -p public/assets/javascripts/; true
	mkdir -p public/assets/stylesheets/; true
	rake assets:compile; true
	thin start -S $(SOCKET) -l ./logs/server.log -P ./logs/pid.log -e production -s 1

prod_stop:
	rm -rf logs/*

prod_restart: prod_stop prod_start

default: server
