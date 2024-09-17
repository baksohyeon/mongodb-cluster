#!/bin/bash

docker exec -it mongo1 mongosh --eval '
rs.initiate({
  _id: "rs0",
  members: [
    {_id: 0, host: "mongo1"},
    {_id: 1, host: "mongo2"},
    {_id: 2, host: "mongo3"}
  ]
})
'
sleep 10

# 관리자 계정 생성
docker exec -it mongo1 mongosh --eval '
use admin
db.createUser({
  user: "root",
  pwd: "example",
  roles: ["root"]
})
'