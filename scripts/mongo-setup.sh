   #!/bin/bash

   echo "Waiting for MongoDB to start..."
   sleep 30

   echo "Initializing replica set..."
   mongosh --host localhost:27017 --eval '
   rs.initiate({
     _id: "myReplicaSet",
     members: [
       {_id: 0, host: "mongo1:27017", priority: 2},
       {_id: 1, host: "mongo2:27017", priority: 0},
       {_id: 2, host: "mongo3:27017", priority: 0}
     ]
   })
   '

   echo "Waiting for replica set to initialize..."
   sleep 30

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