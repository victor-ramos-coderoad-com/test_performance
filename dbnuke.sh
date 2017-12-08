#!/bin/bash
# mongo dbnuke
docker-compose exec mongo mongo localhost/admin -u admin -p control123! --eval "db=db.getSiblingDB('riot_main');db.getCollection('things').remove({});db.getCollection('thingSnapshotIds').remove({});db.getCollection('thingSnapshots').remove({});db.getCollection('timeseries').remove({});db.getCollection('timeseriesControl').remove({});db.getCollection('exit_report').remove({});db.repairDatabase()"

# mysql dbnuke
docker-compose exec mysql mysql -uroot -pcontrol123! riot_main -e "SET FOREIGN_KEY_CHECKS = 0; TRUNCATE VIZ_IOT_THING; TRUNCATE VIZ_IOT_THINGIMAGE; TRUNCATE VIZ_IOT_THINGPARENTHISTORY; SET FOREIGN_KEY_CHECKS = 1;" 

