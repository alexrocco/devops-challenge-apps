FROM node:8.15.1-jessie

ARG DB_URL
ENV DB=${DB_URL}

ARG port=8080
ENV PORT=${port}

COPY . /app/
WORKDIR /app

RUN npm install

EXPOSE ${PORT}

ENTRYPOINT ["npm"]
CMD ["start"]
