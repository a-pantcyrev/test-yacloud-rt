
## Prerequisites


- Workstation with a minimal linux destribution (bash/zsh)
- Yandex cloud account with an active subscription (trial will do)
- Browser to get the oAuth token from yandex (could not find any workaround for cli)


## Preparing the workstation


Install binenv 
```sh
wget -q https://github.com/devops-works/binenv/releases/download/v0.19.0/binenv_linux_amd64
wget -q https://github.com/devops-works/binenv/releases/download/v0.19.0/checksums.txt
sha256sum  --check --ignore-missing checksums.txt
mv binenv_linux_amd64 binenv
chmod +x binenv
./binenv update
./binenv install binenv
rm binenv
if [[ -n $BASH ]]; then ZESHELL=bash; fi
if [[ -n $ZSH_NAME ]]; then ZESHELL=zsh; fi
echo $ZESHELL
echo -e '\nexport PATH=~/.binenv:$PATH' >> ~/.${ZESHELL}rc
echo "source <(binenv completion ${ZESHELL})" >> ~/.${ZESHELL}rc
exec $SHELL
```

Install needed tools
```sh
binenv install terraform
binenv install kubectl
binenv install helm
```

Configure yandex-povider-mirror for terraform
```sh
mv ~/.terraformrc ~/.terraformrc.old
nano ~/.terraformrc
```

Add this to the top of ~/.terraformrc
```json
provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
```

Install and initialize yandex-cloud-cli (you will need to login into yandex account in browser)
```sh
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
exec -l $SHELL
```
The next command will give you link for your oAuth token
Everything else can be set to accounts default (if you dont have multiple ya-clouds linked to your account) just press Enter
```sh
yc init
```

Create the service-account for terraform and save the service-account-id to grant the accound needed permissions and creat the iam key
```sh
yc iam service-account create --name terraform-sa
```

```sh
yc resource-manager folder add-access-binding default \
  --role editor \
  --subject serviceAccount:<service_account_ID>
```

```sh
yc iam key create \
  --service-account-id <service_account_ID> \
  --folder-name default \
  --output authorized_key.json
```
Clone this repo
```sh
git clone https://github.com/a-pantcyrev/test-yacloud-rt.git
```
Initialaze terraform project
```sh
mv authorized_key.json ./test-yacloud-rt/authorized_key.json
cd test-yacloud-rt
terraform init
```
## We are almost done
At this point you should be able to just type
```sh
terraform plan
terraform apply
```
and the infrastrucure should be deployed in aproximatly 15-20 minutes
