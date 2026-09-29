FROM mcr.microsoft.com/dotnet/aspnet:10.0-noble
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends ghostscript zbar-tools \
    && rm -rf /var/lib/apt/lists/*


ENV GhostScriptSettings__Executable="/usr/bin/gs"
ENV GhostScriptSettings__Parameter="-sDEVICE=pdfwrite -o \"{1}\" -dCompatibilityLevel=\"1.4\" -dPDFSETTINGS=\"/screen\" -dNOPAUSE -dQUIET -dBATCH \"{0}\""
ENV GhostScriptSettings__WorkDir="/tmp"
RUN /usr/bin/gs --version
