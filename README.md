# TAS Importer Tools

Everything needed to import TAS artifacts.


# Step 1: Download Products & Stem Cells

Run `om-download-product.sh` to download TAS Tiles and their stemcells.

# Step 2: Download and Export Ops Manager

Use the files in the [terraform](/terraform) directory to stand up the needed scaffolding. Then use the [Image Manipulator](https://github.com/pivotal/aws-gov-image-manipulator) repo to download/extract Ops Manager.

# Step 3: Import
Import your files from Step 1 & 2.
