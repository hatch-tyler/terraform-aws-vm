#!/bin/bash

# perform updates and upgrades
sudo apt update -y
sudo apt-get install unzip -y

cd /home/ubuntu/

# Set MiniForge version and installation path
MINIFORGE_INSTALLER="Miniforge3-24.11.3-2-Linux-x86_64.sh"
MINIFORGE_URL="https://github.com/conda-forge/miniforge/releases/download/24.11.3-2/$MINIFORGE_INSTALLER"
INSTALL_DIR="/home/ubuntu/miniforge3"

# Download Miniforge installer
echo "Downloading MiniForge..."
curl -L -o /home/ubuntu/$MINIFORGE_INSTALLER $MINIFORGE_URL

# Install MiniForge
echo "Installing MiniForge..."
bash $MINIFORGE_INSTALLER -b -p $INSTALL_DIR
chown -R ubuntu:ubuntu $INSTALL_DIR

# iniialize conda
echo "initializing Conda..."
source $INSTALL_DIR/etc/profile.d/conda.sh
sudo -u ubuntu $INSTALL_DIR/bin/conda init bash


# create conda environment
mamba create -n env python=3.10 geopandas pandas numpy matplotlib flopy pyemu openpyxl boto3 pyshp -y

# add the command to activate the environment to .bashrc
echo "conda activate env" >> /home/ubuntu/.bashrc

# add environment variables for model zip and S3 bucket
echo 'export MODEL_ZIP="${model_zip}"' >> /home/ubuntu/.bashrc
echo 'export S3_BUCKET="${s3_bucket}"' >> /home/ubuntu/.bashrc

# change owner to user ubuntu
chown ubuntu:ubuntu /home/ubuntu/.bashrc

# clean up installer
rm /home/ubuntu/$MINIFORGE_INSTALLER

cat <<EOF > /home/ubuntu/download_from_s3.py
import boto3
import os

# Get environment variables
s3_bucket = os.getenv("S3_BUCKET")
model_zip = os.getenv("MODEL_ZIP")

if not s3_bucket or not model_zip:
    raise ValueError("S3_BUCKET or MODEL_ZIP environment variables not set")

# Initialize S3 client
s3 = boto3.client('s3')

# Download the file
s3.download_file(s3_bucket, model_zip, f'/home/ubuntu/{model_zip}')

print(f"Downloaded {model_zip} from {s3_bucket} to /home/ubuntu/{model_zip}")
EOF
