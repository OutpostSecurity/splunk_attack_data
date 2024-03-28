#!/bin/bash
echo "Begin: Splunk data loading..."
echo "**Begin: Loading virtual environment..."
cd /home/ec2-user/attack_data
pwd
virtualenv venv
source venv/bin/activate
echo "**End: Loading virtual environment."

echo "**Begin: Execute Malware Replay Files."
echo "****Loading: replay_malware1"
python bin/replay.py -c bin/replay_malware1.yml
WAIT="$(( RANDOM %= 10 ))m"
echo "****Sleeping $WAIT minutes..."
sleep $WAIT

echo "****Loading: replay_malware2"
python bin/replay.py -c bin/replay_malware2.yml
WAIT="$(( RANDOM %= 10 ))m"
echo "****Sleeping $WAIT minutes..."
sleep $WAIT

echo "****Loading: replay_malware3"
python bin/replay.py -c bin/replay_malware3.yml
WAIT="$(( RANDOM %= 10 ))m"
echo "****Sleeping $WAIT minutes..."
sleep $WAIT

echo "****Loading: replay_malware4"
python bin/replay.py -c bin/replay_malware4.yml
WAIT="$(( RANDOM %= 10 ))m"
echo "****Sleeping $WAIT minutes..."
sleep $WAIT


echo "**End: Execute Malware Replay Files."
echo "End: Splunk data load."

