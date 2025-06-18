Utilize o comando abaixo para consultar informações sobre as credenciais configuradas para acesso a AWS através do CLI:

aws sts get-caller-identity

Após a criação do EKS executar o comando abaixo para atualizar o kubeconfig adicionando o cluster recém criado:

aws eks update-kubeconfig --region us-east-1 --name devops-na-nuvem-week-eks-cluster

Para conseguir realizar o acesso ao cluster precisei fazer a atualização do kubectl, aws cli e do aws-iam-authenticator.

Passos para realizar o build da imagem:

docker build -f Dockerfile -t arn:ecr:repo/backend:v1.0 .

docker build -f Dockerfile -t arn:ecr:repo/frontend:v1.0 .

docker image ls

Até esse ponto a imagem está criada. Agora basta ir lá no repositório, clicar no botão "View Push Commands" e seguir os passos para subir a imagem para o ECR.


Segue comando para gerar um yml (imperativo para declarativo) da criação de um deployment:

kubectl create deploy frontend --image address-image-repo-ecr:tag --replicas 1 --dry-run=client -o yaml

Uma boa prática para realizar o versionamento das imagens é o kustomize.

HPA --> Nativamente olha para CPU e memória e escala os pods baseado nessas métricas.

O HPA é um recurso nativo do k8s, porém é necessário a instalação do Metrics Server para que as métricas possam ser metrificadas.

Instalação é feita a partir do comando abaixo:

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

Segue documentação para aprofundar:

https://repost.aws/knowledge-center/eks-metrics-server-pod-autoscaler

Após instalação do metrics server pode-se utilizar o comando abaixo para verificar o consumo de recurso dos pods:

kubectl top pods

OBS:. Caso queira escalar os pods baseado em outras métricas é necessário utilizar o Keda.

OBS2:. Para escalar os nodes no EKS é necessário fazer o uso do karpenter.


==> QOS

Sempre importante trabalhar com uma definição de limits para o seu pod, pois quando não é definido nada (best-effort), os pods que estão dentro dessa classificação de QOS são os primeios a serem mortos pelo k8s em um cenário de evicted.

Aula 01:

Criação da VPC, subnets, route-tables, IG, NAT e EKS via terraform.

Aula 02:

Criando os repositórios, fazendo build das imagens e subindo para os repos criados.Trabalhando com o Kustomize para a gerência dos múltiplos arquivos yml. Rodando a aplicação no cluster e definindo um QOS para ela. Realizando testes de HPA nos pods.

    ==> Instalação do Metrics Server:
        * kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
        * Teste de carga para validar a configuração de HPA. Validar tb o downscaler.


Aula 03:

Antes de iniciar realizar a instalação do Ansible, do eksctl e do helm.

Trabalhando com OIDC. Autenticar e liberar permissões baseadas em roles para as aplicações (entidades externas) que rodam no EKS (para o nosso caso de estudo).
    - Pegar OIDC URL no EKS
    - Criar identity provider no IAM




Ideias:

    * Configurar HPA nos pods que estão com constantes alertas de memória / CPU

