FROM node:alpine as builder
WORKDIR '/usr/src/app'
COPY package.json .
RUN npm install
COPY ./ ./
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
# --from=builder nginx가 빌드 파일을 인식할 수 있게, 컨트롤할 수 있게 해주기 위해 그 파일의 위치는 builder에서 오기 때문에
# 만들어진 경로에 있는 것을 /usr/share/nginx/html 에 붙여넣도록

# nginx 로 운영 배포 성공
