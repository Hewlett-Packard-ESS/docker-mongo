![MongoDB](/mongodb.jpeg?raw=true "MongoDB")

Builds on the hpess/chef image by installing MongoDB, currently version 3.0.1.  With simple replica set support.

## Use
As per all our other containers, a simple docker compose file will get you up a single instance nice and easy.  This will start a container bound to the default mongo ports.
```
mongodb1:
  image: hpess/mongodb
  environment:
    - noprealloc=true
    - smallfiles=true
  ports:
    - "27017:27017"
    - "28017:28017"
```
## Performance Tweaks
The container will automatically try to apply some of the MongoDB best practices at boot such as transparent_hugepage disabled and defrag off.  This will only work if you run the container with `--privileged`.  The choice is yours, running without this flag won't crash the container, it'll just output warnings during boot that it was unable to set them.

## ReplicaSets
Simple replica sets are suported out of the box with a couple of environment variables.  The example below will create a replica set on your host.  Notice that i'm binding to different ports, this is a winky way of getting around the circular dependencies issue in docker at the moment (we can't link containers to eachother), so instead for the purposes of this example I've bound each mongo instance to 0.0.0.0 on a different port and then I'm interacting via the docker interface, rather than the /etc/host entry which gets created with links.

__NOTE__: It's important to note that the "master" as defined in the config below by the `replMembers` environment variable will not complete it's boot until it's sucessfully added all members to the set.  It will continually retry until it has done so.

ReplicaSets are only built the first time round when things aren't initiated, after that - it's on you.
```
mongodb1:
  image: hpess/mongodb
  restart: 'always'
  environment:
    - replSet=rs1
    - fqdn=172.17.42.1
    - replMembers=172.17.42.1:27018,172.17.42.1:27019
  ports:
    - "27017:27017"
    - "28017:28017"

mongodb2:
  image: hpess/mongodb
  restart: 'always'
  environment:  
    - replSet=rs1
  ports:
    - "27018:27017"

mongodb3:
  image: hpess/mongodb
  restart: 'always'
  environment:
    - replSet=rs1
  ports:
    - "27019:27017"
```

## License
This docker application is distributed unter the MIT License (MIT).

MongoDB itself is licenced under the [GNU AGPL v3.0](http://www.gnu.org/licenses/agpl-3.0.html) License.
