FROM nixos/nix

ARG DOCKER=true
ARG MIX_ENv=dev
ENV DOCKER=${DOCKER}
ENV MIX_ENv=${MIX_ENV}

RUN nix-channel --update

WORKDIR /aleo_roulette

COPY . .
RUN nix-shell --command "make init"
RUN nix-shell --command "make build"

RUN chmod +x ./start.sh

EXPOSE 3000
EXPOSE 4000

CMD ["bash", "start.sh"]
