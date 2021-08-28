default: validate

init:
	terraform init -backend=false -upgrade
	terraform providers

fmt:
	terraform fmt

validate: init fmt
	terraform validate