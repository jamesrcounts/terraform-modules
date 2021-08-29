default: plan

init:
	terraform init
	terraform -v 
	terraform providers

plan: fmt init
	terraform plan -out plan.tfplan

apply:
	terraform apply plan.tfplan

fmt:
	cd .. && terraform fmt -recursive