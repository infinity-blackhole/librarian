.PHONY: all
all:
	@skaffold build --file-output=tags.json

.PHONY: deploy
deploy:
	@skaffold deploy --build-artifacts=tags.json

.PHONY: proxy
proxy:
	@gcloud run services proxy librarian \
		--project shikanime-studio-labs \
		--region europe-west3
