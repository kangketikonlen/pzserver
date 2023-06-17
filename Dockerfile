FROM ubuntu:lunar

# Proceed to Install steamcmd.
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install software-properties-common -y
RUN apt-add-repository non-free
RUN apt-get install steamcmd

# Add pzuser
RUN adduser --disabled-password pzuser

# Install Zomboid Server in /opt/pzserver
RUN mkdir /opt/pzserver
RUN chown pzuser:pzuser /opt/pzserver

# Set user as pzuser
USER pzuser

# Install Project Zomboid Server
COPY ./scripts/update-zomboid.txt /home/pzuser/update-zomboid.txt
RUN steamcmd +runscript $HOME/update_zomboid.txt