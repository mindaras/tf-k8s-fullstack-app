FROM node:20 as builder

WORKDIR /usr/app

COPY ./package.json ./

COPY ./package-lock.json ./

RUN npm ci

COPY . .

ARG VITE_API_URL="http://localhost:8000/api"

ENV VITE_API_URL=$VITE_API_URL

RUN npm run build

FROM nginx

EXPOSE 3000

COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /usr/app/dist /usr/share/nginx/html