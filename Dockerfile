FROM nixos/nix

ARG DOCKER=true
ARG MIX_ENv=dev
ENV DOCKER=${DOCKER}
ENV MIX_ENv=${MIX_ENV}

RUN echo "filter-syscalls = false" >> /etc/nix/nix.conf
RUN nix-channel --update

WORKDIR /aleo_roulette

COPY . .
ADD universal.srs.trial.3747e59 /root/.aleo/resources/universal.srs.trial.3747e59 
RUN nix-shell --command "make init"
RUN nix-shell --command "make build"

RUN chmod +x ./start.sh

EXPOSE 3000
EXPOSE 4000

CMD ["bash", "start.sh"]

