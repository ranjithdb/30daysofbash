#### to run the script:
```
./port-scanner.sh host start-port end-port
```

#### to gain more information about the ports
```
sudo lsof -i :port
```
or
```
netstat -tuln | grep :port
```
or
```
sudo ss -tuln | grep :port
```

