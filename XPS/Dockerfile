FROM mcr.microsoft.com/dotnet/aspnet:10.0-noble

RUN apt-get update && \
    apt-get -y --no-install-recommends install wget unzip git gcc build-essential

#Install ghostscript, gpcl6, gxps
RUN wget https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9533/ghostscript-9.53.3-linux-x86_64.tgz && \
    tar zxf ghostscript-9.53.3-linux-x86_64.tgz && \
    rm ghostscript-9.53.3-linux-x86_64.tgz && \
    cd ghostscript-9.53.3-linux-x86_64 && \
    mv ./gs-9533-linux-x86_64 /usr/local/bin/ghostscript && \
    cp /usr/local/bin/ghostscript /usr/local/bin/gs && \
    cd .. && \
    rm -R ghostscript-9.53.3-linux-x86_64/ && \
    wget https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9533/ghostpcl-9.53.3-linux-x86_64.tgz && \
    tar zxf ghostpcl-9.53.3-linux-x86_64.tgz && \
    rm ghostpcl-9.53.3-linux-x86_64.tgz && \
    cd ghostpcl-9.53.3-linux-x86_64 && \
    mv ./gpcl6-9533-linux-x86_64 /usr/local/bin/gpcl6 && \
    mv ./* /usr/local/bin/ && \
    cd .. && \
    rm -R ghostpcl-9.53.3-linux-x86_64/ && \
    wget https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9533/ghostxps-9.53.3-linux-x86_64.tgz && \
    tar zxf ghostxps-9.53.3-linux-x86_64.tgz && \
    rm ghostxps-9.53.3-linux-x86_64.tgz && \
    cd ghostxps-9.53.3-linux-x86_64 && \
    mv ./gxps-9533-linux-x86_64 /usr/local/bin/gxps && \
    mv ./* /usr/local/bin/ && \
    cd .. && \
    rm -R ghostxps-9.53.3-linux-x86_64/