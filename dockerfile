FROM hellobtfworld/phpnginx11

# nginx配置
ADD _deploy/Docker/nginx/nginx.conf /etc/nginx/nginx.conf
ADD _deploy/Docker/nginx/default.conf /etc/nginx/conf.d/default.conf
ADD _deploy/Docker/nginx/blacklist.conf /etc/nginx/blacklist.conf

ADD _deploy/Docker/nginx.sh /usr/local/bin/run

EXPOSE 80

STOPSIGNAL SIGTERM

ENTRYPOINT ["/usr/local/bin/run"]
CMD  nginx -g 'daemon off;'
