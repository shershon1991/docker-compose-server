docker-compose stop workspace nginx mysql php-fpm redis &&
  #docker-compose rm -f workspace nginx mysql php-fpm redis &&
  #docker-compose build workspace nginx mysql php-fpm redis &&
  docker-compose up -d nginx mysql redis
