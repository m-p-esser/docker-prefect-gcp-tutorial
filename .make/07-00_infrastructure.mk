##@ [GCP: Infrastructure]

# create-gcp-vm: ## Create Virtual machine (Compute Engine)
# 	printf "${GREEN}Creating a Compute Instance VM${NO_COLOR}\n"
# 	gcloud compute instances create "${vm_name}" \
# 		--project="${GCP_PROJECT_ID}" \
# 		--zone="${vm_zone}" \
# 		--machine-type=e2-micro \
# 		--network="${network}" \
# 		--subnet=default \
# 		--network-tier=PREMIUM \
# 		--no-restart-on-failure \
# 		--maintenance-policy=MIGRATE \
# 		--provisioning-model=STANDARD \
# 		--service-account="${deployment_service_account_mail}" \
# 		--scopes=https://www.googleapis.com/auth/cloud-platform \
# 		--create-disk=auto-delete=yes,boot=yes,device-name="${vm_name}",image=projects/debian-cloud/global/images/debian-11-bullseye-v20220822,mode=rw,size=10,type=projects/"${GCP_PROJECT_ID}"/zones/"${vm_zone}"/diskTypes/pd-balanced \
# 		--no-shielded-secure-boot \
# 		--shielded-vtpm \
# 		--shielded-integrity-monitoring \
# 		--reservation-affinity=any $args_for_public_access

# 	echo "Waiting 60s for the instance to be fully ready to receive IAP connections"
# 	sleep 60