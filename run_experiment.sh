#!/bin/bash

#SBATCH --mem-per-gpu=10G
#SBATCH --cpus-per-gpu=4
#SBATCH --gpus=1
#SBATCH --time=24:00:00
#SBATCH --qos=posa-high
#SBATCH --partition=posa-compute

source /scratch/hien/venvs/rl_contacts_env/bin/activate
cd /scratch/hien/rl-baselines3-zoo

ALGO=td3
ENV=CartPole-Softwalls-v1
TRAIN_NO_STEP=500000
TENSORBOARD_LOG_DIR=/scratch/hien/tensorboard_log

TUNING=true
TUNING_NO_STEP=200000
TUNING_NO_TRIALS=1000
TUNING_SAMPLER=tpe
TUNING_PRUNER=median

if $TUNING
then
    python train.py --algo $ALGO --env $ENV -n $TUNING_NO_STEP -optimize --n-trials $TUNING_NO_TRIALS --sampler $TUNING_SAMPLER --pruner $TUNING_PRUNER
else
    python train.py --algo $ALGO --env $ENV -n $TUNING_NO_STEP --tensorboard-log $TENSORBOARD_LOG_DIR
fi

exit 0
