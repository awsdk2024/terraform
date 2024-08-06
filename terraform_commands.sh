# step1- Establsih connect between aws & terraform (it will download the plugin)
1 -- it will initalize the terraform configuration
2 -- it will get the password & authenticate with AWS
3 -- it will do the provider configuration (downloading the resourece plugins)
terraform init

# A change in the backend configuration has been detected, which may require migrating existing state.
# If you wish to attempt automatic migration of the state, use --
terraform init -migrate-state

# If you wish to store the current configuration with no changes to the state, use --
terraform init -reconfigure

# step2 - format the terraform code (re-arrange the code Allignment(structure))
terraform fmt

# step3 - validate the terraform code (syntax check)
terraform validate

# step4 - plan the terraform code (what will happen) 
#Dry run -- it will show what is going to create if you use this code ( if you are ok, then proceed/ you can make the changes)
terraform plan


#step5 - you have created the code on monday but your manager asked to apply this in weekends (saturday/sunday) 
# you will save this plan by using below command & apply on weekends
terraform plan -out 4augplan-vpc-creation

# step6 - apply above terraform plan by using the below command on weekends
terraform apply "4augplan-vpc-creation"

# step5 - apply the terraform code (apply the changes)
terraform apply --auto-approve

(#Once terraform apply command used it will generate terraform statefile ({}terraform.tfstate))
# Note- terraform statefile means -- it will store the information in json format (what it has created/deleted/modified)
# Note -- don't make changes directly in statefile)
# Incase if you done the modification in the configuration file -- it will generate new terraform statefile & also generate the backup file of the previous file
# you can validate the statefile version of the terraform in {}terraform.tfstate file

# step6 - How to know the statefile information
terraform state list

#Note- don't save statefile locally (create s3 bucket & store it)

#Add backend s3 query & save the command in provider file

#how to lock statefile -- imagine 2 developers are working in a same configuration file & comiting the changes at a time
you can lock the statefile using dynamodb -- add dynamodb information in provider-backend s3-dynamodb

#step7 - planing to destroy the terraform -- don't do directly go & destroy. know before what you are destroying
terraform plan -destroy

#step8 - imagine you have created these resources via code -- S3 bucket/vpc/sg. 
#now you planned to destroy this infrastructure except s3 bucket. how will you achive that
terraform state list
terraform state rm aws_s3_bucket.<bucket_name>
#then you will code the code & comment the s3 bucket code

#how to rename a statefile of the bucket
terraform state mv aws_s3_bucket.<old_bucket_name> aws_s3_bucket.<new_bucket_name>

# step6 - destroy the terraform code
terraform destroy --auto-approve

#step7  -- imagine you have created 2 servers using this code, now you are planning to destroy specific instance.
terraform state list
terraform destroy --target aws_instance.server-1
terraform destroy --target aws_instance.server-1 --auto-approve


############# how terraform knows when to create what resources/ is there any dependency while creating resource ##########

Implicit - where a resource may reference another resource/data source
# Example for Implicit -- if you are traveing via car/bike & you have observed red signal -- you must stop
Explicit - where an engineer explicitly calls out a dependency between two resources/data sources
# Example for Explicit -- if you are traveing via car/bike & you find petrol bunk -- you may fill / you can leave upto you

#when will you use explicit - 
imagine you want to write script to create vpc/s3/ec2 then you can make an order by using depends_on = [ ]

######### how to know the changes added manually from frontend ###########
terraform plan --refresh-only

############ how to re-use the same code in multiple regions  ####################