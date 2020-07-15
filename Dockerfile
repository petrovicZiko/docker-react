# First stage, as sluzi kao tag za ovu fazu
FROM node:alpine as builder

WORKDIR "/app"

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

# Second stage, nginx
# /app/build <-- tu ce biti u kontejneru build fajlovi
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html