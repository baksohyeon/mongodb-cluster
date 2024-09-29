   #!/bin/bash

   echo "Waiting for MongoDB to start..."
   sleep 5

   echo "Initializing replica set..."
   mongosh --host localhost:27017 --eval '
   rs.initiate({
     _id: "myReplicaSet",
     members: [
       {_id: 0, host: "mongo1:27017", priority: 1},
     ]
   })
   '

   echo "Waiting for replica set to initialize..."
   sleep 10

   echo "Creating admin user..."
   mongosh --host localhost:27017 --eval '
   use admin
   db.createUser({
     user: "root",
     pwd: "example",
     roles: ["root"]
   })
   '

echo "Setup completed."
# docker-compose down -v && docker-compose up -d --wait
# DB_CONN = "mongodb://localhost:27017/?replicaSet=rs0&directConnection=true"