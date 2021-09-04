default: plan

init:
	terraform init
	terraform -v
	terraform providers

validate:
	terraform validate

fmt:
	cd .. && terraform fmt -recursive

plan: init validate fmt
	terraform plan -out plan.tfplan

apply:
	terraform apply plan.tfplan
	rm plan.tfplan

clean:
	terraform destroy -auto-approve