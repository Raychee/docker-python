FROM raychee/python3

COPY tdodbc1510__linux_indep.15.10.01.05-1.tar.gz /opt/teradata_install/
RUN cd /opt/teradata_install && \
    tar -xvf tdodbc1510__linux_indep.15.10.01.05-1.tar.gz && \
    tar -xvf tdicu1510__linux_indep.15.10.01.02-1.tar.gz && \
    rpm -ivh --nodeps tdicu1510/tdicu1510-15.10.01.02-1.noarch.rpm && \
    tar -xvf TeraGSS_linux_x64__linux_indep.15.10.04.02-1.tar.gz && \
    rpm -ivh --nodeps TeraGSS/TeraGSS_linux_x64-15.10.04.02-1.noarch.rpm && \
    tar -xvf tdodbc1510__linux_indep.15.10.01.05-1.tar.gz && \
    rpm -ivh --nodeps tdodbc1510/tdodbc1510-15.10.01.05-1.noarch.rpm && \
    cp /opt/teradata/client/15.10/odbc_64/odbc.ini $HOME/.odbc.ini && \
    cp /opt/teradata/client/15.10/odbc_64/odbcinst.ini $HOME/.odbcinst.ini && \
    cd / && \
    rm -rf /opt/teradata_install

RUN conda install -y teradata=15.10.0.20 && \
    conda clean -y --all
