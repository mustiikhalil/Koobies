curl -sLSf https://cli.openfaas.com | sudo sh

curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash

kubectl -n kube-system create sa tiller \
  && kubectl create clusterrolebinding tiller \
  --clusterrole cluster-admin \
  --serviceaccount=kube-system:tiller

helm init --upgrade --service-account tiller

kubectl apply -f https://raw.githubusercontent.com/openfaas/faas-netes/master/namespaces.yml

helm repo add openfaas https://openfaas.github.io/faas-netes/
git clone https://github.com/openfaas/faas-netes.git

helm repo update \
 && helm upgrade openfaas --install openfaas/openfaas \
    --namespace openfaas  \
    --set functionNamespace=openfaas-fn \
    --set generateBasicAuth=true 

export HELM_HOST=127.0.0.1

kubectl -n openfaas get deployments -l "release=openfaas, app=openfaas"
kubectl rollout status -n openfaas deploy/gateway

mkdir firstfunction
cd firstfunction
faas template pull https://github.com/openfaas-incubator/golang-http-template && faas new --lang golang-middleware firstfunction
cd ..