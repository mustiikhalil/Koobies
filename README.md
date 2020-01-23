

add `export OPENFAAS_URL="http://127.0.0.1:31112"` to your `bash/zsh file`

# Required software:

The following Tutorial was prepared using macos:

1- GOLANG + make sure you run this in the `$GOPATH/src`

2- `docker`

3- install miniKube

# installation:

- `docker login`

run `install-koobies.sh`

- minikube start

run `install.sh`

after the installation process is done follow these steps:

- `kubectl port-forward -n openfaas svc/gateway 31112:8080 &`

- `PASSWORD=$(kubectl -n openfaas get secret basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode)`

- `echo -n $PASSWORD | faas-cli login -g http://127.0.0.1:31112 -u admin --password-stdin`

- 
```
helm template faas-netes/chart/openfaas \
    --namespace openfaas  \
    --set basic_auth=true \
    --set functionNamespace=openfaas-fn > openfaas.yaml
```

- `kubectl apply -f faas-netes/namespaces.yml && kubectl apply -f openfaas.yaml`

- `cd firstfunction`

- Change the docker image to contain a proper name 
   - if there is a port error then change the port to port to 31112 and check if you already have the OPENFAAS_URL set
   - or rerun the command `kubectl port-forward -n openfaas svc/gateway 31112:8080 &`

- `faas-cli up -f firstfunction.yml`

- install `go get -u github.com/golang/dep/cmd/dep`

- manage dependencies by `cd firstfunction && dep init && dep ensure` 