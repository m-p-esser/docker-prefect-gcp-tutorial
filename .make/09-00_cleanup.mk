##@ [Cleanup: Remove all ressources]

unset-gcp-project: ## Unset GCP project for current session
	@echo "Unset project for current session"
	gcloud config unset project

delete-gcp-project: ## Delete GCP project for current session
	@echo "Delete project and WITHOUT prompting the user to confirm"
	gcloud projects delete $(CLOUDSDK_CORE_PROJECT) --quiet