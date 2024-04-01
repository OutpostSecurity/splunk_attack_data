This project is meant to help accelerate you ability to script importing attack datasets from Splunk. Be sure to review the readme and install steps from https://github.com/splunk/attack_data

# Setup
Install git on the server

````
sudo yum -y install git
````

Install pip on the server
````
sudo yum -y install pip
````

Download the repository with this command:

````
git clone https://github.com/splunk/attack_data
````

# Configure LFS
Install git-lfs

````
sudo yum -y install git-lfs
````

Initiate LFS

```
git lfs install --skip-smudge
```
Move into the attack_data directory and do a full lfs pull. This will be roughly 12gb since it downloads all of the datasets. Alternatively, you can download select datasets and can see how on https://github.com/splunk/attack_data

````
cd attack_data/
git lfs pull
````

# Setup Virtual Environment
We now setup a python virtual environment for running the replay files.

```
cd attack_data
pip install virtualenv
virtualenv venv
source venv/bin/activate
pip install -r bin/requirements.txt
deactivate
```

# Replay Datasets
Copy the replay files to attack_data/bin/

```
replay_malware1.yml
replay_malware2.yml
replay_malware3.yml
replay_malware4.yml
replay_suspicious_behaviour.yml
replay_ttp1.yml
```

Be sure to edit each replay file to connect to thve splunk instance you have:

```
splunk:
  # connects to host on port 8089 make sure you have access to <host>:8089
  host: localhost
  username: admin
  password: changeme
```

Copy data load scripts to the directory above attack_data and make them executable

```
splunk_dataload1.sh
splunk_dataload2.sh
chmod u+x splunk_dataload*
```

*Patch attack_data/bin/replay.py

```
Add - from shutil import copyfileobj
--
Replace - 
kwargs_submit['rename-source'] = dataset['replay_parameters']['source']
results = index.upload(fullpath, **kwargs_submit)

With -
kwargs_submit['source'] = dataset['replay_parameters']['source']
with index.attached_socket(**kwargs_submit) as index_socket, open(fullpath, 'rb') as logfile:
    copyfileobj(logfile, index_socket)![image](https://github.com/OutpostSecurity/splunk_attack_data/assets/72515718/aa6877aa-c9f0-4945-b855-18a26ba252cb)
```

# Run Replay
To run  the data load replays we setup:

```
./splunk_dataload1.sh
./splunk_dataload2.sh
```

Happy Threat Hunting :) 
