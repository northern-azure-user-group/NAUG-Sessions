#Variables 

rg=vWANnaug
vwan=naugvwan
location1=westeurope
location2=uksouth
username=labuser
password=Th1sIsMyPassw0rd

# Spoke11 in location1
spoke_id=11
vnet_prefix=10.1.1.0/24
subnet_prefix=10.1.1.0/26
az vm create -n spoke${spoke_id}-vm -g $rg -l $location1 --image ubuntuLTS --admin-username $username --generate-ssh-keys \
    --public-ip-address spoke${spoke_id}-pip --vnet-name spoke${spoke_id}-$location1 \
    --vnet-address-prefix $vnet_prefix --subnet vm --subnet-address-prefix $subnet_prefix
az network vhub connection create -n spoke${spoke_id} -g $rg --vhub-name hub1 --remote-vnet spoke${spoke_id}-$location1 \
    --internet-security true --associated-route-table $hub1_default_rt_id --propagated-route-tables $hub1_default_rt_id

# Spoke12 in location1
spoke_id=12
vnet_prefix=10.1.2.0/24
subnet_prefix=10.1.2.0/26
az vm create -n spoke${spoke_id}-vm -g $rg -l $location1 --image ubuntuLTS --admin-username $username --generate-ssh-keys \
    --public-ip-address spoke${spoke_id}-pip --vnet-name spoke${spoke_id}-$location1 \
    --vnet-address-prefix $vnet_prefix --subnet vm --subnet-address-prefix $subnet_prefix
az network vhub connection create -n spoke${spoke_id} -g $rg --vhub-name hub1 --remote-vnet spoke${spoke_id}-$location1 \
    --internet-security true --associated-route-table $hub1_default_rt_id --propagated-route-tables $hub1_default_rt_id

# Spoke21 in location2
spoke_id=21
vnet_prefix=10.2.1.0/24
subnet_prefix=10.2.1.0/26
az vm create -n spoke${spoke_id}-vm -g $rg -l $location2 --image ubuntuLTS --admin-username $username --generate-ssh-keys \
    --public-ip-address spoke${spoke_id}-pip --vnet-name spoke${spoke_id}-$location2 \
    --vnet-address-prefix $vnet_prefix --subnet vm --subnet-address-prefix $subnet_prefix
az network vhub connection create -n spoke${spoke_id} -g $rg --vhub-name hub2 --remote-vnet spoke${spoke_id}-$location2 \
    --internet-security true --associated-route-table $hub2_default_rt_id --propagated-route-tables $hub2_default_rt_id

# Spoke22 in location2
spoke_id=22
vnet_prefix=10.2.2.0/24
subnet_prefix=10.2.2.0/26
az vm create -n spoke${spoke_id}-vm -g $rg -l $location2 --image ubuntuLTS --admin-username $username --generate-ssh-keys \
    --public-ip-address spoke${spoke_id}-pip --vnet-name spoke${spoke_id}-$location2 \
    --vnet-address-prefix $vnet_prefix --subnet vm --subnet-address-prefix $subnet_prefix
az network vhub connection create -n spoke${spoke_id} -g $rg --vhub-name hub2 --remote-vnet spoke${spoke_id}-$location2 \
    --internet-security true --associated-route-table $hub2_default_rt_id --propagated-route-tables $hub2_default_rt_id

