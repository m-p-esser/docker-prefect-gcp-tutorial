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
create-service-account: ## - Create Service Account
	@echo "Create new Service account"
	gcloud iam service-accounts create $(GCP_SERVICE_ACCOUNT)

.PHONY: setup-gcp
	"$(MAKE)" create-gcp-project
	"$(MAKE)" set-default-gcp-project
	"$(MAKE)" link-project-to-billing-account
	"$(MAKE)" create-service-account


# create_key_file: ## - Create GCP Keyfile
# 	gcloud iam service-accounts keys create credentials/prefect_service_account.json \
# 		--iam-account=$(CLOUDSDK_SERVICE_ACCOUNT)@$(CLOUDSDK_CORE_PROJECT).iam.gserviceaccount.com

# enable_services: ## - Enable GCP services
# 	@echo "Enabling GCP services..."
# 	gcloud services enable iamcredentials.googleapis.com
# 	gcloud services enable artifactregistry.googleapis.com
# 	gcloud services enable run.googleapis.com
# 	gcloud services enable appenginereporting.googleapis.com

# enable_compute: ## - Enable Compute Storage
# 	@echo "Enable compute service"
# 	gcloud services enable compute.googleapis.com
# 	@echo "Add gcloud services compute default region and zone using variables above"
# 	gcloud compute project-info add-metadata \
# 	    --metadata google-compute-default-region=$(CLOUDSDK_DEFAULT_REGION),google-compute-default-zone=$(CLOUDSDK_DEFAULT_ZONE)
# 	@echo "Check that default region and zone is configured"
# 	gcloud compute project-info describe
# 	@echo "List compute services and ensure that they're enabled"
# 	gcloud services list --enabled --filter=compute