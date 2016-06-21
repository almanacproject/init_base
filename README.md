This image is the base for all the initialisation docker containers.

#How to use this image?

You can use the this image by copying your initialization script 

    FROM almanacproject/init_base
    COPY init_script ./
    RUN chmod +x ./init_script
    CMD ["./init_script"]

##What is in the init script?

Inside the init script you can crate everything you need to your service to function properly, but can not be include inside the container image.

For example 

- certificates
- passwords
- deployment depending configurations


The init script could look something like this shell script.

    #!/bin/sh

    set -e

    mkdir -p -- /opt/volumes/service/
    cd /opt/volumes/service

    printf "Init Certificates and passwords.\n"
    passwords="$(psst /opt/input/config.json)"
    certs="$(bob /opt/input/config.json)"
    printf '{"psst": %s, "bob": %s}\n' "$passwords" "$certs" > ./init.json

    printf "Create config file.\n"
    rework /opt/input/service/config.yml.template < ./init.json > ./config.yml

This example creates the certificate, the truststore, and passwords for this fictive service with the utilities `bob` and `psst`.
The certificate and the trust store will be saved in `/opt/volumes/service`.
To use psst and `bob` you have to create a configuration file, which in the example here is called `config.json` under the volume `/opt/input`.

In addition you can use the utility `rework` to create a new configuration file out of an template file.

`rework`, `bob`, and `psst` are include in this image.
Further documentation can be found under

- [rework](https://github.com/almanacproject/rework)
- [psst](https://github.com/almanacproject/psst)
- [bob](https://github.com/almanacproject/bob_cert_builder)
