# Generate Load for BookInfo app

1. Open the file `01-create-load.sh`

2. Update the bookinfo app url `http://1.2.3.4` with the actual bookinfo app url of yours.

3. Make sure that `apache bench` is installed.

    https://httpd.apache.org/docs/2.4/programs/ab.html

4. Run the load script file 

```
sh 01-create-load.sh
```

5. This load script runs for 5 to 15 minutes.
