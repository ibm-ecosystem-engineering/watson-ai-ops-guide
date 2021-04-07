#!/bin/sh

echo "create logs started ..... $(date)"

# #Start the error
# kubectl scale --replicas=0 deployment/ratings-v1 -n bookinfo

Call book info 
ab -n 200 -c 5 http://1.2.3.4:31010/productpage?u=normal 

echo "create logs completed ..... $(date)"

