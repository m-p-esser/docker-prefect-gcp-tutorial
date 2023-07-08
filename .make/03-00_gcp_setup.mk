##@ [GCP: Setup]

.PHONY: create-gcp-project
create-gcp-project: ## Create new GCP Project
	@echo "Create new project"
	gcloud projects create $(GCP_PROJECT_ID)
	@echo "Check if project is created"
	gcloud projects describe $(GCP_PROJECT_ID)

.PHONY: set-default-gcp-project
set-default-gcp-project: ## Set new GCP Project as default
	@echo "Set the project for the current session"
	gcloud config set project $(GCP_PROJECT_ID)

.PHONY: link-project-to-billing-account 
link-project-to-billing-account: ## Link GCP Project to Billing account
	@echo "Get list of billing accounts"
	gcloud beta billing accounts list
	@echo "Link billing account to project"
	gcloud beta billing projects link $(GCP_PROJECT_ID) --billing-account=$(GCP_BILLING_ACCOUNT)
	@echo "Confirm billing account has been linked"
	gcloud beta billing accounts --project=$(GCP_PROJECT_ID) list

.PHONY: create-service-account
create-service-account: ## Create Service Account
	@echo "Create new Service account"
	gcloud iam service-accounts create $(GCP_SERVICE_ACCOUNT)

.PHONY: setup-gcp
setup-gcp: ## Setup GCP Project so it can be used for development, CI or production
	@echo "Setting up GCP Project"
	"$(MAKE)" create-gcp-project
	"$(MAKE)" set-default-gcp-project
	"$(MAKE)" link-project-to-billing-account
	"$(MAKE)" create-service-account
	"$(MAKE)" enable-gcp-services
# "$(MAKE)" create-key-file
	@echo "Finished setting up GCP Project"

.PHONY: create-key-file
create-key-file: ## Create GCP Keyfile
	gcloud iam service-accounts keys create credentials/prefect_service_account.json \
		--iam-account=$(GCP_SERVICE_ACCOUNT)@$(GCP_PROJECT_ID).iam.gserviceaccount.com

.PHONY: enable-gcp-services
enable-gcp-services: ## Enable GCP services
	@echo "Enabling GCP services..."
	gcloud services enable \ 
		iamcredentials.googleapis.com \
		artifactregistry.googleapis.com \
		run.googleapis.com \
		appenginereporting.googleapis.com \
		compute.googleapis.com


