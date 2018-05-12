FROM node:8-alpine AS base
WORKDIR /usr/app
RUN npm set progress=false && \
    npm config set depth 0
COPY . .

FROM base as dependencies
RUN npm install

FROM base AS release
RUN npm install forever -g
COPY --from=dependencies /usr/app .
EXPOSE 8083
CMD forever ./index.js