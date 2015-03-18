![MongoDB](/mongodb.jpeg?raw=true "MongoDB")

Builds on the hpess/chef image by installing MongoDB, currently version 3.0.0.  With simple replica set support.

## Use
As per all our other containers, a simple docker compose file will get you up a single instance nice and easy:
```
mongodb1:
  hostname: 'mongodb1'
  image: hpess/mongodb
  environment:
    - noprealloc=true
    - smallfiles=true
  ports:
    - "27017:27017"
    - "28017:28017"
```

## ReplicaSets
Simple replica set support is in place, the following compose file gives you an example, the dodgy IP stuff is just working around the circular dependencies issue with docker at the moment which is on the radar to be resolved.

__NOTE__: It's important to note that the "master" as defined in the config below by the `replMembers` environment variable will not complete it's boot until it's sucessfully added all members to the set.  It will continually retry until it has done so.

ReplicaSets are only built the first time round when things aren't initiated, after that - it's on you.
```
mongodb1:
  hostname: 'mongodb1'
  image: hpess/mongodb
  environment:
    - DEBUG=true
    - noprealloc=true
    - smallfiles=true
    - replSet=rs1
    - replMembers=172.17.42.1:27018,172.17.42.1:27019
  ports:
    - "172.17.42.1:27017:27017"
    - "28017:28017"

mongodb2:
  hostname: 'mongodb2'
  image: hpess/mongodb
  environment:  
    - DEBUG=true
    - noprealloc=true
    - smallfiles=true
    - replSet=rs1
  ports:
    - "172.17.42.1:27018:27017"
  links:
    - "mongodb1:mongodb1"

mongodb3:
  hostname: 'mongodb3'
  image: hpess/mongodb
  environment:
    - DEBUG=true
    - noprealloc=true
    - smallfiles=true
    - replSet=rs1
  ports:
    - "172.17.42.1:27019:27017"
  links:
    - "mongodb1:mongodb1"
```

## License
This docker application is distributed unter the MIT License (MIT).

MongoDB itself is licenced under the [GNU AGPL v3.0](http://www.gnu.org/licenses/agpl-3.0.html) License.
