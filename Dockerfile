# https://github.com/ThomasOliver545/nestjs-local-development-docker-compose-hot-reload/blob/master/Dockerfile

# Stage: development
ARG NODE_VERSION=20.13.1

FROM node:${NODE_VERSION} as development

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage: production
FROM node:${NODE_VERSION} as production
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

COPY --from=development /usr/src/app .

EXPOSE 3000

CMD [ "node", "dist/main" ]