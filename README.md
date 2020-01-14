

add `export OPENFAAS_URL="http://127.0.0.1:31112"` to your `bash file`

# Required software:

The following Tutorial was prepared using macos:

1- GOLANG + make sure you run this in the `$GOPATH/src`

2- `docker`

  2.1 - open `docker app` and allow `Kubernetes`

# installation:

run `install.sh`

after the installation process is done follow these steps:

1- `PASSWORD=$(kubectl -n openfaas get secret basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode)`


2- `echo -n $PASSWORD | faas-cli login -g http://127.0.0.1:31112 -u admin --password-stdin`


3- `docker login`

4- `kubectl port-forward -n openfaas svc/gateway 31112:8080 &`

5- 
```
helm template faas-netes/chart/openfaas \
    --namespace openfaas  \
    --set basic_auth=true \
    --set functionNamespace=openfaas-fn > openfaas.yaml
```


6- `kubectl apply -f faas-netes/namespaces.yml && kubectl apply -f openfaas.yaml`


7- `cd firstfunction`


8- Change the docker image to contain a proper name && then change the port to port to 3321


9- `faas-cli up -f firstfunction.yml`

10- install `go get -u github.com/golang/dep/cmd/dep`

11- manage dependencies by `cd firstfunction && dep init && dep ensure` 