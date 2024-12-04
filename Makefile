run-verbose:
	ansible-playbook -v -i hosts pb.upgrade.yml -e "@localvars.yaml"

run:
	ansible-playbook -i hosts pb.upgrade.yml -e "@localvars.yaml"

run-step1-verbose:
	ansible-playbook -v -i hosts pb.upgrade.yml -e "@localvars.yaml" --skip-tags "step2,step3"

run-step2-verbose:
	ansible-playbook -v -i hosts pb.upgrade.yml -e "@localvars.yaml" --skip-tags "step1,step3"

run-step3-verbose:
	ansible-playbook -v -i hosts pb.upgrade.yml -e "@localvars.yaml" --skip-tags "step1,step2"