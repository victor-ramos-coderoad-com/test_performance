#!/bin/bash
# create data0___ale with 16 partitions
docker-compose -f vizix-tools.yml run vizix-tools kafkatopictool -z 10.0.148.249 -c
docker-compose exec kafka bash ./opt/kafka/bin/kafka-topics.sh --delete --force --zookeeper 10.0.148.249:2181 --topic ___v1___data0___ale
sleep 10s
docker-compose -f vizix-tools.yml run vizix-tools kafkatopictool -z 10.0.148.249 -c  -tc data -p 16
sleep 10s
#  create data partitions
docker-compose exec kafka bash ./opt/kafka/bin/kafka-topics.sh --delete --force --zookeeper 10.0.148.249:2181 --topic ___v1___data1
docker-compose exec kafka bash ./opt/kafka/bin/kafka-topics.sh --delete --force --zookeeper 10.0.148.249:2181 --topic ___v1___data2
docker-compose exec kafka bash ./opt/kafka/bin/kafka-topics.sh --delete --force --zookeeper 10.0.148.249:2181 --topic ___v1___cache___things
docker-compose exec kafka bash ./opt/kafka/bin/kafka-topics.sh --delete --force --zookeeper 10.0.148.249:2181 --topic ___v1___cache___configThings
sleep 10s
docker-compose restart kafka
sleep 10s
docker-compose -f vizix-tools.yml run vizix-tools kafkatopictool -z 10.0.148.249 -c  -tc data -p 1024
sleep 5s
# load cache and siteconfig
docker-compose exec kafka bash ./opt/kafka/bin/kafka-topics.sh --create --zookeeper 10.0.148.249:2181 --replication-factor 1 --partitions 64 --topic ___v1___logs
sleep 10
docker-compose -f vizix-tools.yml run vizix-tools cacheloadertool 
sleep 30s
docker-compose -f vizix-tools.yml run vizix-tools siteconfig
