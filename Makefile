merge:
	cat header_opencontrol > component.yaml
	cat ./policies/*/component.yaml >> component.yaml
