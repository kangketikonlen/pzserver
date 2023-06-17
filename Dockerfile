FROM cm2network/steamcmd:root

ENV STEAMAPPID 380870
ENV STEAMAPP pz
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

RUN apt-get update 
RUN apt-get install -y --no-install-recommends --no-install-suggests dos2unix
RUN apt-get clean 
RUN rm -rf /var/lib/apt/lists/*

RUN set -x
RUN mkdir -p "${STEAMAPPDIR}"
RUN chown -R "${USER}:${USER}" "${STEAMAPPDIR}"
RUN bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
	+login anonymous \
	+app_update "${STEAMAPPID}" validate \
	+quit

COPY ./scripts/entryoints.sh /server/scripts/entryoints.sh
RUN chown -R ${USER}:${USER} /server/scripts/entryoints.sh
RUN chmod 550 /server/scripts/entryoints.sh

RUN mkdir -p "${HOMEDIR}/Zomboid"

WORKDIR ${HOMEDIR}

EXPOSE 16261-16262/udp
EXPOSE 27015/tcp

ENTRYPOINT ["/server/scripts/entryoints.sh"]