# pg_prove Docker image
This is a self-contained docker image containing pieces needed to run [pgTAP](https://pgtap.org/) tests with pg_prove.

## Usage

First, lets pull the image from Docker Hub:

```bash
[~/git/pg_prove]$ docker pull horrendo/pg_prove
Using default tag: latest
latest: Pulling from horrendo/pg_prove
1eae7a7426b0: Already exists 
ae082df5a7e1: Pull complete 
295ef20a7710: Pull complete 
Digest: sha256:000bc7c42fc478a1d3dbf14a17c7b1963e8559cf49e8c6d29c2b0f0e12c38029
Status: Downloaded newer image for horrendo/pg_prove:latest
```

Now we'll tag it as just `pg_prove` to save keystrokes when we run:

```bash
[~/git/pg_prove]$ docker tag horrendo/pg_prove pg_prove
[~/git/pg_prove]$ docker images | grep pg_prove
horrendo/pg_prove  latest  5f2a913451dc   19 hours ago   49.7MB
pg_prove           latest  5f2a913451dc   19 hours ago   49.7MB
```

We'll create a file of environment variables (we could specify them on the `docker run` command line but this is easier):

```
[~/git/pg_prove]$ cat env.dat
PGHOST=192.168.101.144
PGDATABASE=bcaas
PGUSER=bcaas_owner
PGPASSWORD=xxx
```

Now run the image, mounting the current directory as /tmp (which is the working directory of the docker image):

```bash
[~/git/pg_prove]$ docker run -it --rm --env-file=env.dat -v `pwd`:/tmp pg_prove sh -c 'pg_prove *.sql'
dbobj.sql .. ok       
All tests successful.
Files=1, Tests=354,  1 wallclock secs ( 0.05 usr  0.02 sys +  0.01 cusr  0.01 csys =  0.09 CPU)
Result: PASS
```