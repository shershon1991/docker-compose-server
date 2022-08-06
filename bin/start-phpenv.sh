docker-compose stop workspace nginx mysql php-fpm redis elasticsearch &&
  #docker-compose rm -f workspace nginx mysql php-fpm redis &&
  #docker-compose build workspace nginx mysql php-fpm redis &&
  docker-compose up -d workspace nginx mysql php-fpm redis elasticsearch
