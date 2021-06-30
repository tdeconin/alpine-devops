FROM node:14-alpine AS node

FROM mcr.microsoft.com/azure-cli

COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/lib/node_modules/npm/ /usr/local/lib/node_modules/npm/

RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm && \
    npm i -g yarn typescript@4.2.3 ts-node && \
    apk --no-cache add mongodb-tools docker && \
    az aks install-cli && \
    curl -LO https://github.com/kvaps/kubectl-node-shell/raw/master/kubectl-node_shell && \
    chmod +x ./kubectl-node_shell && \
    mv ./kubectl-node_shell /usr/local/bin/kubectl-node_shell

