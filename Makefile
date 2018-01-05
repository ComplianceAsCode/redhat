merge:
	cat header_opencontrol.yaml > component.yaml
	cat ./narratives/*/component.yaml >> component.yaml
