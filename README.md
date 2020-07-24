Binarios inclusos:

wget https://get.helm.sh/helm-v3.1.0-linux-amd64.tar.gz
tar zxfv helm-v3.1.0-linux-amd64.tar.gz
cp linux-amd64/helm .


Ativar API

-Compute Engine
-Cloud Build
-Cloud Pub/Sub
-Kubernetes Engine API
-GKE Connect API
-Cloud Source Repositories
-Identity and Access Management (IAM) API

Criar conta de serviço "terraform"

IAM na conta de serviço do terraform
    projeto - proprietário
    cloud storage - administrador

Gerar credenciais .json e incluir na chamada provider “google” do terraform


Instalar kubectl no usuário da máquina local: apt-get install kubectl

gcloud auth login
gcloud config set project my-project

Ajustear antes de rodar terraform apply

- helm.sh
    project id
    email

- start-spinnaker.sh
    project id
    email