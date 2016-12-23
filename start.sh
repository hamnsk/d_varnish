docker stop va41 && docker rm va41
docker build -t visman/d_varnish:5 .
docker run -d -ti -p 6082:6082 -p 6081:6081 -p 6085:6085 -v /docker/data/www/varnish-dashboard:/var/www/html/varnish-dashboard -v /docker/conf/varnish:/etc/varnish -v /etc/localtime:/etc/localtime --name=varnish visman/d_varnish:5

