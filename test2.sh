#!/bin/bash
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar  -D mapreduce.job.reduces=5  -files lr  -mapper "python lr/mapper.py -n 5 -r 0.4"  -reducer "python lr/reducer.py -f 5676"  -input hw1/training  -output hw1/models

