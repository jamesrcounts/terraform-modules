default: plan

init:
	terraform init
	terraform -v 
	terraform providers

k8s_init:
	cd ./kubernetes && terraform init -upgrade

k8s_plan: k8s_init
	cd ./kubernetes && terraform plan -out k8s.tfplan

k8s_apply: 
	cd ./kubernetes && terraform apply k8s.tfplan && rm k8s.tfplan

plan: fmt init
	terraform plan -out plan.tfplan

apply:
	terraform apply plan.tfplan

fmt:
	cd .. && terraform fmt -recursive