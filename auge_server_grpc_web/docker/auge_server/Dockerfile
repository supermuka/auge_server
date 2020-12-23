# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM google/dart:2.10.4

# understand a way to inform a directory specific here or implementation. Today configuraion.yaml is read on current directory.
COPY certificate/cert.pem /etc/auge_server/certificate/cert.pem
COPY certificate/privkey.pem /etc/auge_server/certificate/privkey.pem

COPY config/configuration.yaml /etc/auge_server/config/configuration.yaml
COPY bin/auge_server.dart.snapshot /etc/auge_server/bin/auge_server.dart.snapshot

EXPOSE 9091
WORKDIR "/etc/auge_server/"
CMD /usr/bin/dart bin/auge_server.dart.snapshot