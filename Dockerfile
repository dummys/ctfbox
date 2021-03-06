FROM ubuntu:latest
MAINTAINER boogy <theboogymaster@gmail.com>

RUN echo "kernel.yama.ptrace_scope = 0" > /etc/sysctl.d/10-ptrace.conf && \
    sysctl -w kernel.yama.ptrace_scope=0 && \
    useradd -m -s /bin/bash -p ctf ctf && \
    mkdir -p /home/ctf/tools && \
    mkdir -p /etc/sudoers.d/ && \
    echo "ctf ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ctf

COPY setup.sh /home/ctf/setup.sh

RUN cd /home/ctf/ && \
    chmod +x /home/ctf/setup.sh && \
    bash /home/ctf/setup.sh && \
    chown -R ctf: /home/ctf/tools && \
    update-rc.d ssh defaults && service ssh start

EXPOSE 22 1337 3002 3003 4000

USER ctf

WORKDIR /home/ctf

CMD ["/bin/bash", "-i"]
