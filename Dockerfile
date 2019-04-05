FROM hellobtfworld/phpnginx11

# nginx配置
ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/default.conf /etc/nginx/conf.d/default.conf
ADD nginx/blacklist.conf /etc/nginx/blacklist.conf

ADD run.sh /usr/local/bin/run

EXPOSE 80

STOPSIGNAL SIGTERM

RUN chmod +x /usr/local/bin/run

ENTRYPOINT ["/usr/local/bin/run"]
CMD  nginx -g 'daemon off;'
