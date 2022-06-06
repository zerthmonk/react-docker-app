FROM node:18-alpine AS base
RUN npm install \
	npm@latest \
	react-scripts@latest \
	react-dom@latest \
	react@latest \
	create-react-app@latest \
	-g --silent

FROM base AS main

WORKDIR /opt/app
ENV PATH /opt/app/node_modules/.bin:$PATH
COPY ./app/package*.json ./
RUN npm install --silent \
	&& chown -R node:node /opt/app/node_modules
USER node
EXPOSE 3000
