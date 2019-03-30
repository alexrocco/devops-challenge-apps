FROM node:8.15.1-jessie

ARG PORT=5000
ENV PORT=${PORT}

ARG API_HOST
ENV API_HOST=${API_HOST}

COPY . /app/
WORKDIR /app

RUN npm install

EXPOSE ${PORT}

ENTRYPOINT ["npm"]
CMD ["start"]
