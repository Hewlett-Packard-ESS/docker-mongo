![MongoDB](/mongodb.jpeg?raw=true "MongoDB")

Builds on the hpess/chef image by installing MongoDB, currently version 3.0.0.

Bit of an empty readme at the moment, as we don't really configure much.  Spin up a simple instance with a docker-compose file like this:
```
mongodb:
  image: hpess/mongodb
  ports:
    - "27017:27017"
    - "28017:28017"
```
## License
This docker application is distributed unter the MIT License (MIT).

MongoDB itself is licenced under the [GNU AGPL v3.0](http://www.gnu.org/licenses/agpl-3.0.html) License.
