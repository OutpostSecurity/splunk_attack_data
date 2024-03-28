#!/bin/bash
echo "Begin: Splunk data loading..."
echo "**Begin: Loading virtual environment..."
cd /home/ec2-user/attack_data
pwd
virtualenv venv
source venv/bin/activate
echo "**End: Loading virtual environment."

echo "**Begin: Execute TTP Replay Files..."
echo "****Loading: replay_ttp1"
python bin/replay.py -c bin/replay_ttp1.yml
WAIT="$(( RANDOM %= 10 ))m"
echo "****Sleeping $WAIT minutes..."
sleep $WAIT
echo "**End: Execute TTP Replay Files."

echo "**Begin: Execute Suspicious Behaviour Replay Files."
echo "****Loading: replay_suspicious_behaviour1"
python bin/replay.py -c bin/replay_suspicious_behaviour1.yml
WAIT="$(( RANDOM %= 10 ))m"
echo "****Sleeping $WAIT minutes..."
sleep $WAIT

echo "**End: Execute Suspicious Behaviour Replay Files."
echo "End: Splunk data load."

