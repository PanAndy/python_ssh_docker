FROM centos:centos7.9.2009

# author label
LABEL maintainer="yali"

# install related packages
ENV ENVIRONMENT DOCKER_PROD
RUN cd / && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && yum makecache \
    && yum install -y wget aclocal automake autoconf make gcc gcc-c++ python-devel mysql-devel bzip2 libffi-devel epel-release \
    && yum clean all

RUN mkdir -p ~/miniconda3 \
    && wget --no-check-certificate https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh \
    && bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 \
    && rm -rf ~/miniconda3/miniconda.sh
ENV PATH=/opt/miniconda/bin:${PATH}

# 创建src目录
COPY src /root/src
WORKDIR /root/src

# install related packages
# RUN pip3 install -i https://pypi.doubanio.com/simple/ -r requirements.txt

# expose port
EXPOSE 23455

# install ssh
RUN yum -y update; yum clean all
RUN yum -y install openssh-server passwd; yum clean all
ADD ./start.sh /start.sh
RUN mkdir /var/run/sshd

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''

RUN chmod 755 /start.sh
RUN /start.sh
ENTRYPOINT ["/usr/sbin/sshd", "-D"]