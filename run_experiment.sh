#!/bin/bash

#SBATCH --mem-per-gpu=10G
#SBATCH --cpus-per-gpu=4
#SBATCH --gpus=1
#SBATCH --time=2:00:00
#SBATCH --qos=low
#SBATCH --partition=compute

source /scratch/hien/venvs/rl_contacts_env/bin/activate
cd /scratch/hien/rl-baselines3-zoo
python train.py --algo td3 --env CartPole-Softwalls-v1 -n 500000 --tensorboard-log /scratch/hien/tensorboard_log
