FROM node:16

WORKDIR /app

ARG SERVER_URL="http://localhost"
ENV SERVER_URL ${SERVER_URL}

COPY . /app

RUN npm install
RUN npm run build

CMD npx serve -s build
