default: validate

init:
	terraform init -backend=false -upgrade
	terraform providers

fmt:
	cd .. && terraform fmt -recursive

validate: init fmt
	terraform validate