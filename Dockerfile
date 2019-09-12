FROM node

WORKDIR /frontend

RUN npm install -g @quasar/cli

COPY package.json /frontend
RUN yarn

CMD [ "quasar", "dev" ]
