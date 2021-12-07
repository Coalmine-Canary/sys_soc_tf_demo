# NTU Systems Society Terraform demonstration files

Instructions:

1. Clone this repo `git clone https://github.com/Coalmine-Canary/sys_soc_tf_demo.git`
2. Download Terraform from https://www.terraform.io/downloads.html
3. Move the Terraform binary to somewhere in your PATH/Environment - i.e. in Linux, a directory listed when you type `echo $PATH` and in Windows, add the binary to your environment variables (search with start menu). 
4. Install the Azure CLI, following isntructions at https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
5. Log into azure with `az login`
6. Create SSH keys with `ssh-keygen -f ./id_rsa` (empty passphrase is fine).
7. Add your subscription id to terraform.tfvars (to find this, run `az account list`). OR you can also just add -var='subscription_id=$ID' to the next stages' command instead.
8. Run `terraform apply` and type `yes`
9. Check Azure for the new Virtual Machines' IP address (not reliable to check this via state file, but you can try it by running `terraform state show data.azurerm_public_ip.demo` or `terraform state show azurerm_public_ip.demo`)

Feel free to contact me or add to the issues page if there are any issues or questions. 
