ARG image=lavasoftware/lava-dispatcher:latest
FROM ${image}

ARG extra_packages=""
RUN apt -q update
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install software-properties-common nfs-common
RUN apt-add-repository non-free
RUN apt -q update
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install ${extra_packages} net-tools snmp snmp-mibs-downloader
RUN download-mibs

# Add MIBs
RUN mkdir -p /usr/share/snmp/mibs/
#ADD https://raw.githubusercontent.com/ci-box/ci-box-lava-worker/master/powernet428.mib /usr/share/snmp/mibs/powernet428.mib
COPY powernet428.mib /usr/share/snmp/mibs/powernet428.mib

# Add certificates.
COPY certs/* /etc/lava-dispatcher/certificates.d/

# Add ssh config.
COPY ssh/* /root/.ssh/

# Add power control scripts.
COPY power-control/* /root/power-control/

# hack for android devices
COPY docker-hack.py /usr/lib/python3/dist-packages/lava_dispatcher/utils/docker.py

# Add lab scripts
RUN mkdir -p /usr/local/lab-scripts/
ADD https://git.linaro.org/lava/lava-lab.git/plain/shared/lab-scripts/snmp_pdu_control /usr/local/lab-scripts/
RUN chmod a+x /usr/local/lab-scripts/snmp_pdu_control
ADD https://git.linaro.org/lava/lava-lab.git/plain/shared/lab-scripts/eth008_control /usr/local/lab-scripts/
RUN chmod a+x /usr/local/lab-scripts/eth008_control

ENTRYPOINT ["/root/entrypoint.sh"]
