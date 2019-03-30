FROM node:8.15.1-jessie

ARG DB
ENV DB ${DB}

ARG PORT=8080
ENV PORT ${PORT}

COPY . /app/
WORKDIR /app

RUN npm install

EXPOSE ${PORT}

ENTRYPOINT ["npm"]
CMD ["start"]
