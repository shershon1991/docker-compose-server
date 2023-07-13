docker-compose stop dsp mysql redis rabbitmq &&
  docker-compose rm -f dsp mysql redis rabbitmq &&
#  docker-compose build dsp mysql redis rabbitmq &&
  docker-compose up -d dsp mysql redis rabbitmq