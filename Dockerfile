FROM alpine:latest

# install packages
#RUN apk add --no-cache bash openrc nginx openvpn
RUN apk add --no-cache bash nginx openvpn



#RUN mkdir -p /run/nginx
#RUN mkdir /var/www/error_page

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.vh.default.conf /etc/nginx/conf.d



VOLUME /etc/openvpn /etc/nginx/conf.d

ADD ./init.sh /usr/local/bin
RUN chmod a+x /usr/local/bin/*
ADD ./sample.ovpn /etc/openvpn/client.ovpn
RUN chmod a+x /etc/openvpn/client.ovpn
ADD ./index.html /var/www/localhost/htdocs/index.html
RUN chmod a+x /etc/openvpn/client.ovpn
RUN chmod 777 -R /var/www/localhost
RUN chown -R nginx:nginx /var/www
#RUN rc-update add nginx 
#RUN rc-update add openvpn

EXPOSE 80

CMD ./usr/local/bin/init.sh

