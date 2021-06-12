# Copyright 2019 Google LLC All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Echo commands
set -v

# Install or update needed software
apt-get update
apt-get install -yq git supervisor python3 python3-pip
pip3 install --upgrade pip virtualenv

# Account to own server process
useradd -m -d /home/pythonapp pythonapp

# Fetch source code
export HOME=/home/sysbio/s258011
git clone https://github.com/mo-dashti1/s258011.git /home/sysbio/s258011/app

# Python environment setup
virtualenv -p python3 /home/sysbio/s258011/app/env
source /home/sysbio/s258011/app/env/bin/activate
/opt/app/env/bin/pip3 install -r /opt/app/requirements.txt

# Set ownership to newly created account
chown -R pythonapp:pythonapp /home/sysbio/s258011/app

# Put supervisor configuration in proper place
cp /opt/app/python-app.conf /etc/supervisor/conf.d/python-app.conf

# Start service via supervisorctl
supervisorctl reread
supervisorctl update
# [END getting_started_gce_startup_script]
