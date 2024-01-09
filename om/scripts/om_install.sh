
#!/bin/bash
# #############################################
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
# #############################################

echo "OM server of type ${OM_TYPE} will be set-up"
apt-get update
	apt-get install -y --no-install-recommends gnupg2 dirmngr
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 234821A61B67740F89BFD669FC8A16625AFA7A83

	KURENTO_LIST="/etc/apt/sources.list.d/kurento.list"
	echo "# Kurento Media Server - Release packages" > ${KURENTO_LIST}
	echo "deb [arch=amd64] http://ubuntu.openvidu.io/7.0.0 focal main" >> ${KURENTO_LIST}

	echo "mysql-server mysql-server/root_password password ${DB_ROOT_PASS}" | debconf-set-selections
	echo "mysql-server mysql-server/root_password_again password ${DB_ROOT_PASS}" | debconf-set-selections
	echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

	apt-get update
	apt-get install -y --no-install-recommends \
		kurento-media-server 
	apt-get clean
	rm -rf /var/lib/apt/lists/*
	sed -i "s/DAEMON_USER=\"kurento\"/DAEMON_USER=\"nobody\"/g" /etc/default/kurento-media-server
echo "session required pam_limits.so" >> /etc/pam.d/common-session
