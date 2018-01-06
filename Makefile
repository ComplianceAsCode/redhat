merge:
	cat header_opencontrol.yaml > component.yaml
	cat ./policies/*/component.yaml >> component.yaml
