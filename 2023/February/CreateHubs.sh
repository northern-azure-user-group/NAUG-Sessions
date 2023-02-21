# Variables
rg=vWANnaug
vwan=naugvwan
location1=westeurope
location2=uksouth
username=labuser
password=Th1sIsMyPassw0rd
vwan_hub1_prefix=192.168.1.0/24
vwan_hub2_prefix=192.168.2.0/24
# Branches
publisher=cisco
offer=cisco-csr-1000v
sku=16_12-byol
version=$(az vm image list -p $publisher -f $offer -s $sku --all --query '[0].version' -o tsv)
branch1_prefix=172.16.1.0/24
branch1_subnet=172.16.1.0/26
branch1_gateway=172.16.1.1
branch1_bgp_ip=172.16.1.10
branch1_asn=65501
branch2_prefix=172.16.2.0/24
branch2_subnet=172.16.2.0/26
branch2_gateway=172.16.2.1
branch2_bgp_ip=172.16.2.10
branch2_2ary_bgp_ip=172.16.2.20
branch2_asn=65502
# Create RG, VWAN, hubs
az group create -n $rg -l $location1
# vwan and hubs
az network vwan create -n $vwan -g $rg -l $location1 --branch-to-branch-traffic true --type Standard
az network vhub create -n hub1 -g $rg --vwan $vwan -l $location1 --address-prefix $vwan_hub1_prefix
az network vhub create -n hub2 -g $rg --vwan $vwan -l $location2 --address-prefix $vwan_hub2_prefix
# Retrieve IDs of default and none RTs. We will need this when creating the connections
hub1_default_rt_id=$(az network vhub route-table show --vhub-name hub1 -g $rg -n defaultRouteTable --query id -o tsv)
hub2_default_rt_id=$(az network vhub route-table show --vhub-name hub2 -g $rg -n defaultRouteTable --query id -o tsv)
hub1_none_rt_id=$(az network vhub route-table show --vhub-name hub1 -g $rg -n noneRouteTable --query id -o tsv)
hub2_none_rt_id=$(az network vhub route-table show --vhub-name hub2 -g $rg -n noneRouteTable --query id -o tsv)
