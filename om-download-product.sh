#!/bin/bash

#
# NOTE: Export PIVNET_API_TOKEN before running, else the download
# will fail because we need to auth to the Tanzu Network.
# This token can be retrieved from your profile page in in the Tanzu Network
# (network.tanzu.vmware.com)
#

#
# Note: If you're running OSX, you likely have too old of a Bash
# install. You need at least version 4.0 to use associative arrays.
#
# Modify this array to config what products and versions you want
# to download.
declare -A products=( [pivotal-container-service]='1.10.0' \
                      [elastic-runtime]='2.10.11' \
                      [apm]='2.0.5' \
                      [p-metric-store]='1.5.2' \
                      [credhub-service-broker]='1.4.8' \
                      [p-spring-cloud-services]='3.1.19' \
                     )


# For each product, download the tile and the requisite stemcells.
for p in "${!products[@]}"; do

  PRODUCT_SLUG=$p
  PRODUCT_VERSION=${products[$p]}

  mkdir -p $PRODUCT_SLUG

  echo "Downloading $PRODUCT_SLUG"

  om download-product --stemcell-iaas aws --stemcell-heavy \
    --pivnet-product-slug $PRODUCT_SLUG \
    --output-directory $PRODUCT_SLUG \
    --file-glob '*.pivotal' \
    --product-version $PRODUCT_VERSION \
    --pivnet-api-token=$PIVNET_API_TOKEN
  
done


# Tanzu App Service
# TAS has two flavors, so we need to specify that flavor in the 
# 'file-glob' flag.
# Currently hard-coded to Small Runtime (srt).
echo "Attempting to download Tanzu App Service"
PRODUCT_SLUG='elastic-runtime'
PRODUCT_VERSION=2.10.11
mkdir -p $PRODUCT_SLUG

om download-product --stemcell-iaas aws --stemcell-heavy \
  --pivnet-product-slug $PRODUCT_SLUG \
  --output-directory $PRODUCT_SLUG \
  --file-glob 'srt*.pivotal' \
  --product-version $PRODUCT_VERSION \
  --pivnet-api-token=$PIVNET_API_TOKEN

echo "Done"

# Tanzu Service Manager
# TSM isn't a tile, so the 'file-glob' flag will be different.
# TODO: Future work
###PRODUCT_SLUG='tanzu-service-manager'
###PRODUCT_VERSION=1.0.11
###mkdir -p $PRODUCT_SLUG
###
###echo "Attempting to download Tanzu Service Manager"
###om download-product --stemcell-iaas aws --stemcell-heavy \
###  --pivnet-product-slug tanzu-service-manager \
###  --output-directory tanzu-service-manager \
###  --file-glob '*.*' \
###  --product-version 1.0.11 \
###  --pivnet-api-token=$PIVNET_API_TOKEN
