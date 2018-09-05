docker rm -f proxy-test
docker build -t nginx-openvpn-proxy-client .
docker run -p 8400:80 --cap-add=NET_ADMIN --device=/dev/net/tun -v /Applications/XAMPP/xamppfiles/htdocs/bbgit/etec/docker-nginx-openvpn/ignore/openvpn:/etc/openvpn -v /Applications/XAMPP/xamppfiles/htdocs/bbgit/etec/docker-nginx-openvpn/ignore/nginxconf/conf.d:/etc/nginx/conf.d --name=proxy-test nginx-openvpn-proxy-client
#docker run -d -t -i -p 8400:80 -v /Applications/XAMPP/xamppfiles/htdocs/bbgit/etec/docker-nginx-openvpn/ignore/nginxconf/conf.d:/etc/nginx/conf.d --name=proxy-test nginx-openvpn-proxy-client /bin/bash
#docker run -d -t -i -p 8400:80 --name=proxy-test nginx-openvpn-proxy-client /bin/bash
docker ps -a