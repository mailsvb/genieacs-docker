A Docker container running instances of genieacs cwmp, genieacs api, genieacs ui and coturn (STUN server)

## Requirements
*  docker
*  docker-compose

## Configuration
Some additional configuration options to pass in as environment variable can be found here: [https://github.com/genieacs/genieacs/blob/master/lib/config.ts](https://github.com/genieacs/genieacs/blob/master/lib/config.ts)

Commands available in the configuration files of the admin UI can be found here: [https://github.com/genieacs/genieacs/blob/master/docs/provisions.rst](https://github.com/genieacs/genieacs/blob/master/docs/provisions.rst)

## Installation instructions

You can replace the default certificates by mounting a directory into the genieacs container. Add another volume entry to the docker-compose file.
`- /cert/folder/:/opt/genieacs/certs/`

The local cert/folder must contain 2 files
* `server.crt` - The certificate file
* `server.pem` - The private key file

###### build and start the containers
`docker-compose up -d`

###### stop the running containers
`docker-compose stop`

###### start the stopped containers
`docker-compose start`

###### remove all containers/volumes/images
`docker-compose down --rmi all --volumes`
